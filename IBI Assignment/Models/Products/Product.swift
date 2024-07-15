//
//  Product.swift
//  IBI Assignment
//
//  Created by Pierre Janineh on 10/07/2024.
//

import Foundation

struct Product: Codable {
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
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case desc = "description"
        case category
        case price
        case discountPercentage
        case rating
        case stock
        case tags
        case brand
        case sku
        case weight
        case dimensions
        case warrantyInformation
        case shippingInformation
        case availabilityStatus
        case reviews
        case returnPolicy
        case minimumOrderQuantity
        case meta
        case images
        case thumbnail
    }
}
