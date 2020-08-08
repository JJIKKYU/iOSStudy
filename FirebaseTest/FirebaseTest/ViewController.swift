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
        updateLabel()
        
//        saveBasicTypes()
        saveCustomers()
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


extension ViewController {
    func saveBasicTypes() {
        // Firebase chikd ("key").setValue(Value)
        // - String, number, dicionary, array
        
        db.child("int").setValue(3)
        db.child("double").setValue(3.5)
        db.child("str").setValue("string value = 안녕")
        db.child("array").setValue(["a", "b", "c", "d"])
        db.child("dict").setValue(["id":"anyID", "age":10, "city":"seoul"])
    }
    
    func saveCustomers() {
        // 책가게
        // 사용자를 저장하겠다
        // 모델 Customer + Book
        
        let books = [Book(title: "Good to Greate", author: "Someone"), Book(title: "Hacking Growth", author: "Somebody")]
        let customer1 = Customer(id: "\(Customer.id)", name: "Son", books: books)
        Customer.id += 1
        let customer2 = Customer(id: "\(Customer.id)", name: "Dele", books: books)
        Customer.id += 1
        let customer3 = Customer(id: "\(Customer.id)", name: "KKYU", books: books)
        
        db.child("customers").child(customer1.id).setValue(customer1.toDictionary)
        db.child("customers").child(customer2.id).setValue(customer2.toDictionary)
        db.child("customers").child(customer3.id).setValue(customer3.toDictionary)
    }
}

struct Customer {
    let id : String
    let name : String
    let books : [Book]
    
    var toDictionary : [String : Any] {
        let booksArray = books.map { $0.toDictionary }
        let dict : [String : Any] = ["id" : id, "name" : name, "books" : booksArray]
        return dict
    }
    
    static var id : Int = 0
}

struct Book {
    let title : String
    let author : String
    
    var toDictionary : [String : Any] {
        let dict : [String : Any] = ["title": title, "author":author]
        return dict
    }
}
