//
//  Model.swift
//  RxswiftMVVM
//
//  Created by 정진균 on 2021/12/02.
//

import Foundation

struct CountryModel : Codable {
    let code: Int?
    let ressult: [CountryListModel]?
    
}

struct CountryListModel: Codable {
    let code: String
    let name: String

}
