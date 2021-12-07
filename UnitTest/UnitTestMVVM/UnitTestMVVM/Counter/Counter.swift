//
//  Counter.swift
//  UnitTestMVVM
//
//  Created by 정진균 on 2021/12/07.
//

import Foundation
import Moya

struct CounterDataModel: Codable {
    var counterDefaultValue: Int
}

struct CounterAPI: TargetType {
    var baseURL: URL {
        URL(string: "[https://swift.org](https://swift.org)")!
    }
    
    var path: String {
        ""
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Task {
        .requestPlain
    }
    
    var headers: [String : String]? {
        nil
    }

}
