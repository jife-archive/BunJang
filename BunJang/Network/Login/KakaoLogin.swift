//
//  KakaoLogin.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/16.
//

import Foundation
import Alamofire
struct WelecomeKakaoLogin: Codable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: String?
}


class LoginKakao {
    func sendKakao(code: String, onCompletion: @escaping (WelecomeKakaoLogin) -> Void) {
        let url = APIConstants.baseURL + "/oauth/kakao\(code)"
        AF.request(url, method: .post, encoding: JSONEncoding.default)
            .responseDecodable(of: WelecomeKakaoLogin.self) { response in
                switch response.result {
                case .success(let data):
                    onCompletion(data)
                case .failure(let error):
                    print("카카오 전송에러!: \(error)")
                }
            }
    }
}
