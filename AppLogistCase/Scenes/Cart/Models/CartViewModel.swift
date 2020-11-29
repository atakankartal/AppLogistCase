//
//  CartViewModel.swift
//  AppLogistCase
//
//  Created by Atakan Kartal on 29.11.2020.
//

import Foundation
import UIKit

class CartViewModel {

    var editedIndices = [IndexPath]()
    var shouldDeleteRows = false
    var isEmpty = true
    var priceText = NSAttributedString(string: "")

    func checkout(completion: @escaping(Result<CheckoutResponseModel, VMError>) -> ()) {
        let products = CartManager.shared.products.filter { $0.amount > 0}.map { CheckoutRequestModel.Entity(id: $0.id, amount: $0.amount)}
        let request = CheckoutRequestModel(products: products)
        API.mainService.request(.checkout(request: request)) { (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(.networkError(error: error)))
            case .success(let response):
                do {
                    let model = try JSONDecoder().decode(CheckoutResponseModel.self, from: response.data)
                    completion(.success(model))
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        }
    }

    func add(tag: Int) {
        guard let index = CartManager.shared.products.firstIndex(where: { $0.index == tag}) else { return }
        CartManager.shared.increaseQuantity(for: CartManager.shared.products[index])
        editedIndices = [IndexPath(row: index, section: 0)]
    }

    func subtract(tag: Int) {
        guard let index = CartManager.shared.products.firstIndex(where: { $0.index == tag}) else { return }
        if CartManager.shared.products[index].amount == 1 {
            CartManager.shared.decreaseQuantity(for: CartManager.shared.products[index])
            shouldDeleteRows = true
        } else {
            CartManager.shared.decreaseQuantity(for: CartManager.shared.products[index])
        }
        editedIndices = [IndexPath(row: index, section: 0)]
    }

    func handleEditedProducts() {
        let products = CartManager.shared.products
        guard
            let currency = products.first?.currency,
            products.filter({$0.amount > 0}).count > 0
        else {
            priceText = NSAttributedString(string: "Ürün Yok")
            isEmpty = true
            return
        }
        let totalPrice = products.map{ Double($0.amount) * $0.price}.reduce(0, +).rounded(toPlaces: 2)
        let totalAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.gray, .font: UIFont.systemFont(ofSize: 17)]
        let priceAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.black, .font: UIFont.boldSystemFont(ofSize: 20)]
        let totalString = NSMutableAttributedString(string: "Toplam:  ", attributes: totalAttributes)
        let priceString = NSMutableAttributedString(string: currency + String(totalPrice), attributes: priceAttributes)
        totalString.append(priceString)
        isEmpty = false
        priceText = totalString
    }
}
