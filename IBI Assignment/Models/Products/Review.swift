//
//  Review.swift
//  IBI Assignment
//
//  Created by Pierre Janineh on 10/07/2024.
//

import Foundation

struct Review: Codable {
    let rating: Int
    let comment: String
    let date: Date
    let reviewerName: String
    let reviewerEmail: String
}
