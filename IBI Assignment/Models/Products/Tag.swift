//
//  Tag.swift
//  IBI Assignment
//
//  Created by Pierre Janineh on 10/07/2024.
//

import Foundation

enum Tag: String, Codable {
    // Assuming all tags are known
    case beauty,
         mascara,
         eyeshadow,
         facePowder = "face powder",
         lipstick,
         nailPolish = "nail polish",
         perfumes,
         furniture,
         beds,
         sofas,
         bedsideTables = "bedside tables",
         officeChairs = "office chairs",
         bathrooms,
         fruits,
         meat,
         petSupplies = "pet supplies",
         catFood = "cat food",
         cookingEssentials = "cooking essentials",
         vegetables,
         dogFood = "dog food",
         dairy,
         seafood,
         condiments,
         desserts,
         beverages
}
