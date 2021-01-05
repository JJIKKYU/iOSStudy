//
//  OrderDetailVC.swift
//  ProjectTest
//
//  Created by JJIKKYU on 2021/01/03.
//

import UIKit

import RxSwift
import RxCocoa

class OrderDetailVC: UIViewController {
    
    let viewModel = OrderDetailViewModel()
    var disposbag = DisposeBag()

    @IBOutlet weak var orderDetailTableView: UITableView! {
        didSet {
            orderDetailTableView.rowHeight = 154
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        orderDetailTableView.delegate = self
        orderDetailTableView.dataSource = self
        
        self.viewModel.orderListRelay
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] value in
                if value.count > 0 {
                    self?.orderDetailTableView.reloadData()
                }
                
            })
            .disposed(by: disposbag)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension OrderDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.orderListRelay.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderListCell", for: indexPath) as! OrderListCell
        
        let index: Int = indexPath.row
        let model = self.viewModel.orderListRelay.value[index]
        
        cell.receiveMethodLabel.text  = model.receiveMethodName
        cell.menuNameLabel.text = model.menuName
        cell.menuDescLabel.text = model.productDesc
        cell.addressLabel.text = model.deliveryAddress
        cell.totalPriceLabel.text = model.totalPayAmt
        cell.orderTimeLabel.text = model.orderOccurredAt
        
        
        return cell
    }
    
    
}
