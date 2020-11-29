//
//  API.swift
//  AppLogistCase
//
//  Created by Atakan Kartal on 28.11.2020.
//

import Foundation
import Moya

struct API: APIType {
    
    #if DEBUG
    typealias E = TestEnvironment
    #else
    typealias E = ProdEnvironment
    #endif

    static var mainService = MoyaProvider<MainService<E>>()
}
