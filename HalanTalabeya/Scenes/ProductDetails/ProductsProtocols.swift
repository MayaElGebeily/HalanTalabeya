//
//  ProductsProtocols.swift
//  HalanTalabeya
// Created by Maya El Gebeily on 17/08/2026.

//operations view allowed to request(Interactor)
protocol ProductsBuisnessLogic {
    func fetchChips(request: ProductsModels.fetchChips.Request)
    func fetchProducts(request: ProductsModels.fetchProducts.Request)
}

//responses interactor send , presenter recieves as response(presenter)
@MainActor
protocol ProductsPresentationLogic {
    func presentChips(response: ProductsModels.fetchChips.Response)
    func presentProducts(response: ProductsModels.fetchProducts.Response)
}

//UI updates presenter can request(View)
@MainActor
protocol ProductsDisplayLogic: AnyObject {
    func displayChips(viewModel: ProductsModels.fetchChips.viewModel)
    func displayProducts(viewModel: ProductsModels.fetchProducts.viewModel)
}
