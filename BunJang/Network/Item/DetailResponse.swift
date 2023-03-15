// This file was generated from JSON Schema using codebeautify, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome7 = try Welcome7(json)

import Foundation

// MARK: - Welcome7
struct DetailItem: Codable  {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: Result
}

// MARK: - Result
struct Result: Codable  {
    let getProductInfoRes: GetProductInfoRes
    let getShopRes: GetShopRes
    let keywords: [Keyword]?
}

// MARK: - GetProductInfoRes
struct GetProductInfoRes: Codable  {
    let productIdx, price: Int?
    let productName, date, saleStatus: String?
    let subCategoryIdx: Int?
    let subCategoryName: String?
    let userIdx, chatCount, favoriteCount: Int?
    let productImgs: [[String: String?]]
    let keywords: [Keyword]?
}

// MARK: - Keyword
struct Keyword: Codable  {
    let tag: String?
}

// MARK: - GetShopRes
struct GetShopRes: Codable  {
    let reviews: [Review]
    let products: [Product]
    let getShopInfo: GetShopInfo
}

// MARK: - GetShopInfo
struct GetShopInfo: Codable  {
    let userIdx: Int?
    let name: String?
    let avgStar: Double?
    let followerCount, productCount, reviewCount: Int?
}

// MARK: - Product
struct Product: Codable  {
    let productIdx: Int?
    let productImgURL: String?
    let price: Int?
    let productName: String?
}

// MARK: - Review
struct Review: Codable  {
    let reviewIdx, star: Int?
    let content: String?
    let reviewImgURL: String?
    let userName, date: String
    
}
