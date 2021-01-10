//
//  main.swift
//  Algorithm
//
//  Created by JJIKKYU on 2021/01/06.
//

import Foundation

func solution_1541() -> Int {
    let input = readLine()!.split(separator: "-")
    var result: Int = 0
    var tempArr = [Int]()
    
    for char in input {
        var tempSum = 0
        let temp = char.split(separator: "+")
        for item in temp {
            tempSum += Int(item)!
        }
        tempArr.append(tempSum)
    }
    result = tempArr[0]
    for i in 1..<tempArr.count {
        result -= tempArr[i]
    }
    
    return result
}

print(solution_1541())
