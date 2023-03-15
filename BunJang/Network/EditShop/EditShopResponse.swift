//
//  EditShopResponse.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/14.
//

import Foundation
struct EditShopResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: String
    
    enum CodingKeys: String, CodingKey {
        case isSuccess
        case code
        case message
        case result
    }
}

