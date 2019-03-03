//
//  ParagonOverseer.swift
//  Haymaker
//
//  Created by Mitchell Taitano on 11/15/18.
//  Copyright © 2018 Mitchell Taitano. All rights reserved.
//

import Foundation

class ParagonOverseer {
    
    var Name: String = ""
    
    // MARK: - Character Stat Variables
    var Strength: Int = 0
    var Agility: Int = 0
    var Intellect: Int = 0
    var Willpower: Int = 0
    var Edge: Int = 0
    var Handsize: Int = 0
    
    // MARK: - Character Boolean Variables
    var HasPower: Bool = false
    var HasEquipment: Bool = false
    var HasSkill: Bool = false
    
    // MARK: - Character Action Variables
    var CurrentActionType: ActionType = .none
    var CurrentAttackType: AttackType = .none
    var AttackPosition: Int = 0
    
    // MARK: - Character Skill/Power/Equipment List Variables
    var CharacterStatus: Status = .none
    var Powers: [Power] = []
    var PowerInUse: Power = Power()
    var Skills: [Skill] = []
    var SkillInUse: Skill = Skill()
    var EquipmentList: [Equipment] = []
    var EquippedItem: Equipment = Equipment()
    var PossibleAttackTypeList: [ActionType] = []
    var AttackTypeNames: [String] = []
    var AttackValues: [Int] = []
    var DamageBonuses: [Int] = []
    var DodgeBonus: Int = 0
    var DamageResistance: Int = 0
    var WillpowerResistanceBonus: Int = 0
    
    // MARK: - Character Status Enum
    enum Status {
        case normal
//        case enraged
        case stunned
//        case slept
//        case prone
//        case burned
//        case poisoned
        case falling
        case grappled
        case defenseless
        case vulnerable
        case noAttack
        case none
    }
    
    // MARK: - Value Calculator Functions
    func attackValue() -> Int {
        var attackValue = 0
        
        switch CurrentAttackType {
        case .strength:
            attackValue = attackValue + Strength
        case .agility:
            attackValue = attackValue + Agility
        case .intellect:
            attackValue = attackValue + Intellect
        case .willpower:
            attackValue = attackValue + Willpower
        default:
            return 0
        }
        
        //Add Any Weapon Modifiers
        if EquippedItem.item != Equipment.EquipmentList.none {
            if (EquippedItem.determineEquipmentStance(equipment: EquippedItem.item) == Equipment.EquipmentStance.attackAndDamage) {
                attackValue = attackValue + EquippedItem.determineEquipmentBonusValue(equipment: EquippedItem.item)
            } else if (Skills.contains(where: { (skill) -> Bool in
                return skill.skill == Skill.SkillNames.weapons3
            }) && (EquippedItem.determineEquipmentStance(equipment: EquippedItem.item) == Equipment.EquipmentStance.damage)) {
                attackValue = attackValue + EquippedItem.determineEquipmentBonusValue(equipment: EquippedItem.item)
            }
        }
        
        //Add Any Skill Modifiers
        
        
        //Add Any Power Modifiers
        
        
        return attackValue
    }
    
    func damageValue() -> Int {
        var damageValue = 0
        
        //Add Weapon's Base Modifier
        if EquippedItem.item != Equipment.EquipmentList.none {
            if (EquippedItem.determineEquipmentStance(equipment: EquippedItem.item) == Equipment.EquipmentStance.damage) ||
                (EquippedItem.determineEquipmentStance(equipment: EquippedItem.item) == Equipment.EquipmentStance.attackAndDamage) {
                damageValue = damageValue + EquippedItem.determineEquipmentBonusValue(equipment: EquippedItem.item)
            }
        }
        
        //Return Sum of Modifiers
        return damageValue
    }
    
