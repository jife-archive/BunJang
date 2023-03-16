//
//  CategorySearch.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/15.
//

import Foundation
import Alamofire

struct CategoryResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [CategoryResult]?
}

// MARK: - Result
struct CategoryResult: Codable {
    let productIdx: Int?
    let productImgURL: String?
    let price: Int?
    let productName: String?
}

class SearchCategory {
    func getCategory(categoryIdx: Int, sort: String, onCompletion: @escaping ([CategoryResult])->Void)
        {
            let url = APIConstants.baseURL + "/products/category/\(categoryIdx)?sort=\(sort)"
            AF.request(url,
                       method: .get,
                       parameters: nil,
                       headers: nil)
            .responseDecodable(of: CategoryResponse.self) { response in
                switch response.result {
                    
                case .success(let response):
                    print(response.isSuccess)
                    print(response.code)
                    print(response.message)

                    onCompletion(response.result!)
                    
                case .failure(let error):
                    print("카테고리검색에러! : \(error.localizedDescription)")
                    debugPrint(error)

                }
            }
        }
}

