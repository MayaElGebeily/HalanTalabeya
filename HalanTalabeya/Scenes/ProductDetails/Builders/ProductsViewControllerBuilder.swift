//
//  ProductsViewControllerBuilder.swift
//  HalanTalabeya
//
//  Created by Maya El Gebeily on 21/08/2026.
//
//enum because not instanse
enum ProductsViewControllerBuilder {
    static func build(
        categoryId: String,
        categoryName: String,
        area:String,
        city: String
    ) -> ProductsViewController {
        ProductsViewController(
            categoryId: categoryId,
            categoryName: categoryName,
            area:area,
            city: city
        )
    }
}