    // MARK: - Debugging Functions
    public func printCharacterStats() {
        print("--Hand Size: \(Handsize)")
        print("--Edge: \(Edge)")
        print("")
        print("Strength: \(Strength)")
        print("Agility: \(Agility)")
        print("Intellect: \(Intellect)")
        print("Willpower: \(Willpower)")
    }
}

class HeroGenerator {
    
    var numberOfHeroes: Int = 15
    
    func theThing() -> ParagonOverseer {
        let hero = ParagonOverseer()
        hero.Name = "The Thing"
        hero.Strength = 18
        hero.Agility = 5
        hero.Intellect = 6
        hero.Willpower = 8
        hero.Handsize = 5
        hero.Edge = 3
        hero.CharacterStatus = .none
        hero.EquipmentList = []
        hero.Powers = []
        hero.Skills = []
        hero.PossibleAttackTypeList = [.strength, .agility, .none, .none]
        hero.AttackTypeNames = ["Clobber", "Charge", "", ""]
        hero.AttackValues = [18,5,0,0]
        hero.DamageBonuses = [0, 0, 0, 0]
        hero.DodgeBonus = 0
        hero.DamageResistance = 4
        hero.WillpowerResistanceBonus = 0
        return hero
    }
    
    func ironMan() -> ParagonOverseer {
        let hero = ParagonOverseer()
        hero.Name = "Iron Man"
        hero.Strength = 16
        hero.Agility = 6
        hero.Intellect = 10
        hero.Willpower = 6
        hero.Handsize = 5
        hero.Edge = 3
        hero.CharacterStatus = .none
        hero.EquipmentList = []
        hero.Powers = []
        hero.Skills = []
        hero.PossibleAttackTypeList = [.strength, .agility, .intellect, .none]
        hero.AttackTypeNames = ["Uppercut", "Charge", "Uni-Beam", ""]
        hero.AttackValues = [16, 6, 16, 0]
        hero.DamageBonuses = [0, 0, 0, 0]
        hero.DodgeBonus = 0
        hero.DamageResistance = 0
        hero.WillpowerResistanceBonus = 0
        return hero
    }
    
    func spiderman() -> ParagonOverseer {
        let hero = ParagonOverseer()
        hero.Name = "Spiderman"
        hero.Strength = 14
        hero.Agility = 14
        hero.Intellect = 8
        hero.Willpower = 10
        hero.Handsize = 5
        hero.Edge = 3
        hero.CharacterStatus = .none
        hero.EquipmentList = []
        hero.Powers = []
        hero.Skills = []
        hero.PossibleAttackTypeList = [.strength, .agility, .intellect, .none]
        hero.AttackTypeNames = ["Uppercut", "Sweep Kick", "Web-shooters", ""]
        hero.AttackValues = [14, 4, 16, 0]
        hero.DamageBonuses = [0, 0, 0, 0]
        hero.DodgeBonus = 4
        hero.DamageResistance = 0
        hero.WillpowerResistanceBonus = 0
        return hero
    }
    
    func wolverine() -> ParagonOverseer {
        let hero = ParagonOverseer()
        hero.Name = "Wolverine"
        hero.Strength = 8
        hero.Agility = 10
        hero.Intellect = 6
        hero.Willpower = 10
        hero.Handsize = 5
        hero.Edge = 3
        hero.CharacterStatus = .none
        hero.EquipmentList = []
        hero.Powers = []
        hero.Skills = []
        hero.PossibleAttackTypeList = [.strength, .agility, .none, .none]
        hero.AttackTypeNames = ["Claw Jab", "Claw Slash", "", ""]
        hero.AttackValues = [8, 10, 0, 0]
        hero.DamageBonuses = [5, 5, 0, 0]
        hero.DodgeBonus = 0
        hero.DamageResistance = 0
        hero.WillpowerResistanceBonus = 0
        return hero
    }
    
