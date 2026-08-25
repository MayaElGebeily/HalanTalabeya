//
//  ProductsModels.swift
//  HalanTalabeya
//
//  Created by Maya El Gebeily on 18/08/2026.
//
import Foundation
enum ProductsModels {
    
    enum fetchProducts {
        struct Request {
            let categoryId: String
            let area: String
            let city: String
            let page: Int
        }
        struct Response {
            let products: [Product]
            let isFirstPage: Bool
        }
        struct viewModel {
            let productCards: [ProductCardViewModel]
            let isFirstPage: Bool
        }
    }
    enum fetchChips{
        struct Request{
            let categoryId: String
            let area: String
            let city: String
        }
        struct Response{
            let subcategories: [subCategory]
        }
        struct viewModel{
            let chips: [subCategoryChipViewModel]
        }
    }
}


struct ProductCardViewModel {
    let name: String
    let priceText: NSAttributedString
    let originalPriceText: String?
    let imageURL: String
    let badgeText: String?
    let packDescription: String?
}

struct subCategoryChipViewModel{
    let id: String
    let title: String
    let childrenType: String
}
