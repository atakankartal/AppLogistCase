//
//  CartCell.swift
//  AppLogistCase
//
//  Created by Atakan Kartal on 28.11.2020.
//

import UIKit
import SnapKit
import SDWebImage

class CartCell: UITableViewCell {

    lazy var productImageView: UIImageView = {
        var iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .clear
        iv.clipsToBounds = true
        return iv
    }()

    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "₺ 12.50"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .systemBlue
        label.textAlignment = .left
        label.minimumScaleFactor = 0.75
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Domates"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor =  #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.textAlignment = .left
        label.minimumScaleFactor = 0.75
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [productImageView, priceLabel, nameLabel])
        sv.axis = .vertical
        sv.alignment = .fill
        sv.spacing = 0
        sv.distribution = .fill
        return sv
    }()

    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 3, right: 0)
        return button
    }()

    lazy var quantityLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = #colorLiteral(red: 0.8431372549, green: 0.9490196078, blue: 1, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor =  .black
        label.textAlignment = .center
        label.minimumScaleFactor = 0.75
        label.adjustsFontSizeToFitWidth = true
        label.isHidden = true
        return label
    }()

    lazy var subtractButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0)
        button.isHidden = true
        return button
    }()

    lazy var quantityStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [subtractButton, quantityLabel, addButton])
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.spacing = 1
        sv.distribution = .fillEqually
        sv.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        sv.layer.borderWidth = 1
        sv.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor
        return sv
    }()

    lazy var bottomLineView: UIView = {
        var view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.184770976)
        view.alpha = 1
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.isUserInteractionEnabled = false
        selectionStyle = .none
        backgroundColor = .white
        addSubview(productImageView)
        addSubview(nameLabel)
        addSubview(priceLabel)
        addSubview(quantityStackView)
        addSubview(bottomLineView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        productImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16.scale)
            make.width.equalTo(70.scale)
            make.height.equalTo(60.scale)
        }

        nameLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(productImageView.snp.trailing).offset(16)
            make.top.equalTo(productImageView).offset(8.scale)
            make.trailing.equalTo(quantityStackView.snp.leading).offset(-8.scale)
        }

        priceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(6.scale)
            make.leading.trailing.equalTo(nameLabel)
        }

        let quantityHeight: Double = 22
        addButton.snp.makeConstraints { $0.width.height.equalTo(quantityHeight.scale)}
        quantityLabel.snp.makeConstraints { $0.width.height.equalTo(quantityHeight.scale)}
        subtractButton.snp.makeConstraints { $0.width.height.equalTo(quantityHeight.scale)}

        quantityStackView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16.scale)
            make.height.equalTo(quantityHeight.scale)
        }

        bottomLineView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CartCell {

    func configure(_ product: Product) {
        priceLabel.text = product.currency + String(product.price)
        nameLabel.text = product.name
        productImageView.sd_setImage(with: product.imageUrl, completed: nil)
        quantityLabel.text = String(product.amount)
        addButton.tag = product.index
        subtractButton.tag = product.index
        subtractButton.isHidden = product.amount == 0
        quantityLabel.isHidden = product.amount == 0
    }
}
