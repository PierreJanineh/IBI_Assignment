//
//  FavoritesViewController.swift
//  IBI Assignment
//
//  Created by Pierre Janineh on 14/07/2024.
//

import UIKit
import Combine

class FavoritesViewController: PaginableProductsTableViewController {
    private static let title: LocalizedStringResource = "favorites"
    
    private let viewModel: FavoritesViewModel = .init()
    
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
        
        viewModel.fetchFavProducts()
    }
}

extension FavoritesViewController: PaginableDelegate {
    func productsForTableView() -> [ProductEntity] {
        viewModel.data
    }
    
    func maxItemsPerPage() -> Int { 5 }
    
    func remove(at: Int) {
        viewModel.remove(at: at)
    }
}

extension FavoritesViewController: ChangeableViewModelDelegate {
    func dataChanged() { reloadData() }
}
