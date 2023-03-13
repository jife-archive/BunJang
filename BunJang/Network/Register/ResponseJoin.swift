//
//  ResponseJoin.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/13.
//

import Foundation

struct Welcome: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: JoinResult
}

// MARK: - Result
struct JoinResult: Codable {
    let userIdx: Int
    let name, phoneNo: String
    let birthday: Int
    let jwt, resultMessage: String
}