    func hulk() -> ParagonOverseer {
        let hero = ParagonOverseer()
        hero.Name = "Hulk"
        hero.Strength = 20
        hero.Agility = 3
        hero.Intellect = 1
        hero.Willpower = 8
        hero.Handsize = 5
        hero.Edge = 3
        hero.CharacterStatus = .none
        hero.EquipmentList = []
        hero.Powers = []
        hero.Skills = []
        hero.PossibleAttackTypeList = [.strength, .agility, .none, .none]
        hero.AttackTypeNames = ["Smash", "Charge", "", ""]
        hero.AttackValues = [3, 3, 0, 0]
        hero.DamageBonuses = [20, 0, 0, 0]
        hero.DodgeBonus = 0
        hero.DamageResistance = 4
        hero.WillpowerResistanceBonus = 0
        return hero
    }
    
    func captainAmerica() -> ParagonOverseer {
        let hero = ParagonOverseer()
        hero.Name = "Captain America"
        hero.Strength = 10
        hero.Agility = 10
        hero.Intellect = 6
        hero.Willpower = 12
        hero.Handsize = 6
        hero.Edge = 4
        hero.CharacterStatus = .none
        hero.EquipmentList = []
        hero.Powers = []
        hero.Skills = []
        hero.PossibleAttackTypeList = [.strength, .agility, .none, .none]
        hero.AttackTypeNames = ["Uppercut", "Charge", "", ""]
        hero.AttackValues = [10, 10, 0, 0]
        hero.DamageBonuses = [5, 5, 0, 0]
        hero.DodgeBonus = 0
        hero.DamageResistance = 17
        hero.WillpowerResistanceBonus = 0
        return hero
    }
    
    func daredevil() -> ParagonOverseer {
        let hero = ParagonOverseer()
        hero.Name = "Daredevil"
        hero.Strength = 8
        hero.Agility = 10
        hero.Intellect = 8
        hero.Willpower = 8
        hero.Handsize = 5
        hero.Edge = 3
        hero.CharacterStatus = .none
        hero.EquipmentList = []
        hero.Powers = []
        hero.Skills = []
        hero.PossibleAttackTypeList = [.strength, .agility, .none, .none]
        hero.AttackTypeNames = ["Boxing", "Dive", "", ""]
        hero.AttackValues = [8, 10, 0, 0]
        hero.DamageBonuses = [2, 2, 0, 0]
        hero.DodgeBonus = 0
        hero.DamageResistance = 0
        hero.WillpowerResistanceBonus = 0
        return hero
    }
    
    func doctorStrange() -> ParagonOverseer {
        let hero = ParagonOverseer()
        hero.Name = "Doctor Strange"
        hero.Strength = 3
        hero.Agility = 4
        hero.Intellect = 8
        hero.Willpower = 16
        hero.Handsize = 5
        hero.Edge = 3
        hero.CharacterStatus = .none
        hero.EquipmentList = []
        hero.Powers = []
        hero.Skills = []
        hero.PossibleAttackTypeList = [.strength, .agility, .none, .willpower]
        hero.AttackTypeNames = ["Punch", "Kick", "", "Magic"]
        hero.AttackValues = [3, 4, 0, 16]
        hero.DamageBonuses = [0, 0, 0, 0]
        hero.DodgeBonus = 0
        hero.DamageResistance = 0
        hero.WillpowerResistanceBonus = 8
        return hero
    }
    
    func humanTorch() -> ParagonOverseer {
        let hero = ParagonOverseer()
        hero.Name = "Human Torch"
        hero.Strength = 4
        hero.Agility = 8
        hero.Intellect = 5
        hero.Willpower = 6
        hero.Handsize = 4
        hero.Edge = 2
        hero.CharacterStatus = .none
        hero.EquipmentList = []
        hero.Powers = []
        hero.Skills = []
        hero.PossibleAttackTypeList = [.strength, .agility, .intellect, .none]
        hero.AttackTypeNames = ["Punch", "Dive Bomb", "Fire Blast", ""]
        hero.AttackValues = [4, 8, 18, 0]
        hero.DamageBonuses = [0, 0, 0, 0]
        hero.DodgeBonus = 0
        hero.DamageResistance = 0
        hero.WillpowerResistanceBonus = 0
        return hero
    }
    
