//
//  ListViewModel.swift
//  AppLogistCase
//
//  Created by Atakan Kartal on 28.11.2020.
//

import Foundation
import Moya

class ListViewModel {

    var entities = [Entity]()

    /// Add Documentation
    /// Fetches list of products
    /// Parameters:
    func fetch(completion: @escaping(Result<[Entity], VMError>) -> Void) {
        // TODO: Show indicator
        API.mainService.request(.list) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(.networkError(error: error)))
            case .success(let response):
                do {
                    let list = try JSONDecoder().decode([ListResponse].self, from: response.data)
                    self.entities = list.reduce(into: [Entity](), { (output, item) in
                        let entity = Entity(id: item.id,
                                            name: item.name,
                                            price: item.currency + String(item.price),
                                            imageUrl: URL(string: item.imageUrl),
                                            stock: item.stock)
                        output.append(entity)
                    })
                    completion(.success(self.entities))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(.decodingError))
                }
            }
        }
    }
}
