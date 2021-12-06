//
//  BountyInfo.swift
//  BountyList
//
//  Created by JJIKKYU on 2020/07/12.
//  Copyright © 2020 JJIKKYU. All rights reserved.
//

import UIKit

struct BountyInfo {
    let name : String
    let bounty : Int
    
    var image : UIImage? {
        return UIImage(named: "\(name).jpg")
    }
    
    init(name: String, bounty: Int) {
        self.name = name
        self.bounty = bounty
    }
}
