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
    var editedIndices = [Int]()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        layoutableView.tableView.delegate = self
        layoutableView.tableView.dataSource = self
        layoutableView.dismissButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        layoutableView.clearButton.addTarget(self, action: #selector(clear), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(productHasEdited(_:)), name: NSNotification.Name.init("ProductAmountHasChanged"), object: nil)
        productHasEdited(nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.init("ProductAmountHasChanged"), object: nil)
    }

    // MARK: - Operations
    @objc func add(_ button: UIButton) {
        guard let index = CartManager.shared.products.firstIndex(where: { $0.index == button.tag}) else { return }
        CartManager.shared.increaseQuantity(for: CartManager.shared.products[index])
        reload(index: index)
    }

    @objc func subtract(_ button: UIButton) {
        guard let index = CartManager.shared.products.firstIndex(where: { $0.index == button.tag}) else { return }
        if CartManager.shared.products[index].amount == 1 {
            CartManager.shared.decreaseQuantity(for: CartManager.shared.products[index])
            layoutableView.tableView.beginUpdates()
            layoutableView.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .left)
            layoutableView.tableView.endUpdates()
        } else {
            CartManager.shared.decreaseQuantity(for: CartManager.shared.products[index])
            reload(index: index)
        }
    }

    func reload(index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        self.layoutableView.tableView.reloadRows(at: [indexPath], with: .none)
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
        let products = CartManager.shared.products
        guard let currency = products.first?.currency
        else {
            layoutableView.priceLabel.text = "Ürün yok"
            layoutableView.submitButton.isHidden = true
            layoutableView.noProductLabel.isHidden = false
            return
        }
        let totalPrice = products.map{ Double($0.amount) * $0.price}.reduce(0, +).rounded(toPlaces: 2)
        let totalAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.gray, .font: UIFont.systemFont(ofSize: 17)]
        let priceAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.black, .font: UIFont.boldSystemFont(ofSize: 20)]
        let totalString = NSMutableAttributedString(string: "Toplam:  ", attributes: totalAttributes)
        let priceString = NSMutableAttributedString(string: currency + String(totalPrice), attributes: priceAttributes)
        totalString.append(priceString)
        layoutableView.priceLabel.attributedText = totalString
        layoutableView.submitButton.isHidden = false
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
            CartManager.shared.removeProduct(CartManager.shared.products[indexPath.row])
            layoutableView.tableView.beginUpdates()
            layoutableView.tableView.deleteRows(at: [indexPath], with: .left)
            layoutableView.tableView.endUpdates()
        }
    }
}
