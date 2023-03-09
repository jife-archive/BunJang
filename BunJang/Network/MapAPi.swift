//
//  MapAPi.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/09.
//
import NMapsMap
import CoreLocation
import Alamofire
import SwiftyJSON

class GetApi {
    let Naver_Client = "qzwg5kke32"
    let Naver_Screat_Client = "lwKSn3pYjxsOzgVL4UEZUHoSCu2oKDnFLOJGC6vB"
    let NAVER_GEOCODE_URL = "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query="
    let Reverse_NAVER_GEOCODE_URL = "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc"
    public var here = ""
    public func NaverApi() {
        let encodeAddress = here.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let header1 = HTTPHeader(name: "X-NCP-APIGW-API-KEY-ID", value: Naver_Client)
               let header2 = HTTPHeader(name: "X-NCP-APIGW-API-KEY", value: Naver_Screat_Client)
               let headers = HTTPHeaders([header1,header2])
        print(encodeAddress)
        
        AF.request(NAVER_GEOCODE_URL + encodeAddress, method: .get,headers: headers).validate()
                .responseJSON { response in
                    switch response.result {
                    case .success(let value as [String:Any]):
                        
                        let json = JSON(value)
                         let data = json["addresses"]
                         let lat = data[0]["y"].doubleValue
                         let lon = data[0]["x"].doubleValue
                         let road = data[0]["roadAddress"].stringValue
                         let jibun = data[0]["jibunAddress"].stringValue
                         print("위도는", lat ,"경도는", lon )
                         print("도로명 주소는", road, "지번 주소는", jibun)

                    case .failure(let error):
                        print(error.errorDescription ?? "")
                    default :
                        fatalError()
                    }
                }
    }
    
}
