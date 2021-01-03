//
//  LoginViewModel.swift
//  ProjectTest
//
//  Created by JJIKKYU on 2020/12/31.
//

import Foundation

import RxRelay
import RxSwift

import Alamofire

class LoginViewModel {
    
    let userPhoneNumberRelay = BehaviorRelay<String>(value: "")
    let certNumberRelay = BehaviorRelay<String>(value: "")
    
    init() {
        
    }
    
    func certCall() {
        let phoneNumber: String = "01099992037"
        let timestamp = Int(NSDate().timeIntervalSince1970)
        print(timestamp)
        
        let param = "loginId=\(phoneNumber)&loginType=PHONE_NO"
        let paramData = param.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: "https://dev-api.truecoupon.io/api/login/otp")!)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("\(timestamp)", forHTTPHeaderField: "X-Timestamp")
        request.setValue(String(paramData!.count), forHTTPHeaderField: "Content-Length")
        
        request.httpBody = paramData
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            print(response!)
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                print(json)
            } catch {
                print("error")
            }
        })
        
        task.resume()
    }
    
    func login() {
        print("certNumber: \(certNumberRelay.value)")
        
        let username = "StoreUser"
        let password = "client2pwd"
        let loginString = "\(username):\(password)"

        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        
        
        
        let phoneNumber: String = "01099992037"
        let timestamp = Int(NSDate().timeIntervalSince1970)
        print(timestamp)
        
        let param = "loginId=\(phoneNumber)&password=\(certNumberRelay.value)&otp=\(certNumberRelay.value)&grantType=password"
        let paramData = param.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: "https://dev-api.truecoupon.io/api/login/user")!)
        request.httpMethod = "POST"
    
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("\(timestamp)", forHTTPHeaderField: "X-Timestamp")
//        request.addValue("sso-key \(username):\(password)", forHTTPHeaderField: "Authorization")
        
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        request.setValue(String(paramData!.count), forHTTPHeaderField: "Content-Length")
        
        request.httpBody = paramData
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            print(response!)
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                print(json)
            } catch {
                print("error")
            }
        })
        
        task.resume()
    }
}
