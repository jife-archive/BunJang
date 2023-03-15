//
//  GiveHeart.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/15.
//

import Foundation
import Alamofire
struct SendHeartResult: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: Int?
}
struct SendHeartRequest: Codable {
    let userIdx: Int
  
}

class giveHeart {
    let headers: HTTPHeaders = ["X-ACCESS-TOKEN": APIConstants.jwt]

    func sendHeart(productIdx: Int, parameters: SendHeartRequest, onCompletion: @escaping (SendHeartResult)->Void){
        let url = APIConstants.baseURL + "/favorites?productIdx=\(productIdx)"
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers)
            .responseDecodable(of: SendHeartResult.self) { response in
                switch response.result {
                case .success(let data):
                    onCompletion(data)
                case .failure(let error):
                    print("하트 전송에러!: \(error)")
                }
            }
    }
    
}
