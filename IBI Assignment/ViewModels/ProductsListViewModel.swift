//
//  ProductsListViewModel.swift
//  IBI Assignment
//
//  Created by Pierre Janineh on 10/07/2024.
//

import UIKit
import Combine

class ProductsListViewModel {
    private let productsService: ProductsService = .init()
    private var cancellables: Set<AnyCancellable> = .init()
    
    let pageMaxItems: Int = 5
    
    @Published private(set) var error: Error?
    private(set) var products: Products?
    private(set) var currentlyDisplayedProducts: [Product] = []
    private(set) var currentPage: Int = 1
    private(set) var totalPageCount: Int = 0
    
    private var tableView: UITableView
    
    init(tableView: UITableView) {
        self.tableView = tableView
        
        fetchProducts()
    }
    
    private func fetchProducts() {
        productsService.fetchProducts()?
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error
                }
            } receiveValue: { [weak self] products in
                guard let self else { return }
                
                self.products = products
                loadMoreData()
                totalPageCount = (products.products.count + pageMaxItems - 1) / pageMaxItems
            }
            .store(in: &cancellables)
    }
    
    func loadMoreData() {
        guard let products = self.products?.products else { return }
        
        let startIndex = (currentPage - 1) * pageMaxItems
        let endIndex = min(startIndex + pageMaxItems, products.count)
        
        guard startIndex < endIndex else { return }
        
        currentlyDisplayedProducts.append(contentsOf: products[startIndex..<endIndex])
        tableView.reloadData()
        currentPage += 1
    }
}
