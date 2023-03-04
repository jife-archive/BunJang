//
//  File.swift
//  rising
//
//  Created by 최지철 on 2023/02/28.
//

import Foundation

class LoginInfo{
    static let shared = LoginInfo()
    
    var state: Bool?
    var name: String?
    var Id: String?
    var age: Int?
    var LoginType: String?
}
