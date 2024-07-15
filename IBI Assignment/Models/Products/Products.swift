//
//  Products.swift
//  IBI Assignment
//
//  Created by Pierre Janineh on 10/07/2024.
//

import Foundation

struct Products: Codable {
    let products: [Product]
    
    var productEntities: [ProductEntity] {
        products.map { ProductEntity(product: $0) }
    }
}
