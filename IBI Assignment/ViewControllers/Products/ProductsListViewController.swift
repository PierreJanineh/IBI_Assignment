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
    
    private let viewModel: ProductsListViewModel = .init()
    
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
        
        parent?.title = Self.title.localized
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
