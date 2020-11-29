//
//  CartViewController.swift
//  AppLogistCase
//
//  Created by Atakan Kartal on 28.11.2020.
//

import UIKit

class CartViewController: UIViewController {

    // MARK: - View Generator
    override func loadView() {
        view = CartView()
    }
    var layoutableView: CartView {
        return self.view as! CartView
    }

    // MARK: - Properties
    let viewModel = CartViewModel()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        layoutableView.tableView.delegate = self
        layoutableView.tableView.dataSource = self
        layoutableView.dismissButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        layoutableView.clearButton.addTarget(self, action: #selector(clear), for: .touchUpInside)
        layoutableView.submitButton.addTarget(self, action: #selector(checkout), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(productHasEdited(_:)), name: NSNotification.Name.init("ProductAmountHasChanged"), object: nil)
        productHasEdited(nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.init("ProductAmountHasChanged"), object: nil)
    }

    @objc func checkout() {
        self.viewModel.checkout { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let response):
                print(response.message)
            }
        }
    }

    // MARK: - Operations
    @objc func add(_ button: UIButton) {
        viewModel.add(tag: button.tag)
        self.layoutableView.tableView.reloadRows(at: viewModel.editedIndices, with: .none)
        viewModel.editedIndices = []
    }

    @objc func subtract(_ button: UIButton) {
        viewModel.subtract(tag: button.tag)
        if viewModel.shouldDeleteRows {
            layoutableView.tableView.beginUpdates()
            layoutableView.tableView.deleteRows(at: viewModel.editedIndices, with: .left)
            layoutableView.tableView.endUpdates()
        } else {
            self.layoutableView.tableView.reloadRows(at: viewModel.editedIndices, with: .none)
        }
        viewModel.editedIndices = []
        viewModel.shouldDeleteRows = false
    }

    @objc func clear() {
        guard CartManager.shared.products.count > 0 else { return }
        let alert = UIAlertController(title: "Dikkat!", message: "Sepetinizdeki tüm ürünleri silmek istediğinizden emin misiniz?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Sil", style: .destructive, handler: { (_) in
            CartManager.shared.clearAll()
            self.layoutableView.tableView.reloadData()
            self.layoutableView.noProductLabel.isHidden = false
        }))
        alert.addAction(UIAlertAction(title: "Vazgeç", style: .cancel, handler: { (_) in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Observer
    @objc func productHasEdited(_ notification: NSNotification?) {
        viewModel.handleEditedProducts()
        layoutableView.submitButton.isHidden = viewModel.isEmpty
        layoutableView.noProductLabel.isHidden = !viewModel.isEmpty
        layoutableView.priceLabel.attributedText = viewModel.priceText
    }

    // MARK: - Routers
    @objc func dismissVC() {
        self.dismiss(animated: true)
    }
}

// MARK: - TableView Delegate & DataSource
extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CartManager.shared.products.filter{$0.amount != 0}.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as! CartCell
        let product = CartManager.shared.products.filter{$0.amount != 0}[indexPath.item]
        cell.configure(product)
        cell.addButton.addTarget(self, action: #selector(add(_:)), for: .touchUpInside)
        cell.subtractButton.addTarget(self, action: #selector(subtract(_:)), for: .touchUpInside)
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CartManager.shared.removeProduct(at: indexPath.row)
            layoutableView.tableView.beginUpdates()
            layoutableView.tableView.deleteRows(at: [indexPath], with: .left)
            layoutableView.tableView.endUpdates()
        }
    }
}
