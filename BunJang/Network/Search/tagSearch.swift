//
//  tagSearch.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/15.
//

import Foundation
import Alamofire

struct tagSearchResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [tagResult]?
}

// MARK: - Result
struct tagResult: Codable {
    let productIdx: Int?
    let productImgURL: String?
    let price: Int?
    let productName: String?
    let isFavorite: Int?
}

class tagSearch {
    
    func SearchTag(tag: String, onCompletion: @escaping ([tagResult])->Void)
    {
        let url = APIConstants.baseURL + "/products?tag=\(tag)"
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   headers: nil)
        .responseDecodable(of: tagSearchResponse.self) { response in
            switch response.result {
                
            case .success(let response):
                onCompletion(response.result!)
            case .failure(let error):
                print("태그검색에러! : \(error.localizedDescription)")
                debugPrint(error)

            }
        }
    }
    
}
