//
//  RequestJoin.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/13.
//

import Foundation

struct JoinRequest: Codable {
    let name: String?
    let phoneNo: String?
    let birthday: String?
    
    var parameters: [String: Any] {
        var params = [String: Any]()
        if let name = name {
            params["name"] = name
        }
        if let phoneNo = phoneNo {
            params["phoneNo"] = phoneNo
        }
        if let birthday = birthday {
            params["birthday"] = birthday
        }
        return params
    }
}

