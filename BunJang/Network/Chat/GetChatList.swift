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
    {        let headers: HTTPHeaders = ["X-ACCESS-TOKEN": APIConstants.jwt]

        let url = APIConstants.baseURL + "/chats/chatList?userIdx=\(UseIdx)"
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   headers: headers)
        .responseDecodable(of: MychatResponse.self) { response in
            switch response.result {
                
            case .success(let response):


                onCompletion(response.result!)
            case .failure(let error):
                print("Get Error : \(error.localizedDescription)")
                debugPrint(error)

            }
        }
    }
    func getDetailChat(chatRoomIdx:Int, userIdx:Int, onCompletion: @escaping ([DetailChat])->Void){
        let url = APIConstants.baseURL + "/chats/\(chatRoomIdx)?userIdx=\(userIdx)"
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   headers: nil)
        .responseDecodable(of: DetailChatResponse.self) { response in
            switch response.result {
                
            case .success(let response):
                 print("\(response) ")
                onCompletion(response.result)
            case .failure(let error):
                print("Get Error : \(error.localizedDescription)")
                debugPrint(error)

            }
        }
    }
    func deleteChat(chatRoomIdx: Int, onCompletion: @escaping (DeletChatResponse) -> Void) {
        let url = APIConstants.baseURL + "/chats/\(chatRoomIdx)/status"
        
        AF.request(url, method: .patch, parameters: [:], headers: nil)
            .responseDecodable(of: DeletChatResponse.self) { response in
                switch response.result {
                case .success(let response):
                    var updatedResponse = response
                    print(response)
                    updatedResponse.result = "대화 내용이 모두 삭제됩니다."
                    onCompletion(updatedResponse)
                case .failure(let error):
                    debugPrint(error)
                }
            }
    }

    
}
