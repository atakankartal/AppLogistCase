//
//  ViewController.swift
//  AppLogistCase
//
//  Created by Atakan Kartal on 28.11.2020.
//

import UIKit
import Moya

class ListViewController: UIViewController {

    // MARK: - View Generator
    override func loadView() {
        view = ListView()
    }
    var layoutableView: ListView {
        return self.view as! ListView
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        layoutableView.collectionView.delegate = self
        layoutableView.collectionView.dataSource = self

        API.mainService.request(.list) { (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let response):
                do {
                    let list = try JSONDecoder().decode([Item].self, from: response.data)
                    print(list.first)
                } catch {
                    print(error.localizedDescription)
                }
                
            }
        }
    }
}

struct Item: Codable {

    let currency: String
    let id: String
    let imageUrl: String
    let name: String
    let price: Double
    let stock: Int
}

// MARK: - CollectionView Delegate
extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCell", for: indexPath)
        return cell
    }
}
