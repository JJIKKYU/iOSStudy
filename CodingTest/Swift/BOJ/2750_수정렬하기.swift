//
//  2750_수정렬하기.swift
//  BOJ
//
//  Created by JJIKKYU on 2021/01/05.
//

import Foundation

func solution() -> Int {
    let n = Int(readLine()!)!
    var people = readLine()!.split(separator: " ").map { Int($0)!}
    people = people.sorted()
    
    print(people)
    
    var result: Int = 0
    
    return result
}
