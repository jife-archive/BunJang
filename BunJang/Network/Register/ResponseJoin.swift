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
    let result: JoinResult?

    enum CodingKeys: String, CodingKey {
        case isSuccess, code, message, result
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        isSuccess = try values.decode(Bool.self, forKey: .isSuccess)
        code = try values.decode(Int.self, forKey: .code)
        message = try values.decode(String.self, forKey: .message)
        
        // Check if result exists
        if let resultData = try? values.decode(JoinResult.self, forKey: .result) {
            result = resultData
        } else {
            result = nil
        }
    }
}

// MARK: - Result
struct JoinResult: Codable {
    let userIdx: Int
    let jwt: String

    private enum CodingKeys: String, CodingKey {
        case userIdx = "userIdx"
        case jwt = "jwt"
    }
}
