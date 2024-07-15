//
//  ProductEntity.swift
//  IBI Assignment
//
//  Created by Pierre Janineh on 15/07/2024.
//

import Foundation
import SwiftData

@Model final class ProductEntity {
    let id: Int
    let title: String
    let desc: String
    let category: Category
    let price: Double
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let tags: [Tag]
    let brand: String?
    let sku: String
    let weight: Int
    let dimensions: Dimensions
    let warrantyInformation: String
    let shippingInformation: String
    let availabilityStatus: String
    let reviews: [Review]
    let returnPolicy: String
    let minimumOrderQuantity: Int
    let meta: Meta
    let images: [URL]
    let thumbnail: URL
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
