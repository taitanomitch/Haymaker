//
//  Power.swift
//  Haymaker
//
//  Created by Mitchell Taitano on 11/15/18.
//  Copyright © 2018 Mitchell Taitano. All rights reserved.
//

import Foundation

class Power {
    
    var type: AttackType = .none
    var power: PowerNames = .none
    var stance: Stance = .none
    
    enum Stance {
        case attack
        case defend
        case none
    }
    
    enum PowerNames {
        case none
        case luck
        case invulnerability
    }
    
}
