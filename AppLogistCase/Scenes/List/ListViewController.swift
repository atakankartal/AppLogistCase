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
        layoutableView.cartImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showCart)))
        layoutableView.cartBadgeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showCart)))
        NotificationCenter.default.addObserver(self, selector: #selector(productHasEdited(_:)), name: NSNotification.Name.init("ProductAmountHasChanged"), object: nil)
        // TODO: - show Activity Indicator
        self.fetch()
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.init("ProductAmountHasChanged"), object: nil)
    }

    // MARK: - Networking
    func fetch() {
        viewModel.fetch { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                Alert(title: "Hata", body: error.localizedDescription, theme: .error, allowDismiss: true).show()
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
    }

    @objc func subtract(_ button: UIButton) {
        viewModel.decrease(index: button.tag)
    }

    //MARK: - Observer
    @objc func productHasEdited(_ notification: NSNotification) {
        guard let products = notification.userInfo?["products"] as? [Product] else { return }
        viewModel.handleEditedIndices(for: products)
        layoutableView.collectionView.reloadItems(at: viewModel.editedIndices)
        layoutableView.cartBadgeView.isHidden = viewModel.totalProductCount == 0
        layoutableView.cartLabel.text = String(viewModel.totalProductCount)
    }

    // MARK: - Router
    @objc func showCart() {
        let vc = CartViewController()
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
}

// MARK: - CollectionView Delegate & DataSource
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
