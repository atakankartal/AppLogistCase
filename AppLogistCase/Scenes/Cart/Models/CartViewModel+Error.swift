//
//  CartViewModel+Error.swift
//  AppLogistCase
//
//  Created by Atakan Kartal on 29.11.2020.
//

import Foundation
import Moya

extension CartViewModel {

    enum VMError: Error {

        case decodingError
        case networkError(error: MoyaError)
    }
}
