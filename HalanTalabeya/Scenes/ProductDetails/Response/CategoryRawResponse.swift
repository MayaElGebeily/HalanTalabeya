//
//  CategoryRawResponse.swift
//  HalanTalabeya
//
//  Created by Maya El Gebeily on 19/08/2026.
//


struct CategoryDetailsRawResponse: Decodable {
    let status: Int
    let message: String
    let data: CategoryDetailsData
}

struct CategoryDetailsData: Decodable {
    let categories: [RawSubCategory]
    let banners: [String]
}

struct RawSubCategory: Decodable {
    let id: String
    let nameAr: String
    let nameEn: String
    let image: String
    let childrenType: String
    let path: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case nameAr = "name_ar"
        case nameEn = "name_en"
        case image
        case childrenType = "children_type"
        case path
    }
}
