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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // DetailViewController 데이터 전송
        if segue.identifier == "ShowDetail" {
            let vc = segue.destination as? DetailViewController
            
            if let index = sender as? Int {
                
                let bountyInfo = bountyInfoList[index]
                
                vc?.bountyInfo = bountyInfo
            }
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // UITableView DataSource    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bountyInfoList.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell else {
            // 캐스팅이 안 된 경우
            return UITableViewCell()
        }
        
        let bountyInfo = bountyInfoList[indexPath.row]
        
        cell.imageView?.image = bountyInfo.image
        cell.NameLabel.text = bountyInfo.name
        cell.BountyLabel.text = "\(bountyInfo.bounty)"
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
    
    func ListCell() {
        
    }
}


struct BountyInfo {
    let name : String
    let bounty : Int
    
    var image : UIImage? {
        return UIImage(named: "\(name).jpg")
    }
    
    init(name: String, bounty: Int) {
        self.name = name
        self.bounty = bounty
    }
}
