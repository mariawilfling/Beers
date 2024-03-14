//
//  BeerFilterRequestSettings.swift
//  Beers
//
//  Created by Maria Wilfling on 13.03.24.
//

import Foundation

/// User preferences for beer attributes to filter results
/// Used for the networking
class BeerFilterRequestSettings {

    /// Selected minimum alcohol value
    var abvMin: Double
    
    /// Selected maximum alcohol value
    var abvMax: Double
    
    /// Selected minimum bitterness value
    var ibuMin: Double
    
    /// Selected maximum bitterness value
    var ibuMax: Double
    
    /// Selected minimum color value
    var ebcMin: Double
    
    /// selected maximum color value
    var ebcMax: Double

    /// Initializer that transforms the filter settings into settings that can be sent in the API request
    /// - Parameter filterSetting: The filter settings used for the UI component
    init(filterSetting: BeerFilterSettings) {
        
        switch filterSetting.abvSetting {
        case .light:
            abvMin = 0
            abvMax = 4
        case .medium:
            abvMin = 5
            abvMax = 7
        case .strong:
            abvMin = 8
            abvMax = 70
        }
        
        switch filterSetting.ibuSetting {
        case .mild:
            ibuMin = 0
            ibuMax = 40
        case .medium:
            ibuMin = 41
            ibuMax = 50
        case .bitter:
            ibuMin = 51
            ibuMax = 80
        }
        
        switch filterSetting.ebcSetting {
        case .light:
            ebcMin = 0
            ebcMax = 16
        case .medium:
            ebcMin = 17
            ebcMax = 33
        case .dark:
            ebcMin = 34
            ebcMax = 80
        }
    }
}
