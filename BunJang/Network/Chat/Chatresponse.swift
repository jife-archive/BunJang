//
//  Chatresponse.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/13.
//


import Foundation

// MARK: - Mychat
struct MychatResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [ChatResult]?
}

// MARK: - Result
struct ChatResult: Codable {
    let userIdx1, userIdx2: Int
    let chatRoomIdx, name: String
    let profileImgURL: String?
    let lastMessage, updateDate: String
}
struct DetailChatResponse: Codable  {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [DetailChat]
}

// MARK: - Result
struct DetailChat: Codable  {
    let name: String?
    let avgStar: Double?
    let saleCount, userIdx: Int?
    let message, updateAt: String?
}
struct DeletChatResponse: Codable{
    let isSuccess: Bool?
     let code: Int?
     let message: String?
     var result: String?
}
struct DeleteChat: Codable {
    let userIdx1: Int?
    let userIdx2: Int?
    let chatRoomIdx: Int?
    let name: String?
    let profileImgUrl: String?
    let message: String?
    let updateAt: String?
    
}
