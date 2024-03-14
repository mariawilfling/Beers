//
//  BeerFilter.swift
//  Beers
//
//  Created by Maria Wilfling on 13.03.24.
//

import Foundation

/// User preference of alcohol percentage of a beer
enum AbvSetting: String, CaseIterable {
    case light
    case medium
    case strong
}

/// User preference of the bitterness of a beer
enum IbuSetting: String, CaseIterable {
    case mild
    case medium
    case bitter
}

/// User preference of the color of the beer
enum EbcSetting: String, CaseIterable {
    case light
    case medium
    case dark
}

/// User preferences of beer attributes
/// Used for the UI components
struct BeerFilterSettings {
    var abvSetting: AbvSetting
    var ibuSetting: IbuSetting
    var ebcSetting: EbcSetting
}

extension BeerFilterSettings {
    static func mock() -> BeerFilterSettings {
        return BeerFilterSettings(abvSetting: .light, ibuSetting: .medium, ebcSetting: .dark)
    }
}
