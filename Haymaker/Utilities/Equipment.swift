//
//  Equipment.swift
//  Haymaker
//
//  Created by Mitchell Taitano on 11/15/18.
//  Copyright © 2018 Mitchell Taitano. All rights reserved.
//

import Foundation

class Equipment {
    
    var item: EquipmentList = .none
    var type: AttackType = .none
    var stance: EquipmentStance = .none
    
    enum EquipmentStance: String {
        case attackAndDamage
        case attack
        case damage
        case defend
        case none
    }
    
    enum EquipmentList {
        case baseballbat
        case knife
        case none
    }
    
    func determineEquipmentType(equipment: EquipmentList) -> AttackType {
        switch equipment {
        case .baseballbat:
            return .strength
        case .knife:
            return .agility
        default:
            return .none
        }
    }
    
    func determineEquipmentStance(equipment: EquipmentList) -> EquipmentStance {
        switch equipment {
        case .baseballbat, .knife:
            return .damage
        default:
            return .none
        }
    }
    
    func determineEquipmentBonusValue(equipment: EquipmentList) -> Int {
        switch equipment {
        case .baseballbat:
            return 2
        case .knife:
            return 1
        default:
            return 0
        }
    }
}
