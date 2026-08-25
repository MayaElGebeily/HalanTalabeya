//
//  ProductsPresenter.swift
//  HalanTalabeya
//
//  Created by Maya El Gebeily on 18/08/2026.
//
import Foundation
import DesignKit
//TODO: -Mapping in Interactor
final class ProductsPresenter: ProductsPresentationLogic {
    
    weak var viewController: ProductsDisplayLogic?
    
    func presentChips(response: ProductsModels.fetchChips.Response) {
        let chips = response.subcategories.map {
            subCategoryChipViewModel(id: $0.id, title: $0.name, childrenType: $0.childrenType)
        }
        viewController?.displayChips(viewModel: .init(chips: chips))
    }
    
    func presentProducts(response: ProductsModels.fetchProducts.Response) {

        let cards = response.products.map { product in

            let price = String(format: "%.2f", product.price)

            let priceText = NSMutableAttributedString(
                string: price,
                attributes: [
                    .font: AppFonts.headingH2
                ]
            )

            priceText.append(
                NSAttributedString(
                    string: " جنيه",
                    attributes: [
                        .font: AppFonts.captionC2
                    ]
                )
            )

            return ProductCardViewModel(
                name: product.name,
                priceText: priceText,
                originalPriceText: product.originalPrice.map {
                    String(format: "%.2f جنيه", $0)
                },
                imageURL: product.imageURL,
                badgeText: product.badge,
                packDescription: product.packDescription
            )
        }

        viewController?.displayProducts(
            viewModel: .init(productCards: cards , isFirstPage: response.isFirstPage)
        )
    }
}
