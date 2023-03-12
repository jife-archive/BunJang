//
//  ItemListResponse.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/12.
//

import Foundation

 struct ItemListResponse: Codable {
     let isSuccess: Bool
     let code: Int
     let message: String
     let result: [ItemListResult]
 }

 // MARK: - Result
 struct ItemListResult: Codable {
     let productIdx: Int
     let productImgURL: String?
     let price: Int
     let productName: String

     enum CodingKeys: String, CodingKey {
         case productIdx
         case productImgURL = "productImgUrl"
         case price, productName
     }
 }
