//
//  CartManager.swift
//  HalanTalabeya
//
//  Created by Maya El Gebeily on 17/08/2026.
// concrete implementation holding the actual inmemory cart state.

import Foundation
final class CartManager:CartManaging {
    
    //no inheritance and private init because same cart for the whole session
    static let shared = CartManager()
    private init(){}
    var items: [String: cartItem] = [:]
    

    func addItem(_ product: Product , quantity: Int){
        //already there just add count
        if let existing = items[product.id] {
            items[product.id] = cartItem(product: product , quantity: existing.quantity + quantity)
        }else{
            items[product.id] = cartItem(product: product, quantity: quantity)
        }
        print("Item \(product.name) added to cart with \(quantity) amount")
    }
}
