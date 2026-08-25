//
//  Product.swift
//  HalanTalabeya
//
//  Created by Maya El Gebeily on 17/08/2026.
//a plain struct representing one product (name, price, image URL, badge)
import Foundation

public struct Product {
    let id: String
    let name: String
    let price: Double
    let originalPrice: Double?
    let imageURL: String
    let badge: String?
    let packDescription: String?
}

