//
//  OrderDetailViewModel.swift
//  ProjectTest
//
//  Created by JJIKKYU on 2021/01/03.
//

import Foundation

import RxSwift
import RxRelay

import SwiftyJSON

class OrderDetailViewModel {
    
    let acessToken = UserDefaults.standard.value(forKey: "acess_token")
    let orderListRelay = BehaviorRelay<[Order]>(value: [])
    var listcursor: Int = 0
    
    init() {
        fetchOrderList()
    }
    
    func fetchOrderList() {
        let timestamp = Int(NSDate().timeIntervalSince1970)
        guard let token = acessToken else { return }
        print("\(token)")
        
        var request = URLRequest(url: URL(string: "https://dev-api.truecoupon.io/api/order/orders")!)
        request.httpMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("\(timestamp)", forHTTPHeaderField: "X-Timestamp")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            
            do {
                var orderList: [Order] = []
                let json = try JSON(data: data!)
                for (index, model) in json["response"]["list"] {
                    var order: Order = Order()
                    
                    if let methodName: String = model["receiveMethodName"].string {
                        order.receiveMethodName = methodName
                    }
                    
                    if let menuName: String = model["orderMenus"]["couponMenus"][0]["menuName"].string {
                        order.menuName = menuName
                        print("메뉴이름입니다 \(menuName)")
                    }
                    
                    if let productDesc = model["product"]["productDesc"].string {
                        order.productDesc = productDesc
                    }
                    
                    if let deliveryAddress = model["deliveryAddress"].string {
                        order.deliveryAddress = deliveryAddress
                    }
                    
                    if let orderOccurredAt = model["orderOccurredAt"].string {
                        order.orderOccurredAt = orderOccurredAt
                    }
                    
                    if let totalPayAmt = model["totalPayAmt"].int {
                        order.totalPayAmt = String(totalPayAmt) + "원"
                        print("주문금액입니다 \(totalPayAmt)")
                    }
                    
                    orderList.append(order)
                    
                }
                
                self.orderListRelay.accept(orderList)
            } catch {
                
            }
        })
        
        task.resume()
    }
}


struct Order {
    var receiveMethodName: String?
    var menuName: String?
    var productDesc: String?
    var deliveryAddress: String?
    var orderOccurredAt: String?
    var totalPayAmt: String?
}