    func invisibleWoman() -> ParagonOverseer {
        let hero = ParagonOverseer()
        hero.Name = "Invisible Woman"
        hero.Strength = 4
        hero.Agility = 6
        hero.Intellect = 6
        hero.Willpower = 10
        hero.Handsize = 5
        hero.Edge = 3
        hero.CharacterStatus = .none
        hero.EquipmentList = []
        hero.Powers = []
        hero.Skills = []
        hero.PossibleAttackTypeList = [.strength, .agility, .intellect, .none]
        hero.AttackTypeNames = ["Punch", "Martial Arts", "Force Blast", ""]
        hero.AttackValues = [4, 6, 15, 0]
        hero.DamageBonuses = [0, 0, 0, 0]
        hero.DodgeBonus = 8
        hero.DamageResistance = 15
        hero.WillpowerResistanceBonus = 0
        return hero
    }
    
    func misterFantastic() -> ParagonOverseer {
        let hero = ParagonOverseer()
        hero.Name = "Mister Fantastic"
        hero.Strength = 3
        hero.Agility = 4
        hero.Intellect = 12
        hero.Willpower = 8
        hero.Handsize = 5
        hero.Edge = 3
        hero.CharacterStatus = .none
        hero.EquipmentList = []
        hero.Powers = []
        hero.Skills = []
        hero.PossibleAttackTypeList = [.strength, .agility, .none, .none]
        hero.AttackTypeNames = ["Punch", "Telescopic Kick", "", ""]
        hero.AttackValues = [3, 15, 0, 0]
        hero.DamageBonuses = [0, 0, 0, 0]
        hero.DodgeBonus = 0
        hero.DamageResistance = 0
        hero.WillpowerResistanceBonus = 0
        return hero
    }
    
    func nightcrawler() -> ParagonOverseer {
        let hero = ParagonOverseer()
        hero.Name = "Nightcrawler"
        hero.Strength = 6
        hero.Agility = 12
        hero.Intellect = 5
        hero.Willpower = 7
        hero.Handsize = 4
        hero.Edge = 2
        hero.CharacterStatus = .none
        hero.EquipmentList = []
        hero.Powers = []
        hero.Skills = []
        hero.PossibleAttackTypeList = [.strength, .agility, .none, .none]
        hero.AttackTypeNames = ["Punch", "Sweep Kick", "", ""]
        hero.AttackValues = [6, 12, 0, 0]
        hero.DamageBonuses = [0, 4, 0, 0]
        hero.DodgeBonus = 3
        hero.DamageResistance = 0
        hero.WillpowerResistanceBonus = 0
        return hero
    }
    
    func silverSurfer() -> ParagonOverseer {
        let hero = ParagonOverseer()
        hero.Name = "Silver Surfer"
        hero.Strength = 20
        hero.Agility = 20
        hero.Intellect = 7
        hero.Willpower = 10
        hero.Handsize = 5
        hero.Edge = 3
        hero.CharacterStatus = .none
        hero.EquipmentList = []
        hero.Powers = []
        hero.Skills = []
        hero.PossibleAttackTypeList = [.strength, .agility, .intellect, .none]
        hero.AttackTypeNames = ["Pummel", "Dive Kick", "Cosmic Blast", ""]
        hero.AttackValues = [20, 20, 20, 0]
        hero.DamageBonuses = [0, 0, 0, 0]
        hero.DodgeBonus = 0
        hero.DamageResistance = 0
        hero.WillpowerResistanceBonus = 0
        return hero
    }
    
