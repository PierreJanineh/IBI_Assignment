//
//  ProductTableViewCell.swift
//  IBI Assignment
//
//  Created by Pierre Janineh on 11/07/2024.
//

import UIKit
import SDWebImage

class ProductTableViewCell: UITableViewCell {
    static let identifier = "ProductTableViewCell"
    
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let brandLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private let mainVStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalCentering
        return stack
    }()
    
    private let mainView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 25
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.7
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setColors()
        
        self.contentView.addSubview(mainView)
        
        mainView.addSubview(mainVStack)
        
        mainVStack.addArrangedSubview(thumbnailImageView)
        mainVStack.addArrangedSubview(titleLabel)
        mainVStack.addArrangedSubview(brandLabel)
        mainVStack.addArrangedSubview(descriptionLabel)
        mainVStack.addArrangedSubview(priceLabel)
        
        thumbnailImageView.widthAnchor.constraint(equalTo: mainVStack.widthAnchor, multiplier: 0.5).isActive = true
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9),
            mainView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9),
            mainView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            mainView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        mainVStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainVStack.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.9),
            mainVStack.heightAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.9),
            mainVStack.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            mainVStack.centerYAnchor.constraint(equalTo: mainView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(with product: ProductEntity) {
        thumbnailImageView.sd_setImage(with: product.thumbnail)
        titleLabel.text = product.title
        brandLabel.text = product.brand
        descriptionLabel.text = product.desc
        priceLabel.text = "$\(product.price)"
    }
    
    func setColors() {
        if self.traitCollection.userInterfaceStyle == .dark {
            mainView.backgroundColor = .darkText
            mainView.layer.shadowColor = UIColor.lightText.cgColor
            
            titleLabel.textColor = .lightText
            brandLabel.textColor = .lightText
            descriptionLabel.textColor = .lightText
            priceLabel.textColor = .lightText
        } else {
            mainView.backgroundColor = .lightText
            mainView.layer.shadowColor = UIColor.darkText.cgColor
            
            titleLabel.textColor = .darkText
            brandLabel.textColor = .darkText
            descriptionLabel.textColor = .darkText
            priceLabel.textColor = .darkText
        }
    }
}

extension ProductTableViewCell: ColorSchemeAdaptableCell {
    func configureColorScheme() {
        setColors()
    }
}
