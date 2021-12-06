//
//  HistoryViewController.swift
//  MyNetflix
//
//  Created by JJIKKYU on 2020/08/08.
//  Copyright © 2020 com.joonwon. All rights reserved.
//

import UIKit
import Firebase

class HistoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let db = Database.database().reference().child("history")
    var searchTerms : [SearchTerm] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        db.observeSingleEvent(of: .value) { (snapshot) in
            
            guard let searchHistory = snapshot.value as? [String : Any] else { return }
        
            // 실패할 수도 있으니까 try, 하지만 지금은 명백하니까 느낌표
            let data = try! JSONSerialization.data(withJSONObject: Array(searchHistory.values), options: [])
            
            let decoder = JSONDecoder()
            let searchTerms = try! decoder.decode([SearchTerm].self, from: data)
            
            // 최신 순으로 정렬하기 위해서
            self.searchTerms = searchTerms.sorted(by: { (term1, term2) in
                return term1.timestamp > term2.timestamp
            })
            self.tableView.reloadData()
        
            
            print("\(searchTerms)")
        }
        
    }


}

extension HistoryViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchTerms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as? HistoryCell else { return UITableViewCell() }
        
        cell.searchTerm.text = searchTerms[indexPath.row].term
        
        return cell
    }
}


class HistoryCell : UITableViewCell {
    @IBOutlet weak var searchTerm : UILabel!
}

struct SearchTerm : Codable {
    let term : String
    let timestamp : TimeInterval
}
