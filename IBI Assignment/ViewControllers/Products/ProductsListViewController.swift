//
//  ProductsListViewController.swift
//  IBI Assignment
//
//  Created by Pierre Janineh on 10/07/2024.
//

import UIKit
import Combine

class ProductsListViewController: PaginableProductsTableViewController {
    private static let title: LocalizedStringResource = "products"
    private static let reload: LocalizedStringResource = "reload"
    
    private let viewModel: ProductsListViewModel = .init()
    
    private var reloadFromServerButton: UIBarButtonItem {
        UIBarButtonItem(title: Self.reload.localized,
                        image: UIImage(systemName: "arrow.clockwise"),
                        target: self,
                        action: #selector(reloadFromServer))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        tabBarItem.title = Self.title.localized
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        paginationDelegate = self
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        parent?.navigationItem.setRightBarButton(reloadFromServerButton, animated: true)
        parent?.title = Self.title.localized
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        parent?.navigationItem.setRightBarButton(nil, animated: true)
    }
    
    // TODO: Not implemented in UI
    private func add(_ product: ProductEntity) {
        viewModel.add(product)
    }
    
    @objc func reloadFromServer() {
        viewModel.reloadFromServer()
    }
}

extension ProductsListViewController: PaginableDelegate {
    func productsForTableView() -> [ProductEntity] {
        viewModel.data
    }
    
    func maxItemsPerPage() -> Int { 5 }
    
    func remove(at: Int) { viewModel.remove(at: at) }
}

extension ProductsListViewController: ChangeableViewModelDelegate {
    func dataChanged() { reloadData() }
}
