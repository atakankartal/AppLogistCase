//
//  ListView.swift
//  AppLogistCase
//
//  Created by Atakan Kartal on 28.11.2020.
//

import Foundation
import SnapKit

class ListView: UIView {

    lazy var navigationView: UIView = {
        var view = UIView()
        view.backgroundColor = .clear
        view.alpha = 1
        return view
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Mini Bakkal"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        label.textAlignment = .center
        label.minimumScaleFactor = 0.75
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    lazy var cartImageView: UIImageView = {
        var iv = UIImageView()
        iv.image = UIImage(named: "cart")
        iv.contentMode = .scaleAspectFill
        iv.isUserInteractionEnabled = true
        return iv
    }()

    lazy var cartBadgeView: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8.scale
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 5
        view.isHidden = true
        view.isUserInteractionEnabled = true
        return view
    }()

    lazy var cartLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .black
        label.textAlignment = .center
        label.minimumScaleFactor = 0.75
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let padding: CGFloat = 16
        let itemSize = (screenWidth - (padding * 4)) / 3
        layout.itemSize = CGSize(width: itemSize, height: itemSize * 1.3)
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: 0, right: padding)
        let cv = UICollectionView(frame: frame, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.showsVerticalScrollIndicator = false
        cv.register(ListCell.self, forCellWithReuseIdentifier: "ListCell")
        return cv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        addSubview(navigationView)
        navigationView.addSubview(titleLabel)
        navigationView.addSubview(cartImageView)
        navigationView.addSubview(cartBadgeView)
        cartBadgeView.addSubview(cartLabel)
        addSubview(collectionView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        navigationView.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40.scale)
        }

        titleLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }

        cartImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLabel)
            make.trailing.equalToSuperview().inset(18.scale)
            make.width.height.equalTo(25.scale)
        }

        cartBadgeView.snp.makeConstraints { (make) in
            make.top.equalTo(cartImageView).offset(-4.scale)
            make.trailing.equalTo(cartImageView).offset(8.scale)
            make.width.height.equalTo(16.scale)
        }

        cartLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }

        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(navigationView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
