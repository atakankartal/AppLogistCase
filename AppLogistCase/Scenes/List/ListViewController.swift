//
//  ViewController.swift
//  AppLogistCase
//
//  Created by Atakan Kartal on 28.11.2020.
//

import UIKit

class ListViewController: UIViewController {

    // MARK: - View Generator
    override func loadView() {
        view = ListView()
    }
    var layoutableView: ListView {
        return self.view as! ListView
    }

    // MARK: - Properties
    let viewModel = ListViewModel()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        layoutableView.collectionView.delegate = self
        layoutableView.collectionView.dataSource = self
        // TODO: - show Activity Indicator
        self.fetch()
    }

    // MARK: - Networking
    func fetch() {
        viewModel.fetch { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success:
                DispatchQueue.main.async {
                    self.layoutableView.collectionView.reloadData()
                }
            }
        }
    }

    // MARK: - Operations
    @objc func add(_ button: UIButton) {
        viewModel.increase(index: button.tag)
        reload(index: button.tag)
    }

    @objc func subtract(_ button: UIButton) {
        viewModel.decrease(index: button.tag)
        reload(index: button.tag)
    }

    func reload(index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        self.layoutableView.collectionView.reloadItems(at: [indexPath])
        let total = CartManager.shared.totalProducts
        layoutableView.cartBadgeView.isHidden = total == 0
        layoutableView.cartLabel.text = String(total)
    }
}

// MARK: - CollectionView Delegate
extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCell", for: indexPath) as! ListCell
        let entity = viewModel.products[indexPath.item]
        cell.configure(entity, index: indexPath.item)
        cell.addButton.addTarget(self, action: #selector(add(_:)), for: .touchUpInside)
        cell.subtractButton.addTarget(self, action: #selector(subtract(_:)), for: .touchUpInside)
        return cell
    }
}
