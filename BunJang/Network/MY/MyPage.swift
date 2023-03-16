//
//  MyPage.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/13.
//

import Foundation
import Alamofire

// MARK: - Mypage// MARK: - Result
struct MyResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: MyResponseResult
}

// MARK: - Result
struct MyResponseResult: Codable {
    let userIdx: Int
    let name: String
    let profileImgURL: String?
    let avgStar: Double
    let point, followerCount, followingCount: Int
    let productList: [ProductList]
}

// MARK: - ProductList
struct ProductList: Codable {
    let productIdx: Int
    let productImgURL: String?
    let price: Int
    let productName: String?
    let isFavorite: Int
}

class MyPage {
    func getData(userIdx: Int, onCompletion: @escaping (MyResponseResult) -> Void) {
        let headers: HTTPHeaders = ["X-ACCESS-TOKEN": APIConstants.jwt]
        let url = APIConstants.baseURL + "/users/mypage/\(userIdx)"
        
        AF.request(url, method: .get, parameters: nil, headers: headers)
            .responseDecodable(of: MyResponse.self) { response in
                switch response.result {
                case .success(let response):
                    print("\(response)")
                    onCompletion(response.result)
                case .failure(let error):
                    print("마이페이지 연동실패!")
                    debugPrint(error)
                }
            }
    }
}
