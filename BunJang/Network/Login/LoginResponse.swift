//
//  LoginResponse.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/13.
//

import Foundation
struct LoginResponse: Decodable {
    var code: String
    var message: String
    var jwt: String
}
