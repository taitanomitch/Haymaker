//
//  Definitions.swift
//  Haymaker
//
//  Created by Mitchell Taitano on 11/13/18.
//  Copyright © 2018 Mitchell Taitano. All rights reserved.
//

import Foundation

enum AttackType {
    case strength
    case agility
    case intellect
    case willpower
    case none
}

enum ActionType: String {
    case strength
    case agility
    case intellect
    case willpower
    case doom
    case none
}

enum CardLuck: String {
    case positive
    case negative
    case neutral
    case none
}

class Card: NSObject {
    
    private var cardName: String!
    private var cardActionType: ActionType!
    private var cardValue: Int!
    private var cardEvent: String!
    private var cardLuck: CardLuck!
    
    override init() {
        cardName = ""
        cardActionType = ActionType.none
        cardValue = -1
        cardEvent = ""
        cardLuck = CardLuck.none
    }

    init(name: String, type: ActionType, value: String, event: String, luck: CardLuck) {
        cardName = name
        cardActionType = type
        cardValue = Int(value)
        cardEvent = event
        cardLuck = luck
    }
    
    public func toString() -> String {
        return "\(cardActionType.rawValue) - \(String(cardValue))"
    }
    
    // MARK: - Get Functions
    func getName() -> String {
        if let name = cardName {
            return name
        } else {
            return ""
        }
    }
    
    func getActionType() -> ActionType {
        if let type = cardActionType {
            return type
        } else {
            return .none
        }
    }
    
    func getValue() -> Int {
        if let val = cardValue {
            return val
        } else {
            return -1
        }
    }
    
    func getEvent() -> String {
        if let event = cardEvent {
            return event
        } else {
            return ""
        }
    }
    
    func getEvent() -> CardLuck {
        if let luck = cardLuck {
            return luck
        } else {
            return .none
        }
    }
}
