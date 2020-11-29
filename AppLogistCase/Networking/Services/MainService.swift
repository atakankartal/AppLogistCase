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
    case checkout(request: CheckoutRequestModel)
}

extension MainService: TargetType {

    var baseURL: URL {
        return E.baseUrl
    }
    
    var path: String {
        switch self {
        case .list:
            return "list"
        case .checkout:
            return "checkout"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .list:
            return .get
        case .checkout:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .list:
            return .requestPlain
        case .checkout(let request):
            return .requestCustomJSONEncodable(request, encoder: JSONEncoder())
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