    func thor() -> ParagonOverseer {
        let hero = ParagonOverseer()
        hero.Name = "Thor"
        hero.Strength = 19
        hero.Agility = 5
        hero.Intellect = 5
        hero.Willpower = 8
        hero.Handsize = 5
        hero.Edge = 3
        hero.CharacterStatus = .none
        hero.EquipmentList = []
        hero.Powers = []
        hero.Skills = []
        hero.PossibleAttackTypeList = [.strength, .agility, .intellect, .none]
        hero.AttackTypeNames = ["Smash", "Kick", "Lightning Bolt", ""]
        hero.AttackValues = [19, 5, 18, 0]
        hero.DamageBonuses = [7, 7, 0, 0]
        hero.DodgeBonus = 0
        hero.DamageResistance = 3
        hero.WillpowerResistanceBonus = 0
        return hero
    }
    
    func blackPanther() -> ParagonOverseer {
        let hero = ParagonOverseer()
        hero.Name = "BlackPanther"
        hero.Strength = 9
        hero.Agility = 10
        hero.Intellect = 7
        hero.Willpower = 8
        hero.Handsize = 5
        hero.Edge = 3
        hero.CharacterStatus = .none
        hero.EquipmentList = []
        hero.Powers = []
        hero.Skills = []
        hero.PossibleAttackTypeList = [.strength, .agility, .none, .none]
        hero.AttackTypeNames = ["Garrotes", "Energy Dagger", "", ""]
        hero.AttackValues = [9, 10, 0, 0]
        hero.DamageBonuses = [3, 3, 0, 0]
        hero.DodgeBonus = 2
        hero.DamageResistance = 0
        hero.WillpowerResistanceBonus = 0
        return hero
    }
}

class EnemyGenerator {
    
    var numberOfVillains: Int = 12
    var numberOfHenchmen: Int = 3
    
    func drDoom() -> ParagonOverseer {
        let enemy = ParagonOverseer()
        
        enemy.Name = "Dr. Doom"
        enemy.Handsize = 6
        enemy.Edge = 4
        
        enemy.Strength = 14
        enemy.Agility = 6
        enemy.Intellect = 12
        enemy.Willpower = 12
        
        enemy.CharacterStatus = .none
        enemy.EquipmentList = []
        enemy.Powers = []
        enemy.Skills = []
        enemy.PossibleAttackTypeList = [.strength, .agility, .intellect, .none]
        enemy.AttackTypeNames = ["Uppercut", "Strike", "Power Blast", "Magic"]
        enemy.AttackValues = [14, 6, 14, 8]
        enemy.DamageBonuses = [0, 4, 0, 0]
        enemy.DodgeBonus = 0
        enemy.DamageResistance = 0
        enemy.WillpowerResistanceBonus = 0
        return enemy
    }
    
    func annihilus() -> ParagonOverseer {
        let enemy = ParagonOverseer()
        
        enemy.Name = "Annihilus"
        enemy.Handsize = 5
        enemy.Edge = 3
        
        enemy.Strength = 16
        enemy.Agility = 7
        enemy.Intellect = 8
        enemy.Willpower = 8
        
        enemy.CharacterStatus = .none
        enemy.EquipmentList = []
        enemy.Powers = []
        enemy.Skills = []
        enemy.PossibleAttackTypeList = [.strength, .agility, .intellect, .none]
        enemy.AttackTypeNames = ["Bash", "Sweep", "Cosmic Control Rod", ""]
        enemy.AttackValues = [16, 7, 18, 0]
        enemy.DamageBonuses = [0, 0, 0, 0]
        enemy.DodgeBonus = 0
        enemy.DamageResistance = 4
        enemy.WillpowerResistanceBonus = 0
        return enemy
    }
    
