//
//  ImageUtilities.swift
//  Haymaker
//
//  Created by Mitchell Taitano on 1/30/21.
//  Copyright © 2021 Mitchell Taitano. All rights reserved.
//

import Foundation

class ImageUtilities {
    
    private static var CombatBackgroundNames:[String] = ["CityBackground", "JungleBackground", "WarehouseBackground", "RooftopBackground"]
    
    static func selectBackgroundImageView() -> String {
        let randomSelection = Int.random(in: 0..<CombatBackgroundNames.count)
        return CombatBackgroundNames[randomSelection]
    }
}
