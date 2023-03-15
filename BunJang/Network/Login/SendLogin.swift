//
//  SendLogin.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/13.
//

import Foundation
import Alamofire

class sendLogin{
    func sendKakao(token: String, onCompletion: @escaping (KakaoLoginResponse) -> Void){
        let url = APIConstants.baseURL + "/oauth/kakao/\(token)"
        
        AF.request(url, method: .post)
            .validate().responseDecodable(of: KakaoLoginResponse.self) { response in
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
    
    func sendSelfLogin(parameters: LoginRequest, onCompletion: @escaping (WelcomeLogin)->Void){
        let url = APIConstants.baseURL + "/users/logIn"
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        AF.request(url, method: .post, parameters: parameters.parameters, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: WelcomeLogin.self) { response in
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
