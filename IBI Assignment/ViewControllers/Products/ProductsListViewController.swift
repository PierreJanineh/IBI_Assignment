//
//  ProductsListViewController.swift
//  IBI Assignment
//
//  Created by Pierre Janineh on 10/07/2024.
//

import UIKit
import Combine

class ProductsListViewController: UIViewController {
    private static let title: String.LocalizationValue = "products"
    
    private lazy var viewModel: ProductsListViewModel = .init(tableView: tableView)
    private var cancellables: Set<AnyCancellable> = .init()
    private let tableView: UITableView = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        
        parent?.title = String(localized: Self.title)
        
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Disable selection after dismissing ProductDetailViewController
        tableView.selectRow(at: nil,
                            animated: true,
                            scrollPosition: .none)
    }
    
    private func bindViewModel() {
        viewModel.$error
            .compactMap { $0 }
            .sink { [weak self] error in
                self?.showAlert(message: error.localizedDescription)
            }
            .store(in: &cancellables)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(ProductTableViewCell.self,
                           forCellReuseIdentifier: ProductTableViewCell.identifier)
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ProductsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(
            ProductDetailViewController(product: viewModel.currentlyDisplayedProducts[indexPath.row]),
            animated: true
        )
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - (scrollView.frame.height * 2) &&
            viewModel.currentPage <= viewModel.totalPageCount {
            viewModel.loadMoreData()
        }
    }
}

extension ProductsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        viewModel.currentlyDisplayedProducts.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier,
                                                       for: indexPath) as? ProductTableViewCell,
              let product = viewModel.products?.products[safe: indexPath.row]
        else { return UITableViewCell() }
        
        cell.configure(with: product)
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        view.window?.windowScene?.screen.bounds.width ?? 0 * 0.8
    }
}
