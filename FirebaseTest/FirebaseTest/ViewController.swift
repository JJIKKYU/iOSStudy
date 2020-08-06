//
//  ViewController.swift
//  FirebaseTest
//
//  Created by JJIKKYU on 2020/08/06.
//  Copyright © 2020 JJIKKYU. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    let db = Database.database().reference()

    @IBOutlet weak var dataLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateLabel()
    }
    
    func updateLabel() {
        db.child("firstData").observeSingleEvent(of: .value) { snapshot in
            print(snapshot)
            let value = snapshot.value as? String ?? ""
            DispatchQueue.main.async {
                self.dataLabel.text = value
            }
            
            
        }
    }


}

