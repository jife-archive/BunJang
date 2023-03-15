//
//  CancelHeart.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/15.
//

import Foundation
import Alamofire
struct CancelResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: String?
}

class cancelHeart{
    let headers: HTTPHeaders = ["X-ACCESS-TOKEN": APIConstants.jwt]

    func sendHeart(productIdx: Int, parameters: SendHeartRequest, onCompletion: @escaping (CancelResponse)->Void){
        let url = APIConstants.baseURL + "/favorites/status?productIdx=\(productIdx)"
        AF.request(url, method: .patch, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers)
            .responseDecodable(of: CancelResponse.self) { response in
                switch response.result {
                case .success(let data):
                    onCompletion(data)
                case .failure(let error):
                    print("하트 취소에러!: \(error)")
                }
            }
    }
}

