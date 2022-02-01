//
//  Product.swift
//  NeighbourhoodGardener
//
//  Created by Micah Beech on 2022-01-31.
//

import Foundation

struct Product: Codable {
    let name: String
    let description: String
    let seller: String
    let price: Money
    let imageUrls: [String]
}
