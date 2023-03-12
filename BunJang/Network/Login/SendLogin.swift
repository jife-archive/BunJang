//
//  SendLogin.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/13.
//

import Foundation
import Alamofire

class sendLogin{
    func sendKakao(token: String, onCompletion: @escaping (LoginResponse) -> Void){
        let url = APIConstants.baseURL + "/oauth/kakao/\(token)"
        
        AF.request(url, method: .get)
            .validate().responseDecodable(of: LoginResponse.self) { response in
                switch response.result {
                    case .success(let data):
                        onCompletion(data)
                    case .failure(let error):
                        print(error)
                        debugPrint(error)
                        print("에러!카카오")

                }
            }
    }
}
