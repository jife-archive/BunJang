//
//  SendLogin.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/13.
//

import Foundation
import Alamofire

struct WelecomLogin: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: LoginResult
}

// MARK: - Result
struct LoginResult: Codable {
    let userIdx: Int
    let jwt: String
}


class sendLogin{

    
    func sendSelfLogin(parameters: LoginRequest, onCompletion: @escaping (WelecomLogin)->Void){
        let url = APIConstants.baseURL + "/users/logIn"
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        AF.request(url, method: .post, parameters: parameters.parameters, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: WelecomLogin.self) { response in
                switch response.result {
                case .success(let data):
                    print(data)
                    onCompletion(data)
                case .failure(let error):
                    print("에러!로그인")
                    print("Error: \(error)")
                }
            }
    }
}
