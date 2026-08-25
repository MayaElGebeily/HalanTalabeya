//
//  ProductsRepository.swift
//  HalanTalabeya
//
//  Created by Maya El Gebeily on 21/08/2026.
//
protocol ProductsRepositoryLogic {
    func fetchChips(categoryId: String, area: String, city: String) async throws -> [RawSubCategory]
    func fetchProducts(categoryId: String, area: String, city: String , page:Int) async throws -> [RawProduct]
}

final class ProductsRepository: ProductsRepositoryLogic {
    
    private let worker: ProductsWorkerLogic
    
    init(worker: ProductsWorkerLogic = RealProductsWorker()) {
        self.worker = worker
    }
    
    func fetchChips(categoryId: String, area: String, city: String) async throws -> [RawSubCategory] {
        try await worker.fetchChips(categoryId: categoryId, area: area, city: city)
    }
    
    func fetchProducts(categoryId: String, area: String, city: String , page:Int) async throws -> [RawProduct] {
        try await worker.fetchProducts(categoryId: categoryId, area: area, city: city , page:page)
    }
}
