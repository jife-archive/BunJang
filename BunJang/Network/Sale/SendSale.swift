//
//  SendSale.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/14.
//

import Foundation
import Alamofire

struct SaleRequest: Codable {
    let userIdx: Int
    let productImgs: [String]
    let productName: String
    let subCategoryIdx: Int
    let tags: [String]
    let price: Int
    let description: String
    let count: Int
    let productStatus: String
    let isExchange: String

    var parameters: [String: Any] {
         return [
             "userIdx": userIdx,
             "productImgs": productImgs,
             "productName": productName,
             "subCategoryIdx": subCategoryIdx,
             "tags": tags,
             "price": price,
             "description": description,
             "count": count,
             "productStatus": productStatus,
             "isExchange": isExchange,
         ]
     }
}
struct SaleResult: Codable {
    let productIdx: Int

    enum CodingKeys: String, CodingKey {
        case productIdx = "productIdx"
    }
}

struct SaleResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: SaleResult

    enum CodingKeys: String, CodingKey {
        case isSuccess = "isSuccess"
        case code = "code"
        case message = "message"
        case result = "result"
    }
}

    class SendSale {
        func postSale(saleRequest: SaleRequest, onCompletion: @escaping (SaleResponse) -> Void) {
            let url = APIConstants.baseURL + "/products"
            let headers: HTTPHeaders = ["X-ACCESS-TOKEN": APIConstants.jwt]

            AF.request(url, method: .post, parameters: saleRequest.parameters, encoding: JSONEncoding.default, headers: headers)
                .responseDecodable(of: SaleResponse.self) { response in
                    switch response.result {
                    case .success(let data):
                        onCompletion(data)
                    case .failure(let error):
                        print("상품등록실패!")
                        print("Error: \(error)")
                    }
                }
        }
    }

