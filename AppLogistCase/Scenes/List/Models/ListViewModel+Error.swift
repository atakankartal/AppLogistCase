//
//  ListViewModel+Error.swift
//  AppLogistCase
//
//  Created by Atakan Kartal on 28.11.2020.
//

import Foundation
import Moya

extension ListViewModel {

    enum VMError: Error {

        case decodingError
        case networkError(error: MoyaError)
    }
}