    func galactus() -> ParagonOverseer {
        let enemy = ParagonOverseer()
        
        enemy.Name = "Galactus"
        enemy.Handsize = 7
        enemy.Edge = 5
        
        enemy.Strength = 30
        enemy.Agility = 10
        enemy.Intellect = 30
        enemy.Willpower = 30
        
        enemy.CharacterStatus = .none
        enemy.EquipmentList = []
        enemy.Powers = []
        enemy.Skills = []
        enemy.PossibleAttackTypeList = [.strength, .agility, .intellect, .none]
        enemy.AttackTypeNames = ["Smash", "Stomp", "Cosmic Energy Blast", ""]
        enemy.AttackValues = [30, 10, 30, 0]
        enemy.DamageBonuses = [0, 0, 0, 0]
        enemy.DodgeBonus = 0
        enemy.DamageResistance = 30
        enemy.WillpowerResistanceBonus = 0
        return enemy
    }
    
    func juggernaut() -> ParagonOverseer {
        let enemy = ParagonOverseer()
        
        enemy.Name = "Juggernaut"
        enemy.Handsize = 4
        enemy.Edge = 2
        
        enemy.Strength = 19
        enemy.Agility = 2
        enemy.Intellect = 3
        enemy.Willpower = 4
        
        enemy.CharacterStatus = .none
        enemy.EquipmentList = []
        enemy.Powers = []
        enemy.Skills = []
        enemy.PossibleAttackTypeList = [.strength, .agility, .none, .none]
        enemy.AttackTypeNames = ["Haymaker", "Charge", "", ""]
        enemy.AttackValues = [19, 2, 0, 0]
        enemy.DamageBonuses = [0, 0, 0, 0]
        enemy.DodgeBonus = 0
        enemy.DamageResistance = 7
        enemy.WillpowerResistanceBonus = 99
        return enemy
    }
    
    func loki() -> ParagonOverseer {
        let enemy = ParagonOverseer()
        
        enemy.Name = "Loki"
        enemy.Handsize = 5
        enemy.Edge = 3
        
        enemy.Strength = 16
        enemy.Agility = 6
        enemy.Intellect = 8
        enemy.Willpower = 15
        
        enemy.CharacterStatus = .none
        enemy.EquipmentList = []
        enemy.Powers = []
        enemy.Skills = []
        enemy.PossibleAttackTypeList = [.strength, .agility, .intellect, .willpower]
        enemy.AttackTypeNames = ["Punch", "Charge", "Illusion Attack", "Magic"]
        enemy.AttackValues = [16, 6, 14, 15]
        enemy.DamageBonuses = [-16, 0, 0, 0]
        enemy.DodgeBonus = 0
        enemy.DamageResistance = 0
        enemy.WillpowerResistanceBonus = 0
        return enemy
    }
    
    func magneto() -> ParagonOverseer {
        let enemy = ParagonOverseer()
        
        enemy.Name = "Magneto"
        enemy.Handsize = 6
        enemy.Edge = 4
        
        enemy.Strength = 7
        enemy.Agility = 6
        enemy.Intellect = 10
        enemy.Willpower = 12
        
        enemy.CharacterStatus = .none
        enemy.EquipmentList = []
        enemy.Powers = []
        enemy.Skills = []
        enemy.PossibleAttackTypeList = [.strength, .agility, .intellect, .none]
        enemy.AttackTypeNames = ["Punch", "Kick", "Magnetic Blast", ""]
        enemy.AttackValues = [7, 6, 18, 0]
        enemy.DamageBonuses = [0, 0, 0, 0]
        enemy.DodgeBonus = 0
        enemy.DamageResistance = 3
        enemy.WillpowerResistanceBonus = 0
        return enemy
    }
    
    func rhino() -> ParagonOverseer {
        let enemy = ParagonOverseer()
        
        enemy.Name = "Rhino"
        enemy.Handsize = 3
        enemy.Edge = 1
        
        enemy.Strength = 17
        enemy.Agility = 2
        enemy.Intellect = 2
        enemy.Willpower = 2
        
        enemy.CharacterStatus = .none
        enemy.EquipmentList = []
        enemy.Powers = []
        enemy.Skills = []
        enemy.PossibleAttackTypeList = [.strength, .agility, .none, .none]
        enemy.AttackTypeNames = ["Smash", "Charge", "", ""]
        enemy.AttackValues = [17, 2, 0, 0]
        enemy.DamageBonuses = [5, 5, 0, 0]
        enemy.DodgeBonus = 0
        enemy.DamageResistance = 5
        enemy.WillpowerResistanceBonus = 0
        return enemy
    }
    
