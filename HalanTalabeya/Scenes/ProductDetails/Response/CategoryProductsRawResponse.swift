//
//  CategoryProductsRawResponse.swift
//  HalanTalabeya
//
//  Created by Maya El Gebeily on 17/08/2026.
//
//TODO: -Done optional and mandatory
struct CategoryProductsRawResponse: Decodable {
    let status: Int
    let message: String
    let data: CategoryProductsData
}

struct CategoryProductsData: Decodable {
    let totalCount: Int
    let products: [RawProduct]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case products
    }
}

struct RawProduct: Decodable {
    let productId: String
    let nameAr: String
    let nameEn: String
    let price: Double
    let cashPriceAfter: Double?
    let cashPriceBefore: Double?
    let originalPrice: Double?
    let discount: Int?
    let image: String?
    let stock: Bool?
    let isPromotion: Bool?
    let sellingUnit: String?
    
    enum CodingKeys: String, CodingKey {
        case productId = "product_id"
        case nameAr = "name_ar"
        case nameEn = "name_en"
        case price
        case cashPriceAfter
        case cashPriceBefore
        case originalPrice
        case discount
        case image
        case stock
        case isPromotion = "is_promotion"
        case sellingUnit = "selling_unit"
    }
}
