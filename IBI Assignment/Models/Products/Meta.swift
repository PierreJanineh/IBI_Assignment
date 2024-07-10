//
//  Meta.swift
//  IBI Assignment
//
//  Created by Pierre Janineh on 10/07/2024.
//

import Foundation

struct Meta: Codable {
    let createdAt: Date
    let updatedAt: Date
    let barcode: String
    let qrCode: URL
}
