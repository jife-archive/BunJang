//
//  EditShop.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/16.
//

import Foundation
import Alamofire

struct EditResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message, result: String
}
struct RequestEdit: Codable {
    let profileImgUrl: String
    let shopDescription: String
    let name: String
    
}

class Edit {
    let headers: HTTPHeaders = ["X-ACCESS-TOKEN": APIConstants.jwt]

    func sendEdit(userIdx: Int, parameters: RequestEdit, onCompletion: @escaping (EditResponse)->Void){
        let url = APIConstants.baseURL + "/users/\(userIdx)"
        AF.request(url, method: .patch, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers)
            .responseDecodable(of: EditResponse.self) { response in
                switch response.result {
                case .success(let data):
                    onCompletion(data)
                case .failure(let error):
                    print("편집 취소에러!: \(error)")
                }
            }
    }
}
