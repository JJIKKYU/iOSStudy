//
//  main.swift
//  Algorithm
//
//  Created by JJIKKYU on 2021/01/05.
//

import Foundation

func atmSolution() -> Int {
    // 줄을 선 사람 수 입력
    let n = Int(readLine()!)!
    // 줄 선 사람마다 소요되는 시간 입력
    var people = readLine()!.split(separator: " ").map { Int($0)!}
    // 먼저 소팅
    people = people.sorted()
    
    var result: Int = 0
    for (index, value) in people.enumerated() {
        result += value * (n - index)
    }
    
    return result
}

