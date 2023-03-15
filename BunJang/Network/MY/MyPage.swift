//
//  MyPage.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/13.
//

import Foundation
import Alamofire


class MyPage{
    func getData(userIdx: Int,onCompletion: @escaping (MypageResult)->Void) {
        let url = APIConstants.baseURL + "/users/mypage/\(userIdx)"
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   headers: nil)
        .responseDecodable(of: MypageResponse.self) { response in
            switch response.result {
                 
            case .success(let response):
                 print("\(response) ")
                onCompletion(response.result)
            case .failure(let error):
                print("마이페이지 연동실패!")
                debugPrint(error)

            }
        }
    }
}
