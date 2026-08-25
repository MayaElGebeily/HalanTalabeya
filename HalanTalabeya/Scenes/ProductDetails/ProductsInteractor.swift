//
//  ProductsInteractor.swift
//  HalanTalabeya
//
//  Created by Maya El Gebeily on 18/08/2026.
//
//TODO: -RepoPattern Done Check Repository file
final class ProductsInteractor: ProductsBuisnessLogic {
    
    var presenter: ProductsPresentationLogic?
    var repository: ProductsRepositoryLogic = ProductsRepository()

    func fetchChips(request: ProductsModels.fetchChips.Request) {
        Task {
            do {
                let rawChips = try await repository.fetchChips(categoryId: request.categoryId, area: request.area, city: request.city)
                let subCategories = rawChips.map { raw in
                    subCategory(id: raw.id, name: raw.nameAr, childrenType: raw.childrenType)
                }
                await presenter?.presentChips(response: .init(subcategories: subCategories))
            } catch {
                print("Failed to load chips: \(error)")
            }
        }
    }
    
    func fetchProducts(request: ProductsModels.fetchProducts.Request) {
        Task {
            do {
                let rawProducts = try await repository.fetchProducts(categoryId: request.categoryId, area: request.area, city: request.city , page:request.page)
                let products = rawProducts.map { rawProduct -> Product in
                    let hasDiscount = (rawProduct.discount ?? 0) > 0
                    return Product(
                        id: rawProduct.productId,
                        name: rawProduct.nameAr,
                        price: rawProduct.cashPriceAfter ?? rawProduct.price,
                        originalPrice: hasDiscount ? rawProduct.cashPriceBefore : nil,
                        imageURL: rawProduct.image ?? "",
                        badge: hasDiscount ? "عرض خاص" : nil,
                        packDescription: rawProduct.sellingUnit ?? ""
                    )
                }
                //if first then create else append 
                await presenter?.presentProducts(response: .init(products: products , isFirstPage: request.page == 1))
            } catch {
                print("Failed to load products: \(error)")
            }
        }
    }
}
