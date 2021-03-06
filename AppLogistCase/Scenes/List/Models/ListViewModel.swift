//
//  ListViewModel.swift
//  AppLogistCase
//
//  Created by Atakan Kartal on 28.11.2020.
//

import Foundation
import Moya

class ListViewModel {

    var products = [Product]()
    var editedIndices = [IndexPath]()
    var totalProductCount = 0

    func fetch(completion: @escaping(Result<[Product], VMError>) -> Void) {
        API.mainService.request(.list) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(.networkError(error: error)))
            case .success(let response):
                do {
                    let list = try JSONDecoder().decode([APIProductModel].self, from: response.data)
                    var index = 0
                    self.products = list.reduce(into: [Product](), { (output, item) in
                        let entity = Product(id: item.id,
                                            name: item.name,
                                            price: item.price,
                                            imageUrl: URL(string: item.imageUrl),
                                            stock: item.stock,
                                            currency: item.currency,
                                            index: index)
                        output.append(entity)
                        index += 1
                    })
                    completion(.success(self.products))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(.decodingError))
                }
            }
        }
    }

    func increase(index: Int) {
        let product = products[index]
        CartManager.shared.increaseQuantity(for: product)
    }

    func decrease(index: Int) {
        let product = products[index]
        CartManager.shared.decreaseQuantity(for: product)
    }

    func handleEditedIndices(for products: [Product]) {
        editedIndices.removeAll()
        products.forEach { (product) in
            guard let index = self.products.firstIndex(where: { $0 == product}) else { return }
            self.products[index].amount = product.amount
            editedIndices.append(IndexPath(item: index, section: 0))
        }
        totalProductCount = CartManager.shared.totalProducts
        
    }
}
