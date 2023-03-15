//
//  SendEditShop.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/14.
//

import Foundation
import Alamofire

class SendEdit {
    func editShop(userIdx: Int, request: EditRequest, onCompletion: @escaping (EditShopResponse) -> Void) {
            
        let url = "http://dev.rising-bunjang.store:9000/users/:\(userIdx)"
        let headers: HTTPHeaders = ["X-ACCESS-TOKEN": "eyJ0eXBlIjoiand0IiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VySWR4IjoxNiwiaWF0IjoxNjc4Nzk0OTIyLCJleHAiOjE2ODAyNjYxNTB9.DFYjZWHgr4BxCgSLi15FEqk0_EV5-gNZNnX_DmL8qZA"]
        
        AF.request(url, method: .patch, parameters: request.parameters, headers: ["X-ACCESS-TOKEN" : APIConstants.jwt]).responseDecodable(of: EditShopResponse.self) { response in
            
            switch response.result {
            case .success(let response):
                onCompletion(response)
                print("편집성공")
            case .failure(let error):
                print("에러!편집에러")
                debugPrint(error)
            }
        }
    }

}
