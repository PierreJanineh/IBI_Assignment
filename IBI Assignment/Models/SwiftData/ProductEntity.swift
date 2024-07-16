//
//  ProductEntity.swift
//  IBI Assignment
//
//  Created by Pierre Janineh on 15/07/2024.
//

import Foundation
import SwiftData

@Model final class ProductEntity {
    var id: Int
    var title: String
    var desc: String
    var category: Category
    var price: Double
    var discountPercentage: Double
    var rating: Double
    var stock: Int
    var tags: [Tag]
    var brand: String?
    var sku: String
    var weight: Int
    var dimensions: Dimensions
    var warrantyInformation: String
    var shippingInformation: String
    var availabilityStatus: String
    var reviews: [Review]
    var returnPolicy: String
    var minimumOrderQuantity: Int
    var meta: Meta
    var images: [URL]
    var thumbnail: URL
    var isFavorite: Bool = false
    
    init(product: Product) {
        self.id = product.id
        self.title = product.title
        self.desc = product.desc
        self.category = product.category
        self.price = product.price
        self.discountPercentage = product.discountPercentage
        self.rating = product.rating
        self.stock = product.stock
        self.tags = product.tags
        self.brand = product.brand
        self.sku = product.sku
        self.weight = product.weight
        self.dimensions = product.dimensions
        self.warrantyInformation = product.warrantyInformation
        self.shippingInformation = product.shippingInformation
        self.availabilityStatus = product.availabilityStatus
        self.reviews = product.reviews
        self.returnPolicy = product.returnPolicy
        self.minimumOrderQuantity = product.minimumOrderQuantity
        self.meta = product.meta
        self.images = product.images
        self.thumbnail = product.thumbnail
    }
}
