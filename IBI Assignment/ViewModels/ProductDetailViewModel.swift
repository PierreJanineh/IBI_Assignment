//
//  ProductDetailViewModel.swift
//  IBI Assignment
//
//  Created by Pierre Janineh on 15/07/2024.
//

import Foundation

class ProductDetailViewModel {
    private let dataManager: ProductsDataManager = .shared
    
    let product: ProductEntity
    
    init(_ product: ProductEntity) {
        self.product = product
    }
    
    func favorite() {
        dataManager.favorite(product)
    }
}
