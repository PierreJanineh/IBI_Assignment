//
//  ProductsLocalService.swift
//  IBI Assignment
//
//  Created by Pierre Janineh on 15/07/2024.
//

import Foundation
import SwiftData

class ProductsLocalService {
    private static var container: ModelContainer? = try? ModelContainer(for: ProductEntity.self)
    private lazy var context: ModelContext? = {
        guard let container = Self.container else { return nil }
        return ModelContext(container)
    }()
    
    func fetchFavoriteProducts() -> [ProductEntity]? {
        fetchProducts(isFav: true)
    }
    
    func fetchAllProducts() -> [ProductEntity]? {
        fetchProducts()
    }
    
    private func fetchProducts(isFav: Bool = false) -> [ProductEntity]? {
        guard let context else { return nil }
        
        var descriptor = FetchDescriptor<ProductEntity>()
        descriptor.predicate = #Predicate { isFav ? $0.isFavorite : true }
        descriptor.sortBy = [SortDescriptor(\.id)]
        return try? context.fetch(descriptor)
    }
    
    func store(_ products: [ProductEntity]) {
        guard let context else { return }
        
        if let storedAlready = fetchAllProducts(),
           !storedAlready.isEmpty {
            storedAlready.forEach { context.delete($0) }
            try? context.save()
        }
        
        products.forEach { context.insert($0) }
        try? context.save()
    }
    
    func favorite(_ product: ProductEntity) {
        guard let context else { return }
        
        product.isFavorite.toggle()
        try? context.save()
    }
    
    func save() {
        try? context?.save()
    }
    
    func remove(_ product: ProductEntity) {
        context?.delete(product)
        save()
    }
    
    func add(_ product: ProductEntity) {
        context?.insert(product)
        save()
    }
}
