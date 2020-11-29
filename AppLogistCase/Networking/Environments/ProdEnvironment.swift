//
//  ProdEnvironment.swift
//  AppLogistCase
//
//  Created by Atakan Kartal on 28.11.2020.
//

import Foundation

struct ProdEnvironment: EnvironmentType {

    static var baseUrl: URL {
        return URL(string: "https://desolate-shelf-18786.herokuapp.com")!
    }
    
}
