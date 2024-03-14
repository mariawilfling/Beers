//
//  BeerData.swift
//  Beers
//
//  Created by Maria Wilfling on 13.03.24.
//

import Foundation

/// Represents the response data 
struct BeerData: Codable, Hashable {
    
    let id: Int
    let name: String
    let tagline: String
    let firstBrewed: String
    let description: String
    let imageUrl: String?
    let abv: Double
    let ibu: Double?
    let ebc: Double?
    let foodPairing: [String]
}
