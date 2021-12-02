//
//  ViewController.swift
//  RxswiftMVVM
//
//  Created by 정진균 on 2021/12/02.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    private let viewModel = ViewModel()
    private var disposeBag = DisposeBag()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        searchBar
            .rx.text
            .orEmpty
            .debounce(.milliseconds(5), scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .distinctUntilChanged() // 새로운 값이 이전과 같은지 확인
            .filter { !$0.isEmpty }
            .subscribe(onNext: { [weak self] query in
                self?.viewModel.shownCities = (self?.viewModel.allCities.filter { $0.hasPrefix(query) })!
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }


}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.shownCities.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityPrototypeCell", for: indexPath)
        cell.textLabel?.text = viewModel.shownCities[indexPath.row]
        
        return cell
    }
    
    
}
