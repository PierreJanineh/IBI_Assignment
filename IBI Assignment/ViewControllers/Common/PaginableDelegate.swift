//
//  PaginableDelegate.swift
//  IBI Assignment
//
//  Created by Pierre Janineh on 15/07/2024.
//

import Foundation

protocol PaginableDelegate {
    func productsForTableView() -> [ProductEntity]
    func maxItemsPerPage() -> Int
    func remove(at: Int)
}
