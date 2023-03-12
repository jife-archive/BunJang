//
//  GetChatList.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/13.
//

import Foundation
import Alamofire


class MyChat{
    func getChatList(UseIdx: Int, onCompletion: @escaping ([ChatResult])->Void)
    {
        let url = APIConstants.baseURL + "/chats/chatList?userIdx=\(UseIdx)"
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   headers: nil)
        .responseDecodable(of: MychatResponse.self) { response in
            switch response.result {
                
            case .success(let response):
                //print("\(response) ")
                onCompletion(response.result)
            case .failure(let error):
                print("Get Error : \(error.localizedDescription)")
                debugPrint(error)

            }
        }
    }
    func getDetailChat(Chatroom:Int,onCompletion: @escaping ([DetailChat])->Void){
        let url = APIConstants.baseURL + "/chats/\(Chatroom)"
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   headers: nil)
        .responseDecodable(of: DetailChatResponse.self) { response in
            switch response.result {
                
            case .success(let response):
                //print("\(response) ")
                onCompletion(response.result)
            case .failure(let error):
                print("Get Error : \(error.localizedDescription)")
                debugPrint(error)

            }
        }
    }
}
