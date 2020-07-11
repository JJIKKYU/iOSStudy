//
//  BountyViewController.swift
//  BountyList
//
//  Created by JJIKKYU on 2020/07/11.
//  Copyright © 2020 JJIKKYU. All rights reserved.
//

import UIKit

class BountyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MVVM

    // Model
    // - BountyInfo
    // > BountyInfo 만들자
    
    // View
    // - ListCell
    // > ListCell 필요한 정보를 ViewModel한테서 받아야겠다
    // > ListCell은 ViewModel로 부터 받은 정보로 뷰 업데이트 하기
    
    // ViewModel
    // - BountyViewModel
    // - BountyViewModel을 만들고, 뷰레이어에서 필요한 메서드 만들기
    // > 모델 가지고 있기 ,, BountyInfo 들
    
    let viewModel = BountyViewModel()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // DetailViewController 데이터 전송
        if segue.identifier == "ShowDetail" {
            let vc = segue.destination as? DetailViewController
            
            if let index = sender as? Int {
                
                let bountyInfo = viewModel.bountyInfo(at: index)
                vc?.viewModel.update(model: bountyInfo)
            }
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // UITableView DataSource    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numOfBountyInfoList;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell else {
            return UITableViewCell()
        }
        
        let bountyInfo = viewModel.bountyInfo(at: indexPath.row)
        cell.update(info: bountyInfo)
        return cell
    }
    
    // UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "ShowDetail", sender: indexPath.row)
        
        print("--> \(indexPath.row)")
    }
}

class ListCell : UITableViewCell {
    @IBOutlet weak var ImageView : UIImageView!
    @IBOutlet weak var NameLabel : UILabel!;
    @IBOutlet weak var BountyLabel : UILabel!;
    
    func update(info: BountyInfo) {
        self.imageView?.image = info.image
        self.NameLabel.text = info.name
        self.BountyLabel.text = "\(info.bounty)"
    }
}

class BountyViewModel {
    let bountyInfoList : [BountyInfo] = [
        BountyInfo(name: "brook", bounty: 33000),
        BountyInfo(name: "chopper", bounty: 500),
        BountyInfo(name: "franky", bounty: 4400),
        BountyInfo(name: "luffy", bounty: 30000),
        BountyInfo(name: "nami", bounty: 160000),
        BountyInfo(name: "robin", bounty: 80000),
        BountyInfo(name: "sanji", bounty: 70000),
        BountyInfo(name: "zoro", bounty: 120000),
    ]
    
    var sortedList : [BountyInfo] {
        let sortedList = bountyInfoList.sorted { prev, next in
            return prev.bounty > next.bounty
        }
        return sortedList
    }
    
    var numOfBountyInfoList : Int {
        return bountyInfoList.count
    }
    
    func bountyInfo(at index: Int) -> BountyInfo {
        return sortedList[index]
    }
    
}
