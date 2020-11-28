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

    public var products = [Product]()
    public var totalProducts: Int {
        return products.map{$0.amount}.reduce(0, +)
    }

    func increaseQuantity(for _product: Product) {
        guard let product = products.first(where: { $0.id == _product.id }) else {
            _product.amount += 1
            products.append(_product)
            postEvent(producst: [_product])
            return
        }
        if product.amount < product.stock {
            product.amount += 1
            postEvent(producst: [product])
        }
    }

    func decreaseQuantity(for _product: Product) {
        guard let product = products.first(where: { $0.id == _product.id }) else { return }
        product.amount -= 1
        if product.amount == 0 {
            postEvent(producst: [product])
            products.removeAll(where: { $0.id == product.id})
        } else {
            postEvent(producst: [product])
        }
    }

    func removeProduct(_ _product: Product) {
        guard let index = products.firstIndex(where: { $0.id == _product.id }) else { return }
        let copyProduct = Product(id: _product.id, name: _product.name, price: _product.price, imageUrl: _product.imageUrl, stock: _product.stock, currency: _product.currency, index: _product.index)
//        let product = products[index]
//        product.amount = 0
        copyProduct.amount = 0
        products.remove(at: index)
        postEvent(producst: [copyProduct])
    }

    func clearAll() {
        products.forEach({ $0.amount = 0})
        postEvent(producst: products)
        products.removeAll()
    }

    private func postEvent(producst: [Product]) {
        let userInfo = ["products": products]
        NotificationCenter.default.post(name: NSNotification.Name.init("ProductAmountHasChanged"), object: nil, userInfo: userInfo)
    }
}
