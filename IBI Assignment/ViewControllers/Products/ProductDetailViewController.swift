//
//  ProductDetailViewController.swift
//  IBI Assignment
//
//  Created by Pierre Janineh on 11/07/2024.
//

import UIKit

class ProductDetailViewController: UIViewController {
    let product: Product
          
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = true
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var imagePageView: ImagePageViewController = {
        let imgs: [UIImageView] = {
            var imgs: [UIImageView] = []
            for image in self.product.images {
                let uiimage = UIImageView()
                uiimage.sd_setImage(with: image)
                imgs.append(uiimage)
            }
            return imgs
        }()
        let pager = ImagePageViewController(images: imgs)
        return pager
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let brandLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    init(product: Product) {
        self.product = product
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = product.title
        navigationController?.navigationBar.prefersLargeTitles = false
        //TODO: Handle favorited already
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Favorite",
                                                            image: UIImage(systemName: "star"),
                                                            target: self,
                                                            action: #selector(favoriteTapped))
        view.backgroundColor = .white
        
        setupViews()
        configure(with: product)
    }
    
    @objc private func favoriteTapped() {
        //TODO: Implement this
        showAlert(message: "Added to favs!")
    }
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        addChild(imagePageView)
        stackView.addArrangedSubview(imagePageView.view)
        imagePageView.didMove(toParent: self)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(brandLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(priceLabel)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -50),
            stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
        
        imagePageView.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imagePageView.view.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            imagePageView.view.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            imagePageView.view.heightAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    private func configure(with product: Product) {
        titleLabel.text = product.title
        brandLabel.text = product.brand
        descriptionLabel.text = product.description
        priceLabel.text = "$\(product.price)"
    }
}
