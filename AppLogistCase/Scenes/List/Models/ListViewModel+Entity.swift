//
//  ListViewModel+Entity.swift
//  AppLogistCase
//
//  Created by Atakan Kartal on 28.11.2020.
//

import Foundation

extension ListViewModel {

    class Entity {

        let id: String
        let name: String
        let price: String
        let imageUrl: URL?
        let stock: Int
        var amount: Int

        init(id : String, name: String, price: String, imageUrl: URL?, stock: Int) {
            self.id = id
            self.name = name
            self.price = price
            self.imageUrl = imageUrl
            self.stock = stock
            self.amount = 0
        }
    }
}
