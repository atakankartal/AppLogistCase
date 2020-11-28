//
//  ListCell.swift
//  AppLogistCase
//
//  Created by Atakan Kartal on 28.11.2020.
//

import UIKit
import SDWebImage

class ListCell: UICollectionViewCell {

    lazy var imageView: UIImageView = {
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
        let sv = UIStackView(arrangedSubviews: [imageView, priceLabel, nameLabel])
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
        label.backgroundColor = .white
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

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .clear
        addSubview(stackView)
        addSubview(quantityStackView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        imageView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(self.snp.width).multipliedBy(0.8)
        }

        stackView.snp.makeConstraints { $0.edges.equalToSuperview()}

        let quantityHeight: Double = 22
        addButton.snp.makeConstraints { $0.width.height.equalTo(quantityHeight.scale)}
        quantityLabel.snp.makeConstraints { $0.width.height.equalTo(quantityHeight.scale)}
        subtractButton.snp.makeConstraints { $0.width.height.equalTo(quantityHeight.scale)}

        quantityStackView.snp.makeConstraints { (make) in
            make.top.trailing.equalToSuperview()
            make.height.equalTo(quantityHeight.scale)
        }
    }
}

extension ListCell {

    func configure(_ entity: Product, index: Int) {
        priceLabel.text = entity.currency + String(entity.price)
        nameLabel.text = entity.name
        imageView.sd_setImage(with: entity.imageUrl, completed: nil)
        quantityLabel.text = String(entity.amount)
        addButton.tag = index
        subtractButton.tag = index
        subtractButton.isHidden = entity.amount == 0
        quantityLabel.isHidden = entity.amount == 0
    }
}
