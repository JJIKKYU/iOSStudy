//
//  DetailViewController.swift
//  BountyList
//
//  Created by JJIKKYU on 2020/07/11.
//  Copyright © 2020 JJIKKYU. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var ImageView : UIImageView!
    @IBOutlet weak var NameLabel : UILabel!;
    @IBOutlet weak var BountyLabel : UILabel!;
    
    var Name : String?
    var Bounty : Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        UpdateUI()
    }
    
    func UpdateUI() {
        
        if let name = self.Name, let bounty = self.Bounty {
            let img = UIImage(named: "\(name).jpg")
            ImageView.image = img
            NameLabel.text = name
            BountyLabel.text = "\(bounty)"
        }
        
        
    }
    
    @IBAction func Close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
