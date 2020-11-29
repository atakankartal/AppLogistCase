//
//  ListResponse.swift
//  AppLogistCase
//
//  Created by Atakan Kartal on 28.11.2020.
//

import Foundation

struct APIProductModel: Codable {

    let id: String
    let name: String
    let price: Double
    let imageUrl: String
    let stock: Int
    let currency: String
}
