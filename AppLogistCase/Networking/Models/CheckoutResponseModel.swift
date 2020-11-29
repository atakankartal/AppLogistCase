//
//  CheckoutResponseModel.swift
//  AppLogistCase
//
//  Created by Atakan Kartal on 29.11.2020.
//

import Foundation

struct CheckoutResponseModel: Codable {

    let orderId: String
    let message: String

    enum CodingKeys: String, CodingKey {
        case orderId = "orderID"
        case message
    }
}
