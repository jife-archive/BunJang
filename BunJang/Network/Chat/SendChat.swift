//
//  SendChat.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/14.
//

import Foundation
import Alamofire

struct SendChats: Codable {
    let message: String
    let chatRoomIdx: Int
}

struct SendChatsResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: SendChatsResponseResult?
}

// MARK: - Result
struct SendChatsResponseResult: Codable {
    let chatRoomIdx: Int?
    let message, updateAt: String?
}

class sendMessage {
    func giveMessage(userIdx: Int, parameters: SendChats, onCompletion: @escaping (SendChatsResponse)->Void){
        let url = APIConstants.baseURL + "/chats?userIdx=\(userIdx)"
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: nil)
            .responseDecodable(of: SendChatsResponse.self) { response in
                switch response.result {
                case .success(let data):
                    onCompletion(data)
                case .failure(let error):
                    print("메시지 전송에러!: \(error)")
                }
            }
    }
}
