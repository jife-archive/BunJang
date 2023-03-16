//
//  APIConstants.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/06.
//

import Foundation
import Alamofire

struct APIConstants {
    static let baseURL = "http://dev.rising-bunjang.store:9000"
    static let loginURL = baseURL + "/users/:userIdx"
    static let kakaoLogunURL = baseURL + "/kapi.kakao.com/v2/user/me"
    static let jwt = UserDefaults.standard.string(forKey: "jwt")!
    static let headerJWT = ["X-ACCESS-TOKEN": jwt]
    static let dummyimg = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKM-HmC5GK0-l6OxCAD37mKJ-2d28QRgRQxA&usqp=CAU"
}
class HomeItemList {
    
    func getData(onCompletion: @escaping ([ItemListResult])->Void) {
        let url = APIConstants.baseURL + "/products/home"
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   headers: nil)
        .responseDecodable(of: ItemListResponse.self) { response in
            switch response.result {
                
            case .success(let response):
                onCompletion(response.result)
            case .failure(let error):
                print("Get Error : \(error.localizedDescription)")
                
            }
        }
    }
    func getDetail(productIdx: Int, onCompletion: @escaping (DetailItem) -> Void) {
        AF.request(APIConstants.baseURL + "/products/\(productIdx)", method: .get, parameters: nil, headers: nil)
            .validate()
            .responseDecodable(of: DetailItem.self) { response in
                switch response.result {
                case .success(let data):
                    onCompletion(data)
                case .failure(let error):
                    print(error.localizedDescription)
                    debugPrint(error)
                }
        }
    }

}

