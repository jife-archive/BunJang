//
//  Secret.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/10.
//

import Foundation

struct Secret {
    static let jwt = UserDefaults.standard.string(forKey: "jwt")!
    
    static let headerJWT = ["X-ACCESS-TOKEN": jwt]
}