    func sabertooth() -> ParagonOverseer {
        let enemy = ParagonOverseer()
        
        enemy.Name = "Sabertooth"
        enemy.Handsize = 4
        enemy.Edge = 2
        
        enemy.Strength = 10
        enemy.Agility = 10
        enemy.Intellect = 4
        enemy.Willpower = 9
        
        enemy.CharacterStatus = .none
        enemy.EquipmentList = []
        enemy.Powers = []
        enemy.Skills = []
        enemy.PossibleAttackTypeList = [.strength, .agility, .none, .none]
        enemy.AttackTypeNames = ["Claw", "Slash", "", ""]
        enemy.AttackValues = [10, 10, 0, 0]
        enemy.DamageBonuses = [2, 2, 0, 0]
        enemy.DodgeBonus = 0
        enemy.DamageResistance = 0
        enemy.WillpowerResistanceBonus = 0
        return enemy
    }
    
    func superSkrull() -> ParagonOverseer {
        let enemy = ParagonOverseer()
        
        enemy.Name = "Super-Skrull"
        enemy.Handsize = 5
        enemy.Edge = 3
        
        enemy.Strength = 16
        enemy.Agility = 6
        enemy.Intellect = 5
        enemy.Willpower = 6
        
        enemy.CharacterStatus = .none
        enemy.EquipmentList = []
        enemy.Powers = []
        enemy.Skills = []
        enemy.PossibleAttackTypeList = [.strength, .agility, .intellect, .none]
        enemy.AttackTypeNames = ["Clobber", "Telescoping Kick", "Fire Blast", ""]
        enemy.AttackValues = [16, 16, 16, 0]
        enemy.DamageBonuses = [0, 0, 0, 0]
        enemy.DodgeBonus = 0
        enemy.DamageResistance = 4
        enemy.WillpowerResistanceBonus = 0
        return enemy
    }
    
    func thanos() -> ParagonOverseer {
        let enemy = ParagonOverseer()
        
        enemy.Name = "Thanos"
        enemy.Handsize = 5
        enemy.Edge = 3
        
        enemy.Strength = 19
        enemy.Agility = 5
        enemy.Intellect = 16
        enemy.Willpower = 17
        
        enemy.CharacterStatus = .none
        enemy.EquipmentList = []
        enemy.Powers = []
        enemy.Skills = []
        enemy.PossibleAttackTypeList = [.strength, .agility, .intellect, .willpower]
        enemy.AttackTypeNames = ["Smash", "Charge", "Cosmic Blast", "Psychic Blast"]
        enemy.AttackValues = [19, 5, 24, 16]
        enemy.DamageBonuses = [0, 0, 0, 0]
        enemy.DodgeBonus = 0
        enemy.DamageResistance = 8
        enemy.WillpowerResistanceBonus = 0
        return enemy
    }
    
    func ultron() -> ParagonOverseer {
        let enemy = ParagonOverseer()
        
        enemy.Name = "Ultron"
        enemy.Handsize = 5
        enemy.Edge = 3
        
        enemy.Strength = 16
        enemy.Agility = 6
        enemy.Intellect = 9
        enemy.Willpower = 14
        
        enemy.CharacterStatus = .none
        enemy.EquipmentList = []
        enemy.Powers = []
        enemy.Skills = []
        enemy.PossibleAttackTypeList = [.strength, .agility, .intellect, .none]
        enemy.AttackTypeNames = ["Pummel", "Charge", "Laser Beam", ""]
        enemy.AttackValues = [16, 6, 16, 0]
        enemy.DamageBonuses = [0, 0, 0, 0]
        enemy.DodgeBonus = 0
        enemy.DamageResistance = 5
        enemy.WillpowerResistanceBonus = 0
        return enemy
    }
    
