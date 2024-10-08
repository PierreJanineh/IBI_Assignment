//
//  ProductsDataManager.swift
//  IBI Assignment
//
//  Created by Pierre Janineh on 15/07/2024.
//

import Foundation
import Combine

class ProductsDataManager {
    static let shared: ProductsDataManager = .init()
    private init() {
        fetchProducts()
    }
    
    private var cancellables: Set<AnyCancellable> = .init()
    
    private let productsService: ProductsService = .init()
    private let productsLocalService: ProductsLocalService = .init()
    
    @Published private(set) var error: Error?
    @Published private(set) var products: [ProductEntity]? {
        didSet {
            fetchFavProducts()
        }
    }
    @Published private(set) var favProducts: [ProductEntity]?
    
    func fetchFavProducts() {
        self.favProducts = productsLocalService.fetchFavoriteProducts()
    }
    
    func favorite(_ product: ProductEntity) {
        productsLocalService.favorite(product)
    }
    
    private func fetchProducts() {
        guard let products = productsLocalService.fetchAllProducts(),
              products.count > 0
        else {
            fetchFromProductsService()
            return
        }
        
        self.products = products
    }
    
    func fetchFromProductsService() {
        productsService.fetchProducts()?
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error
                }
            } receiveValue: { [weak self] products in
                guard let self else { return }
                
                let entities = products.productEntities
                productsLocalService.store(entities)
                self.products = entities
            }
            .store(in: &cancellables)
    }
    
    func saveContext() {
        productsLocalService.save()
    }
    
    func remove(_ product: ProductEntity) {
        productsLocalService.remove(product)
    }
    
    func add(_ product: ProductEntity) {
        productsLocalService.add(product)
    }
}
