//
//  Follow.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/16.
//

import Foundation
import Alamofire
struct FollowingResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message, result: String?
}
struct FollowingRequest: Codable{
    let followerIdx: Int?
}


class following {

    
    
    
    func sendfollow(followingUserIdx: Int,parameters: FollowingRequest , onCompletion: @escaping (FollowingResponse) -> Void) {
        let url = APIConstants.baseURL + "/follows?followingUserIdx=\(followingUserIdx)"
        let headers: HTTPHeaders = ["X-ACCESS-TOKEN": APIConstants.jwt]

        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default,
                   headers: headers)
        .responseDecodable(of: FollowingResponse.self) { response in
            switch response.result {
            case .success(let response):
                onCompletion(response)
                print("팔로잉성공")
            case .failure(let error):
                print("팔로잉에러 : \(error.localizedDescription)")
                debugPrint(error)
            }
        }
    }

}