    func venom() -> ParagonOverseer {
        let enemy = ParagonOverseer()
        
        enemy.Name = "Venom"
        enemy.Handsize = 4
        enemy.Edge = 2
        
        enemy.Strength = 15
        enemy.Agility = 11
        enemy.Intellect = 4
        enemy.Willpower = 9
        
        enemy.CharacterStatus = .none
        enemy.EquipmentList = []
        enemy.Powers = []
        enemy.Skills = []
        enemy.PossibleAttackTypeList = [.strength, .agility, .intellect, .none]
        enemy.AttackTypeNames = ["Claw", "Slash", "", ""]
        enemy.AttackValues = [16, 11, 14, 0]
        enemy.DamageBonuses = [1, 1, 0, 0]
        enemy.DodgeBonus = 0
        enemy.DamageResistance = 0
        enemy.WillpowerResistanceBonus = 0
        return enemy
    }
    
    func thug() -> ParagonOverseer {
        let enemy = ParagonOverseer()
        
        enemy.Name = "Thug"
        enemy.Handsize = 3
        enemy.Edge = 1
        
        enemy.Strength = 3
        enemy.Agility = 2
        enemy.Intellect = 1
        enemy.Willpower = 2
        
        enemy.CharacterStatus = .none
        enemy.EquipmentList = []
        enemy.Powers = []
        enemy.Skills = []
        enemy.PossibleAttackTypeList = [.strength, .agility, .none, .none]
        enemy.AttackTypeNames = ["Punch", "Knife", "", ""]
        enemy.AttackValues = [3, 2, 0, 0]
        enemy.DamageBonuses = [0, 1, 0, 0]
        enemy.DodgeBonus = 0
        enemy.DamageResistance = 0
        enemy.WillpowerResistanceBonus = 0
        return enemy
    }
    
    func brute() -> ParagonOverseer {
        let enemy = ParagonOverseer()
        
        enemy.Name = "Brute"
        enemy.Handsize = 4
        enemy.Edge = 2
        
        enemy.Strength = 6
        enemy.Agility = 2
        enemy.Intellect = 1
        enemy.Willpower = 5
        
        enemy.CharacterStatus = .none
        enemy.EquipmentList = []
        enemy.Powers = []
        enemy.Skills = []
        enemy.PossibleAttackTypeList = [.strength, .agility, .none, .none]
        enemy.AttackTypeNames = ["Hammer Slam", "Kick", "", ""]
        enemy.AttackValues = [6, 2, 0, 0]
        enemy.DamageBonuses = [2, 0, 0, 0]
        enemy.DodgeBonus = 0
        enemy.DamageResistance = 0
        enemy.WillpowerResistanceBonus = 0
        return enemy
    }
    
    func ninja() -> ParagonOverseer {
        let enemy = ParagonOverseer()
        
        enemy.Name = "Ninja"
        enemy.Handsize = 3
        enemy.Edge = 1
        
        enemy.Strength = 3
        enemy.Agility = 6
        enemy.Intellect = 3
        enemy.Willpower = 4
        
        enemy.CharacterStatus = .none
        enemy.EquipmentList = []
        enemy.Powers = []
        enemy.Skills = []
        enemy.PossibleAttackTypeList = [.strength, .agility, .none, .none]
        enemy.AttackTypeNames = ["Jab", "Martial Arts", "", ""]
        enemy.AttackValues = [3, 6, 0, 0]
        enemy.DamageBonuses = [1, 2, 0, 0]
        enemy.DodgeBonus = 0
        enemy.DamageResistance = 0
        enemy.WillpowerResistanceBonus = 0
        return enemy
    }
}
