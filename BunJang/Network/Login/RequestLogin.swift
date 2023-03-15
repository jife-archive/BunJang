//
//  RequestLogin.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/14.
//

import Foundation

struct LoginRequest: Codable{
    let name, phoneNo: String
    
    var parameters: [String: Any] {
         return [
             "name": name,
             "phoneNo": phoneNo,
         ]
     }
}
