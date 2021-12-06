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
    @IBOutlet weak var numberLabel: UILabel!
        
    var customers : [Customer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabel()
        
//        saveBasicTypes()
        saveCustomers()
        fetchCustomers()
        
        // Update, Delete
//        updateBasicTypes()
//        deleteBasicTypes()
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
    
    func updateCustomers() {
        guard customers.isEmpty == false else { return }
        
        customers[0].name = "min"
        
        let dictionary = customers.map { $0.toDictionary }
        db.updateChildValues(["customers":dictionary])
    }
    
    func deleteCustomers() {
        db.child("customers").removeValue()
    }

    @IBAction func createCustomer(_ sender: Any) {
        saveCustomers()
    }
    
    @IBAction func readCustomer(_ sender: Any) {
        fetchCustomers()
    }
    
    @IBAction func updateCustomer(_ sender: Any) {
        updateCustomers()
    }
    
    @IBAction func deleteCustomer(_ sender: Any) {
        deleteCustomers()
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

// MARK: Read(Fetch) Data
extension ViewController {
    func fetchCustomers() {
        
        
        db.child("customers").observeSingleEvent(of: .value) { snapShot in
            print("--> \(snapShot.value)")
            
            do {
                let data = try JSONSerialization.data(withJSONObject: snapShot.value, options: [])
                let decoder = JSONDecoder()
                let customers : [Customer] = try decoder.decode([Customer].self, from: data)
                self.customers = customers
                
                DispatchQueue.main.async {
                    self.numberLabel.text = "\(customers.count)"
                }
                
            } catch let error {
                print("---> error : \(error)")
            }
            
            
        }
    }
}

extension ViewController {
    func updateBasicTypes() {
        db.updateChildValues(["int" : 6])
        db.updateChildValues(["double" : 5.4])
        db.updateChildValues(["str" : "변경된 스트링"])
    }
    
    func deleteBasicTypes() {
        db.child("int").removeValue()
        db.child("double").removeValue()
        db.child("str").removeValue()
    }
}

struct Customer : Codable {
    let id : String
    var name : String
    let books : [Book]
    
    var toDictionary : [String : Any] {
        let booksArray = books.map { $0.toDictionary }
        let dict : [String : Any] = ["id" : id, "name" : name, "books" : booksArray]
        return dict
    }
    
    static var id : Int = 0
}

struct Book : Codable {
    let title : String
    let author : String
    
    var toDictionary : [String : Any] {
        let dict : [String : Any] = ["title": title, "author":author]
        return dict
    }
}
