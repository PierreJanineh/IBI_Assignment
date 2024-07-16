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
    
    //TODO: Not implemented in UI
    func editProduct(title: String,
                     brand: String?,
                     desc: String,
                     price: Double) {
        product.title = title
        product.brand = brand
        product.desc = desc
        product.price = price
        dataManager.saveContext()
    }
    
    func removeProduct() {
        dataManager.remove(product)
    }
}
