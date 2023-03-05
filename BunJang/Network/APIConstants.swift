//
//  APIConstants.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/06.
//

import Foundation

struct APIConstants {
    static let baseURL = "http://172.31.11.13"
    static let loginURL = baseURL + "/users/:userIdx"
    static let kakaoLogunURL = baseURL + "/kapi.kakao.com/v2/user/me"
}
