//
//  Collection+SafeIndex.swift
//  IBI Assignment
//
//  Created by Pierre Janineh on 13/07/2024.
//

import Foundation

extension Collection {
    /// Safe index access.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
