//
//  main.swift
//  Algorithm
//
//  Created by JJIKKYU on 2021/01/05.
//

import Foundation

func coinSolution() -> Int {
    let temp = readLine()!.split(separator: " ").map({Int($0)!})
    let n = temp[0]
    var k = temp[1]
    
    var coins = [Int]()
    var result: Int = 0
    
    for _ in 0..<n{
        coins.append(Int(readLine()!)!)
    }
    
    coins = coins.reversed()
    
    for value in coins{
        if value <= k{
            result += (k / value)
            k = (k % value)
        }
        if k == 0{
            break
        }
    }
    
    return result
}
