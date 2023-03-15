//
//  ResponseFollow.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/15.
//

import Foundation

struct ResponseFollowing: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [FollowingResult]?
}

struct FollowingResult: Codable {
    let userIdx: Int?
    let userProfileImgUrl: String?
    let userName: String?
    let productCount: Int?
    let followerCount: Int?
    let products: [FollowerProduct]?
}

struct FollowerProduct: Codable {
    let productIdx: Int?
    let productImgUrl: String?
    let price: Int?
}
