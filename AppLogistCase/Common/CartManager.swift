//
//  CartManager.swift
//  AppLogistCase
//
//  Created by Atakan Kartal on 28.11.2020.
//

import Foundation

class CartManager {

    static public let shared = CartManager()
    private init() {}

    private(set) public var products = [Product]()
    public var totalProducts: Int {
        return products.map{$0.amount}.reduce(0, +)
    }

    func increaseQuantity(for _product: inout Product) {
        guard let product = products.first(where: { $0.id == _product.id }) else {
            _product.amount += 1
            products.append(_product)
            return
        }
        if product.amount < product.stock {
            product.amount += 1
        }
    }

    func decreaseQuantity(for _product: inout Product) {
        guard let product = products.first(where: { $0.id == _product.id }) else { return }
        product.amount -= 1
        if product.amount == 0 {
            products.removeAll(where: { $0.id == _product.id })
        }
    }

    func clear() {
        products.removeAll()
    }
}
