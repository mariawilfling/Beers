//
//  Beer.swift
//  Beers
//
//  Created by Maria Wilfling on 11.03.24.
//

import Foundation
import UIKit

/// represents the beer object
struct Beer: Hashable {
    
    let id: Int
    let name: String
    let tagline: String
    let firstBrewed: String
    let description: String
    var image: UIImage?
    let abv: Double
    let ibu: Double?
    let ebc: Double?
    let foodPairing: [String]
}

extension Beer {
    
    static func mock() -> Beer {
        
        return Beer(
            id: 192,
            name: "Punk IPA 2007 - 2010",
            tagline: "Post Modern Classic. Spiky. Tropical. Hoppy.",
            firstBrewed: "04/2007",
            description: "Our flagship beer that kick started the craft beer revolution. This is James and Martin's original take on an American IPA, subverted with punchy New Zealand hops. Layered with new world hops to create an all-out riot of grapefruit, pineapple and lychee before a spiky, mouth-puckering bitter finish.",
            image: UIImage(named: "beer-bottle"),
            abv: 6.0,
            ibu: 60,
            ebc: 5,
            foodPairing: [
            "Spicy carne asada with a pico de gallo sauce",
            "Shredded chicken tacos with a mango chilli lime salsa",
            "Cheesecake with a passion fruit swirl sauce"
          ]
        )
    }
    
    /// initializes the beer object with its response data
    /// - Parameter beerData: The beerData object that was received in the API response
    init(beerData: BeerData) {
        self.id = beerData.id
        self.name = beerData.name
        self.tagline = beerData.tagline
        self.firstBrewed = beerData.firstBrewed
        self.description = beerData.description
        self.image = nil
        self.abv = beerData.abv
        self.ibu = beerData.ibu
        self.ebc = beerData.ebc
        self.foodPairing = beerData.foodPairing
    }
}
