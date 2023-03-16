//
//  UserDetail.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/10.
//

import Foundation

struct UserInfo{
    static let jwt = UserDefaults.standard.string(forKey: "jwt")!
    static let headerJWT = ["X-ACCESS-TOKEN": jwt]
    
}
class getUserInfo{
    static let shared = getUserInfo()
    var userIdx: Int?
    var Join = false
    var UserMessage: String?
    var jwt: String?
    var msg: [String?] = []
    var PayInfo: [String?] = []
    var price: Int?
    private init(){}
}
