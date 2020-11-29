//
//  CheckoutRequestModel.swift
//  AppLogistCase
//
//  Created by Atakan Kartal on 29.11.2020.
//

import Foundation

struct CheckoutRequestModel: Encodable {

    let products: [Entity]

    struct Entity: Encodable {

        let id: String
        let amount: Int
    }
}
