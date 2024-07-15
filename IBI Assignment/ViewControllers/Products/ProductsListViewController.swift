//
//  ProductsListViewController.swift
//  IBI Assignment
//
//  Created by Pierre Janineh on 10/07/2024.
//

import UIKit
import Combine

class ProductsListViewController: PaginableProductsTableViewController {
    private static let title: String.LocalizationValue = "products"
    
    private let viewModel: ProductsListViewModel = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        paginationDelegate = self
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        parent?.title = String(localized: Self.title)
    }
}

extension ProductsListViewController: PaginableDelegate {
    func productsForTableView() -> [ProductEntity] {
        viewModel.data
    }
    
    func maxItemsPerPage() -> Int { 5 }
}

extension ProductsListViewController: ChangeableViewModelDelegate {
    func dataChanged() { reloadData() }
}
