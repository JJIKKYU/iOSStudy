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
    
    // 인증번호 전송
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
    
    /*
     인증번호를 입력할 경우 -> 인증토큰을 전송
     */
    func login(completed: @escaping (String) -> Void) {
        // 하단 작업을 순차적으로 진행
        let dispatch = DispatchGroup()
        dispatch.enter()
        
        ///
        
        let loginString = "StoreUser:client2pwd"
        
        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        
        let certNum = certNumberRelay.value
        
        let phoneNumber: String = "01099992037"
        let timestamp = Int(NSDate().timeIntervalSince1970)
        print(timestamp)
        
        // prepare json data
        let json: [String: Any] = ["loginId": "\(phoneNumber)",
                                   "password": "\(certNum)",
                                   "otp" : "\(certNum)",
                                   "grantType" : "password"]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        var request = URLRequest(url: URL(string: "https://dev-api.truecoupon.io/api/login/user")!)
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("\(timestamp)", forHTTPHeaderField: "X-Timestamp")
        request.addValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        request.setValue(String(jsonData!.count), forHTTPHeaderField: "Content-Length")
        
        request.httpBody = jsonData
        
        var token: String?
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            print(response!)
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                
                if let accessToken = json["access_token"] as? String {
                    print(accessToken)
                    token = accessToken
                    UserDefaults.standard.set(token, forKey: "acess_token")
                }
            } catch {
                print("error")
            }
            dispatch.leave()
        })
        
        dispatch.notify(queue: .main, execute: {
            guard let token = token else { return }
            print("!!!! final: \(token)")
            completed(token)
            
        })
        
        task.resume()
    }
}
