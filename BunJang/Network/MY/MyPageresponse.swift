//
//  MyPageresponse.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/13.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let mypage = try? JSONDecoder().decode(Mypage.self, from: jsonData)

import Foundation

// MARK: - Mypage
struct MypageResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: MypageResult
}

// MARK: - Result
struct MypageResult: Codable {
    let userIdx: Int?
    let name, profileImgURL: String?
    let avgStar, point, followerCount, followingCount: Int?
    let productList: [ProductList?]

    enum CodingKeys: String, CodingKey {
        case userIdx, name
        case profileImgURL
        case avgStar, point, followerCount, followingCount, productList
    }
}

// MARK: - ProductList
struct ProductList: Codable {
    let productIdx: Int?
    let productImgURL: String?
    let price: Int?
    let productName: String?

    enum CodingKeys: String, CodingKey {
        case productIdx
        case productImgURL
        case price, productName
    }
}
