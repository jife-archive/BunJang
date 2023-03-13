//
//  SendJoin.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/13.
//

import Foundation
import Alamofire

class Join{
    func postJoin(parameters: JoinRequest, onCompletion: @escaping (Welcome)->Void){
        let url = APIConstants.baseURL + "/users"
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        AF.request(url, method: .post, parameters: parameters.parameters, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: Welcome.self) { response in
                switch response.result {
                case .success(let data):
                    onCompletion(data)
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
    }
    
}
