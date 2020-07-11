//
//  BountyViewController.swift
//  BountyList
//
//  Created by JJIKKYU on 2020/07/11.
//  Copyright © 2020 JJIKKYU. All rights reserved.
//

import UIKit

class BountyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let NameList = ["brook", "chopper", "franky", "luffy", "nami", "robin", "sanji", "zoro"]
    let BountyList = [330000, 50, 440000, 300000, 160000, 800000, 770000, 120000]
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // UITableView DataSource    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BountyList.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell else {
            // 캐스팅이 안 된 경우
            return UITableViewCell()
        }
        
        let img = UIImage(named: "\(NameList[indexPath.row]).jpg")
        cell.imageView?.image = img
        cell.NameLabel.text = NameList[indexPath.row]
        cell.BountyLabel.text = "\(BountyList[indexPath.row])"
        return cell
    }
    
    // UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "ShowDetail", sender: nil)
        
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
