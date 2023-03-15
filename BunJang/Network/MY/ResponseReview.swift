//
//  ResponseReview.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/15.
//

import Foundation
struct ReponseReview: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: ReviewResult?
        
}

// MARK: - Result
struct ReviewResult: Codable {
    let reviewCount: Int?
    let getReviewsList: [GetReviewsList]?
}

// MARK: - GetReviewsList
struct GetReviewsList: Codable {
    let userIdx: Int?
    let star: Double?
    let userName, content, reviewImgURL: String?
    let reviewCount: Int?
    let date: String?
    let productIdx: Int?
    let productName: String?
}
