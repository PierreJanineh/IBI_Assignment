//
//  FavoritesViewController.swift
//  IBI Assignment
//
//  Created by Pierre Janineh on 14/07/2024.
//

import UIKit
import Combine

class FavoritesViewController: PaginableProductsTableViewController {
    private static let title: String.LocalizationValue = "favorites"
    
    private let viewModel: FavoritesViewModel = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        paginationDelegate = self
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        parent?.title = String(localized: Self.title)
        
        viewModel.fetchFavProducts()
    }
}

extension FavoritesViewController: PaginableDelegate {
    func productsForTableView() -> [ProductEntity] {
        viewModel.data
    }
    
    func maxItemsPerPage() -> Int { 5 }
}

extension FavoritesViewController: ChangeableViewModelDelegate {
    func dataChanged() { reloadData() }
}
