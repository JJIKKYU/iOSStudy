//
//  ViewController.swift
//  MyAlbum
//
//  Created by JJIKKYU on 2020/07/07.
//  Copyright © 2020 JJIKKYU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func hello(_ sender: Any) {
        let alert = UIAlertController(title: "Hello", message: "My first App!", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}

