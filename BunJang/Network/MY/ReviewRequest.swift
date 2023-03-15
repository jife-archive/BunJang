//
//  ReviewRequest.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/15.
//

import Foundation
import Alamofire

class getReview {
    
    func Review(userIdx: Int, onCompletion: @escaping (ReviewResult) -> Void) {
        let url = APIConstants.baseURL + "/reviews?userIdx=\(userIdx)"

        AF.request(url,
                   method: .get,
                   parameters: nil,
                   headers: nil)
        .responseDecodable(of: ReponseReview.self) { response in
            switch response.result {
                
            case .success(let response):
                onCompletion(response.result!)
            case .failure(let error):
                print("리뷰에러 : \(error.localizedDescription)")
                debugPrint(error)
                
            }
        }
    }
}
