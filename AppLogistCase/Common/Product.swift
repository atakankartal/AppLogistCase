//
//  Product.swift
//  AppLogistCase
//
//  Created by Atakan Kartal on 28.11.2020.
//

import Foundation

class Product {

    let id: String
    let name: String
    let price: Double
    let imageUrl: URL?
    let stock: Int
    let currency: String
    var amount: Int
    var index: Int

    init(id : String, name: String, price: Double, imageUrl: URL?, stock: Int, currency: String, index: Int) {
        self.id = id
        self.name = name
        self.price = price
        self.imageUrl = imageUrl
        self.stock = stock
        self.currency = currency
        self.amount = 0
        self.index = index
    }
}
