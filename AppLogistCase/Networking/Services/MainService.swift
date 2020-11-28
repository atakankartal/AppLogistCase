//
//  MainService.swift
//  AppLogistCase
//
//  Created by Atakan Kartal on 28.11.2020.
//

import Foundation
import Moya

enum MainService<E: EnvironmentType> {

    case list
}

extension MainService: TargetType {

    var baseURL: URL {
        return E.baseUrl
    }
    
    var path: String {
        switch self {
        case .list:
            return "list"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .list:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .list:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
