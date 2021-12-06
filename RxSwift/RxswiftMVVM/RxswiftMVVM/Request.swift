//
//  Request.swift
//  RxswiftMVVM
//
//  Created by 정진균 on 2021/12/02.
//

import Foundation
import RxSwift

public enum RequestType: String {
    case GET
    case POST
    case PU
    case DELETE
}

class APIRequest {
    let baseURL = URL(string: "https://api.printful.com/countries")
    
    var method = RequestType.GET
    var parameters = [String: String]()
    
    func request(with baseURL: URL) -> URLRequest {
        var request = URLRequest(url: baseURL)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
}

class APICalling {
    
    
    func send<T: Codable>(apiRequest: APIRequest) -> Observable<T> {
        return Observable<T>.create { observer in
            let request = apiRequest.request(with: apiRequest.baseURL!)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                do {
                    let model: CountryModel = try JSONDecoder().decode(CountryModel.self, from: data ?? Data())
                    observer.onNext( model.ressult as! T )
                } catch let error {
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
            
        }
    }
    
}
