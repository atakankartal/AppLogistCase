//
//  CartView.swift
//  AppLogistCase
//
//  Created by Atakan Kartal on 28.11.2020.
//

import Foundation
import UIKit

class CartView: UIView {

    lazy var navigationView: UIView = {
        var view = UIView()
        view.backgroundColor = .clear
        view.alpha = 1
        return view
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sepet"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        label.textAlignment = .center
        label.minimumScaleFactor = 0.75
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    lazy var clearButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemRed, for: .normal)
        button.setTitle("Sil", for: .normal)
        button.contentHorizontalAlignment = .left
        return button
    }()

    lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle("Kapat", for: .normal)
        button.contentHorizontalAlignment = .right
        return button
    }()

    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .white
        tv.separatorStyle = .none
        tv.rowHeight = 90.scale
        tv.register(CartCell.self, forCellReuseIdentifier: "CartCell")
        return tv
    }()

    lazy var noProductLabel: UILabel = {
        let label = UILabel()
        label.text = "Sepetiniz Boş"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.textAlignment = .center
        label.minimumScaleFactor = 0.75
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()

    lazy var priceContainerView: UIView = {
        var view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.7333333333, green: 0.9450980392, blue: 0.8901960784, alpha: 1)
        view.alpha = 1
        return view
    }()

    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.minimumScaleFactor = 0.75
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    lazy var submitButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Sipariş Ver", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.titleLabel?.minimumScaleFactor = 0.5
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.layer.cornerRadius = 4
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        addSubview(navigationView)
        navigationView.addSubview(titleLabel)
        navigationView.addSubview(clearButton)
        navigationView.addSubview(dismissButton)
        addSubview(tableView)
        tableView.addSubview(noProductLabel)
        addSubview(priceContainerView)
        priceContainerView.addSubview(priceLabel)
        priceContainerView.addSubview(submitButton)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        navigationView.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50.scale)
        }

        titleLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }

        clearButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLabel)
            make.leading.equalToSuperview().inset(12.scale)
        }

        dismissButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLabel)
            make.trailing.equalToSuperview().inset(12.scale)
        }

        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(navigationView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(priceContainerView.snp.top)
        }

        noProductLabel.snp.makeConstraints({ $0.center.equalToSuperview()})

        priceContainerView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(110.scale)
        }

        priceLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(20.scale)
            make.trailing.equalTo(submitButton.snp.leading).offset(-8.scale)
        }

        submitButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16.scale)
            make.height.equalTo(40.scale)
            make.width.equalTo(130.scale)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
