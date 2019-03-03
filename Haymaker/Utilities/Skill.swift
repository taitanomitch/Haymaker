//
//  Skill.swift
//  Haymaker
//
//  Created by Mitchell Taitano on 11/15/18.
//  Copyright © 2018 Mitchell Taitano. All rights reserved.
//

import Foundation

class Skill {
    
    var usesPerCombat: Int = 0
    var timesUsed: Int = 0
    
    var type: AttackType = .none
    var stance: Stance = .none
    var skill: SkillNames = .none
    
    enum Stance {
        case attack
        case defend
        case none
    }
    
    enum SkillNames {
        case grapple1       //Strength - attack - enemy is grappled on successful attack
        case grapple2       //Strength - attack - enemy is grappled and defenseless on successful attack
        case grapple3       //Strength - attack - enemy is grappled, stunned and defenseless on successful attack
        case throw1         //Strength - attack - throw grappled enemy, after 1 turn of falling, take attack damage plus falling damage
        case brace1         //Strength - defend - attack automatically hits - reduce damage taken by 4
        case brace2         //Strength - defend - attack automatically hits - reduce damage taken by 8
        case brace3         //Strength - defend - attack automatically hits - reduce damage taken by 12
        case wildStrike1    //Strength - attack - Damage +3 - Become defenseless
        case wildStrike2    //Strength - attack - Damage +5 - Become defenseless
        case wildStrike3    //Strength - attack - Damage +7 - Become defenseless
        case doubleStrike1  //Agility - attack - attack again if missed
        case doubleStrike2  //Agility - attack - attack twice
        case doubleStrike3  //Agility - attack - attack twice - 2 Uses per combat
        case deflect1       //Agility - defend - Edge +1 on range defense
        case deflect2       //Agility - defend - Edge +1 on any defense
        case deflect3       //Agility - defend - Edge +2 on any defense
        case outwit1        //Intellect - defend - On successful dodge, enemy attack returns to enemy
        case outwit2        //Intellect - defend - +2 to Dodge - On successful dodge, enemy attack returns to enemy
        case outwit3        //Intellect - defend - +4 to Dodge - On successful dodge, enemy attack returns to enemy
        case criticalStrike1    //Intellect - attack - Successful attack does +1 Damage
        case criticalStrike2    //Intellect - attack - Successful attack does +5 Damage
        case criticalStrike3    //Intellect - attack - Successful attack does +9 Damage
        case pickPocket1    //Intellect - none - Extra money after fights
        case pickPocket2    //Intellect - none - More extra money after fights
        case pickPocket3    //Intellect - none - Even more extra money after fights
        case weapons1       //Agility - attack - allows for weapon use with reduced attack
        case weapons2       //Agility - attack - allows for weapon use without reduced attack
        case weapons3       //Agility - attack - weapon bonus also applies to attack
        case resolve1       //Willpower - none - May attempt to stabalize on positive outcome
        case resolve2       //Willpower - none - May attempt to stabalize on positive or neutral outcome
        case resolve3       //Willpower - none - May attempt to stabalize on any outcome
        case intimidate1    //Willpower - attack - On successful attack, enemy has -3 to Willpower
        case intimidate2    //Willpower - attack - On successful attack, enemy has -3 to Willpower and Stength
        case intimidate3    //Willpower - attack - On successful attack, enemy has -3 to All Stats
        case vanish1        //Agility - attack - On successful attack, enemy has noAttack and vulnerable
        case none
    }
}
