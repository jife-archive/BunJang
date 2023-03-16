struct DetailItem: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: Result
}

// MARK: - Result
struct Result: Codable {
    let getProductInfoRes: GetProductInfoRes
    let getShopRes: GetShopRes
}

// MARK: - GetProductInfoRes
struct GetProductInfoRes: Codable {
    let productIdx, isFavorite, price: Int
    let productName: String
    let count: Int
    let productStatus, isExchange, description, date: String
    let saleStatus: String
    let subCategoryIdx: Int
    let subCategoryName: String
    let userIdx, chatCount, favoriteCount: Int
    let productImgs: [ProductImg]
    let tags: [Tag]
}

// MARK: - ProductImg
struct ProductImg: Codable {
    let productImgURL: String?

    enum CodingKeys: String, CodingKey {
        case productImgURL
    }
}

// MARK: - Tag
struct Tag: Codable {
    let tag: String
}

// MARK: - GetShopRes
struct GetShopRes: Codable {
    let reviews: [Review]
    let products: [Product]
    let getShopInfo: GetShopInfo
}

// MARK: - GetShopInfo
struct GetShopInfo: Codable {
    let userIdx: Int
    let name: String
    let  followerCount, productCount, reviewCount: Int
    let isFollowing: Int
    let avgStar: Double
}

// MARK: - Product
struct Product: Codable {
    let productIdx: Int
    let productImgUrl: String?
    let price: Int
    let productName: String
    let isFavorite: Int

    enum CodingKeys: String, CodingKey {
        case productIdx
        case productImgUrl
        case price, productName, isFavorite
    }
}

// MARK: - Review
struct Review: Codable {
    let reviewIdx: Int
    let star: Double?
    let content: String?
    let reviewImgURL: String?
    let reviewImgCount: Int?
    let userName, date: String?

    enum CodingKeys: String, CodingKey {
        case reviewIdx, star, content
        case reviewImgURL
        case reviewImgCount, userName, date
    }
}
