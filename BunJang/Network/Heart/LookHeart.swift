//
//  LookHeart.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/15.
//

import Foundation
import Alamofire

struct LookHeartResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [LookHeartResult]?
}

// MARK: - Result
struct LookHeartResult: Codable {
    let favoriteIdx, productIdx: Int?
    let productImgURL: String?
    let productName: String?
    let price: Int?
    let saleStatus, userName, date: String?
}

class LookHeart {
    func SearchTag(userIdx: Int, onCompletion: @escaping ([LookHeartResult])->Void)
    {
        let url = APIConstants.baseURL + "/favorites?userIdx=\(userIdx)"
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   headers: nil)
        .responseDecodable(of: LookHeartResponse.self) { response in
            switch response.result {
                
            case .success(let response):
                onCompletion(response.result!)
            case .failure(let error):
                print("하트조회에러! : \(error.localizedDescription)")
                debugPrint(error)

            }
        }
    }
}
