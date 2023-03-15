//
//  RequestFollower.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/15.
//

import Foundation
import Alamofire

class follow {
    func getfollower(userIdx: Int, onCompletion: @escaping (ResponseFollowing) -> Void) {
        let url = APIConstants.baseURL + "/users/\(userIdx)/followings"
        let headers: HTTPHeaders = ["X-ACCESS-TOKEN": APIConstants.jwt]

        AF.request(url,
                   method: .get,
                   parameters: nil,
                   headers: headers)
        .responseDecodable(of: FollowingResult.self) { response in
            switch response.result {
            case .success(let followingResult):
                let response = ResponseFollowing(isSuccess: true, code: 1000, message: "요청에 성공하였습니다.", result: [followingResult])
                onCompletion(response)
            case .failure(let error):
                print("팔로우에러 : \(error.localizedDescription)")
                debugPrint(error)
            }
        }
    }
    }

