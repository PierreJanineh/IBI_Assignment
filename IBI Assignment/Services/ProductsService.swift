//
//  ProductsService.swift
//  IBI Assignment
//
//  Created by Pierre Janineh on 10/07/2024.
//

import Foundation
import Combine

class ProductsService {
    /// Fetch products and return publisher,
    func fetchProducts() -> AnyPublisher<Products, Error>? {
        guard let url = URL(string: "https://dummyjson.com/products")
        else { return nil }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Products.self,
                    decoder: JSONDecoder.withDateDecodingStrategy)
            .eraseToAnyPublisher()
    }
}
