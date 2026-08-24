//
//  RealProductsWorker.swift
//  HalanTalabeya
//
//  Created by Maya El Gebeily on 18/08/2026.
//

import Foundation
import HalanNetworkKit

protocol ProductsWorkerLogic {
    func fetchChips(categoryId: String, area: String, city: String) async throws -> [RawSubCategory]
    func fetchProducts(categoryId: String, area: String, city: String) async throws -> [RawProduct]
}

final class RealProductsWorker: ProductsWorkerLogic {
    
    private let sessionManager: SessionManaging
    private let service = NetworkService()
    private let baseURL = URL(string: "https://api-test.halan.io/bff-mobile/ecommerce/v4.1/")!
    
    init(sessionManager: SessionManaging = SessionManager()) {
        self.sessionManager = sessionManager
    }
    
    func fetchChips(categoryId: String, area: String, city: String) async throws -> [RawSubCategory] {
        let encodedArea = area.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? area
        let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? city
        let endpoint = NetworkEndpoint(
            path: "categories/\(categoryId)/details?area=\(encodedArea)&city=\(encodedCity)",
            headers: sessionManager.currentHeaders()
        )
        let raw: CategoryDetailsRawResponse = try await service.request(endpoint, baseURL: baseURL, responseType: CategoryDetailsRawResponse.self)
        return raw.data.categories
    }
    
    func fetchProducts(categoryId: String, area: String, city: String) async throws -> [RawProduct] {
        let encodedArea = area.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? area
        let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? city
        let endpoint = NetworkEndpoint(
            path: "categories/\(categoryId)/products?area=\(encodedArea)&city=\(encodedCity)&page_number=1&page_size=10",
            headers: sessionManager.currentHeaders()
        )
        let raw: CategoryProductsRawResponse = try await service.request(endpoint, baseURL: baseURL, responseType: CategoryProductsRawResponse.self)
        return raw.data.products
    }
}
