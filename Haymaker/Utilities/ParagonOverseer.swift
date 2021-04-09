//
//  ParagonOverseer.swift
//  Haymaker
//
//  Created by Mitchell Taitano on 11/15/18.
//  Copyright © 2018 Mitchell Taitano. All rights reserved.
//

import Foundation

class ParagonOverseer {
    
    enum AbilityPowers {
        case strengthIncrease
        case healingFactor
        case none
    }
    
    var Name: String = ""
    var ParagonPassword: String = ""
    var Bio: String = ""
    var CombatAbilities: String = ""
    
    // MARK: - Character Stat Variables
    var Strength: Int = 0
    var Agility: Int = 0
    var Intellect: Int = 0
    var Willpower: Int = 0
    var Edge: Int = 0
    var Handsize: Int = 0
    var StartingHandsize: Int = 0
    
    // MARK: - Character Boolean Variables
    var HasPower: Bool = false
    var HasEquipment: Bool = false
    var HasSkill: Bool = false
    
    // MARK: - Character Action Variables
    var CurrentActionType: ActionType = .none
    var CurrentAttackType: AttackType = .none
    var AttackPosition: Int = 0
    
    // MARK: - Character Entry Taunt
    var EntryTaunt: String = ""
    
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
    var ParagonAbilityPower: AbilityPowers = .none
    var ParagonAbilityPowerMultiplier: Int = 1
    var ParagonAbilityPowerText: String = ""
    var ReviveAttemptCount: Int = 0
    
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
    
    // MARK: - Combat Preparation Functions
    func resetHandSize() {
        Handsize = StartingHandsize
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
    
    // MARK: - Paragon Combat Ability String Generator Functions
    public func getParagonCombatAbilityText() -> String {
        var CombatAbilityText: String = ""
        CombatAbilityText += "ATTACKS:"
        for i in 0...3 {
            var AttackType: String = ""
            if AttackValues[i] != 0 {
                if CombatAbilityText != "" {
                    CombatAbilityText += "\n"
                }
                
                switch i {
                case 0:
                    AttackType = "Strength"
                case 1:
                    AttackType = "Agility"
                case 2:
                    AttackType = "Intellect"
                case 3:
                    AttackType = "Willpower"
                default:
                    AttackType = ""
                }
                
                CombatAbilityText += "\u{2022} [\(AttackType)] \(AttackTypeNames[i]) Attack: \(AttackValues[i])"
                if DamageBonuses[i] != 0 {
                    CombatAbilityText += "\n\t\u{2023} Bonus Damage: +\(DamageBonuses[i])"
                }
            }
        }
        
        if ParagonAbilityPower != .none {
            CombatAbilityText += "\n\nCOMBAT POWER:\n"
            switch ParagonAbilityPower {
            case .healingFactor:
                CombatAbilityText += "\u{2022} HEALING FACTOR: \(Name) regenerates up to \(ParagonAbilityPowerMultiplier) lost card(s) after every turn."
            case .strengthIncrease:
                CombatAbilityText += "\u{2022} STENGTH INCREASE: \(Name)'s Strength increases by \(ParagonAbilityPowerMultiplier) after every turn."
            case .none:
                CombatAbilityText += ""
            }
        }
        return CombatAbilityText
    }
    
    
    // MARK: - Hero Power Abilities
    public func performAbilityPower() {
        switch ParagonAbilityPower {
        case .strengthIncrease:
            self.Strength = self.Strength + (1 * ParagonAbilityPowerMultiplier)
        case .healingFactor:
            if self.Handsize < StartingHandsize {
                self.Handsize = self.Handsize + (1 * ParagonAbilityPowerMultiplier)
                if self.Handsize >= self.StartingHandsize {
                    resetHandSize()
                }
            }
        case .none:
            return
        }
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
        hero.EntryTaunt = "It's clobberin' time!"
        hero.Strength = 18
        hero.Agility = 5
        hero.Intellect = 6
        hero.Willpower = 8
        hero.Handsize = 5
        hero.StartingHandsize = 5
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
        hero.Bio = "Benjamin Jacob Grimm was born on Yancy Street in the heart of New York City into a poor Jewish family. When Ben was a young kid his older brother, Daniel Grimm, was the leader of the Yancy Street Gang, a group of young trouble-makers from the area. When he was old enough Ben joined this gang as well. He was inducted into the gang by being ‘beaten in.’ Growing up poor along with his gang affiliation and related activities made Ben street-smart, tough and 'hard' very early in life. All of these personality characteristics have served him well throughout his lifetime of brawling and adventuring. During Ben's formative years tragedy struck his family hard; his older brother Daniel was killed in a gang fight when Ben was still a kid and his parents Daniel, Sr. and Elsie both died in an accident when he was a teenager. Ben was placed in the custody of his Uncle Jake (his father's brother) and Aunt Alyce (Jake's first wife) who took him from New York to Arizona. Unfortunately, Alyce died relatively young. After Alyce's death, Jake Grimm re-married. His second wife's name was Sophie, whom he also out-lived. Jake married yet a third time, this time to a much younger woman named Petunia (whom Ben speaks of quite often). Now physically removed from his past troubles, Ben did well in high school, using his natural talent to his advantage becoming an excellent football player, Ben won an athletic scholarship to Empire State University where he met, roomed and became best friends with Reed Richards. While attending university Ben and Reed also meet Victor Von Doom who was studying there as well. After college, Ben joined the US Air Force and became a fantastic pilot, often testing experimental aircraft and even flying top secret missions for the US government. His piloting skills eventually landed him a spot at NASA."
        return hero
    }
    
    func ironMan() -> ParagonOverseer {
        let hero = ParagonOverseer()
        hero.Name = "Iron Man"
        hero.EntryTaunt = "I am Iron Man!"
        hero.Strength = 16
        hero.Agility = 6
        hero.Intellect = 10
        hero.Willpower = 6
        hero.Handsize = 5
        hero.StartingHandsize = 5
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
        hero.Bio = "Anthony Edward \"Tony\" Stark was born in Long Island, New York, to Howard Anthony Stark and Maria Collins Carbonell Stark. In his youth, Tony Stark was a precociously intelligent young boy. When Tony was 7 he was sent to a boarding school, and during this experience he found people difficult to relate to. This was when he became fascinated by machines. By the age of 15 Tony had enrolled in MIT (The Massachusetts Institute of Technology) in Boston, Massachusetts. He graduated at the top of his class at age 19 with double masters in physics and engineering. At the age of 21, his parents were tragically killed in a car accident. Afterwards, Tony inherited Stark Industries, an unparalleled mega-conglomerate that mostly manufactured weapons for the United States military. One of his first projects as the new CEO was to purchase the manufacturer who designed his parents' car and have the faulty brake system, which was seemingly the cause of their deaths, redesigned in order to prevent any further incidents, thus saving lives. Unknown to Stark, the true architect of his parents' deaths was a business move by Republic Oil (later renamed Roxxon Oil). Lacking in business skills, Tony promoted secretary Pepper Potts to be his executive assistant and left the majority of his workload on her so that he could avoid what he saw as a burden. During the war in Afghanistan, Stark was at one of his munitions plants testing new technology for the military when he was injured by his own land mine that lodged shrapnel near his heart. Tony was then captured by a local warlord named Wong-Chu (a lackey of the Mandarin) and forced under threat of death to create a doomsday weapon for him with another captive, the famed Nobel award-winning physicist, Yin Sen. The shrapnel was going to enter his heart and kill him, but he and the physicist created an arc reactor which kept the shrapnel away from his heart. In response, Tony built a suit of armor to help himself escape captivity. In the suit, Stark took on the warlord and his men and avenged Yin Sen's death, thus Iron Man was born."
        return hero
    }
    
    func spiderman() -> ParagonOverseer {
        let hero = ParagonOverseer()
        hero.Name = "Spiderman"
        hero.EntryTaunt = "Spider-senses are tingling!"
        hero.Strength = 14
        hero.Agility = 14
        hero.Intellect = 8
        hero.Willpower = 10
        hero.Handsize = 5
        hero.StartingHandsize = 5
        hero.Edge = 3
        hero.CharacterStatus = .none
        hero.EquipmentList = []
        hero.Powers = []
        hero.Skills = []
        hero.PossibleAttackTypeList = [.strength, .agility, .intellect, .none]
        hero.AttackTypeNames = ["Uppercut", "Sweep Kick", "Web-shooters", ""]
        hero.AttackValues = [14, 14, 16, 0]
        hero.DamageBonuses = [0, 0, 0, 0]
        hero.DodgeBonus = 4
        hero.DamageResistance = 0
        hero.WillpowerResistanceBonus = 0
        hero.Bio = "Peter Benjamin Parker was born to C.I.A. agents Richard and Mary Parker, who were killed when Peter was very young. After the death of his parents, Peter was raised by his Uncle Ben and Aunt May in a modest house in Forest Hills, New York. While still in High School, Peter attended a science exhibition about radiology where he was bitten by a radioactive spider, granting him the proportionate strength and agility of a spider as well as a \"Spider-Sense\" that warns him of nearby danger. In order to test his new abilities – and earn some cash, Peter participated in a wrestling challenge against Crusher Hogan. He easily won the challenge and also gained the attention of the media. Afterward while backstage, Peter saw a burglar run past him but did nothing to stop him as it wasn’t his problem. Later that night when Peter arrived home, he was told by a policeman that his Uncle Ben had been murdered by someone who broke into their house. The cop mentioned they had tracked the killer to a warehouse. In his anger, Peter put on his wrestling costume and went after the murderer himself. After arriving at the warehouse and easily defeating Uncle Ben’s killer, Peter saw that it was the same burglar he didn’t stop at the arena… thus learning that \"with great power comes great responsibility\"."
        return hero
    }
    
    func wolverine() -> ParagonOverseer {
        let hero = ParagonOverseer()
        hero.Name = "Wolverine"
        hero.EntryTaunt = "Let's go bub!"
        hero.Strength = 8
        hero.Agility = 10
        hero.Intellect = 6
        hero.Willpower = 10
        hero.Handsize = 5
        hero.StartingHandsize = 5
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
        hero.ParagonAbilityPower = .healingFactor
        hero.ParagonAbilityPowerMultiplier = 1
        hero.ParagonAbilityPowerText = "\(hero.Name) Heals with Healing Factor!"
        hero.Bio = "The man who would be known as the superhero named Wolverine was born as James Howlett in the mid 1880s in Alberta, Canada. He was the second and sickly child to Elizabeth and John Howlett Sr. His mother was ill and, in the early 1900s, a young Irish girl named Rose O'Hara was brought to the Howlett estate to be a friend and a caretaker to young James. Together they befriended a young boy named Dog, son of the grounds keeper, Thomas Logan. Dog tried to form a normal bond between the two, but due to his father’s resentment and drunken abuse, he grew to resent his station in life; so much so that one day he makes undue advances on Rose, which are reported by young James to his father. This whole chain of events leads to Thomas Logan being sacked from his position as groundskeeper, following which he goes seeking for Elizabeth Howlett, trying to convince her to leave with him. This leads to an altercation that results in the death of John Howlett. The shock of seeing his father murdered in front of him leads to the manifestation of young James’ powers and he stabs Thomas with his newly drawn claws, also slashing Dog across the face before fainting. He and Rose flee the house and make their way through the harsh Canadian wilderness with James near-catatonic and Rose having to facilitate their transportation, while Dog tells the police that Rose was the killer. They arrive at a mine where Rose gives false names, calling James incorrectly as “Logan.” The other workers dub the revived Logan “the wolverine” because of his penchant for tenaciously digging and begin to accept him as one of their own due to his incredible work ethic. What they don’t know is that by night, he runs in the wild with a pack of wolves that he is cowed the alpha of. Dog arrives one day, having survived his encounter years ago, still holding a massive grudge against Logan. Logan recognizes his erstwhile friend and accepts his challenge to a brawl to the death. Before Logan can kill Dog, however, Rose tries to pull him away and is inadvertently stabbed through the chest, killing her and leaving Logan to mourn alone."
        return hero
    }
    
    func hulk() -> ParagonOverseer {
        let hero = ParagonOverseer()
        hero.Name = "Hulk"
        hero.EntryTaunt = "HULK SMASH!"
        hero.Strength = 20
        hero.Agility = 3
        hero.Intellect = 1
        hero.Willpower = 8
        hero.Handsize = 5
        hero.StartingHandsize = 5
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
        hero.ParagonAbilityPower = .strengthIncrease
        hero.ParagonAbilityPowerMultiplier = 1
        hero.ParagonAbilityPowerText = "\(hero.Name)'s Strength Increases!"
        hero.Bio = "Robert Bruce Banner was born to atomic scientist Dr. Brian Banner and his wife, Rebecca. Although deeply loved by his mother, Bruce's father, who was mentally unstable, harbored deep jealousy and hatred for him. Brian was convinced that his work in atomic science had altered his genetic structure. Because of this, he also feared that Bruce would grow up a genetic freak, when actually, Bruce was just a very gifted and intelligent child. While growing up, Bruce was subjected to Brian's drunken rages and abuse, as was his mother. Tragically, Rebecca was killed by Brian when she attempted to take young Bruce and leave him. His mother's murder and his father's arrest left Bruce in the care of his aunt, Mrs. Drake. He grew up a social outcast due to the trauma of being abused by his father, as well as witnessing his mother's abuse and murder at the hands of his father. After graduating high school, Bruce began studying nuclear physics at Desert State University and later at the California Institute of Technology. He gained employment with the military at Desert Base, New Mexico, under the command of General \"Thunderbolt\" Ross. The latter was overseeing the test of Banner's newly-created Gamma Bomb. It was here that Banner met Ross's daughter, Betty, and the two found a mutual attraction. On the day of the bomb's scheduled detonation, Banner saw someone in the testing area. Hoping to rescue him, Banner went into the testing area where he encountered the individual he'd seen: a young teenager named Rick Jones, who had snuck onto the test site on a dare. Banner managed to push Jones to safety. However, rather than delay the countdown and halt the detonation as instructed, Banner's assistant, Igor Starsky (in reality, a foreign secret agent named Igor Drenkov), allowed the countdown and subsequent detonation to occur. This resulted in Banner being caught in the Gamma Bomb explosion and thus exposed to an incredibly massive amount of gamma radiation. Banner and Jones were later picked up by the base's military personnel and taken back to Desert Base, where they were placed in isolation and observation due to their exposure to gamma radiation. They were still in isolation at sundown when Banner transformed into a gray, monstrous, and lumbering brute for the first time. This brute was quickly dubbed \"the Hulk\" by military personnel."
        return hero
    }
    
    func captainAmerica() -> ParagonOverseer {
        let hero = ParagonOverseer()
        hero.Name = "Captain America"
        hero.EntryTaunt = "Freedom will prevail!"
        hero.Strength = 10
        hero.Agility = 10
        hero.Intellect = 6
        hero.Willpower = 12
        hero.Handsize = 6
        hero.StartingHandsize = 6
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
        hero.Bio = "After the outbreak of World War II in Europe, a young HYDRA agent disguised as an American patriot named Steve Rogers attempted to enlist in the U.S. Army but was rejected, due to his skinny, anemic physique, and was classified 4-F. However, he garnered the attention of certain people including scientist Doctor Abraham Erskine who was searching for suitable volunteers/test subjects for a top secret experimental program designed to create an army of Super-Soldiers. As a result of Operation: Rebirth, Steve Rogers gained speed, strength, flexibility, endurance and agility of nearly superhuman levels. These heightened abilities coupled with his unwavering courage and “never say die” attitude eventually made him Captain America, a living legend."
        return hero
    }
    
    func daredevil() -> ParagonOverseer {
        let hero = ParagonOverseer()
        hero.Name = "Daredevil"
        hero.EntryTaunt = "I know no fear!"
        hero.Strength = 8
        hero.Agility = 10
        hero.Intellect = 8
        hero.Willpower = 8
        hero.Handsize = 5
        hero.StartingHandsize = 5
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
        hero.Bio = "Matt Murdock was raised in the Hell's Kitchen neighborhood of New York City, by his father, boxer \"Battlin\" Jack Murdock. From a young age, Matt was pushed to work hard in school so he wouldn't have to fight like his father. His father worked hard to provide for him so he would have a better life. As boxing work became scarce, Jack went to work for a local mobster, the Fixer, moonlighting as an enforcer in addition to taking fights. While his father was away, Matt secretly started training himself on his father's equipment. While walking down a street one day, Matt noticed a blind man was about to get hit by a truck. He ran in front of the truck, and pushed the blind man out of the way. However, the truck was carrying radioactive waste, and some spilled out directly onto Matt's eyes causing him to go blind. With his vision gone, Matt's remaining senses of hearing, touch, taste, and smell became heightened, and he was able to \"see\" using a form of \"radar sense\", that showed outlines and shapes. The radiation also may have had an impact on his mind as well, allowing him to retain information quite easily. Matt continued with both his studies and his secret training regime. His hard work paid off when he got into Columbia to study law. It was there that he met his roommate and future business partner Franklin \"Foggy\" Nelson. During this time, Jack Murdock was enjoying some success in the boxing ring, so Matt got tickets for himself and Franklin to go see a bout. However before the fight, Jack found out that all his matches were fixed and he was going to get killed if he didn't fix the match. Jack didn't want to lose his match in front of his son in the audience, so he went against his orders to fix the match and won. The Fixer did not take this well, and so he took matters into his own hands. Jack Murdock came out after the match and was on his way home. But, he was murdered minutes later that night. Shortly after, Matt and Nelson graduated from Columbia and started their own law firm Nelson & Murdock right away. After graduation, Matt also devised a plan to avenge his father's death. He made the Daredevil costume, and brought the Fixer and his second-in-command Slade to justice. Thus \"the Man Without Fear\" was born."
        return hero
    }
    
    func doctorStrange() -> ParagonOverseer {
        let hero = ParagonOverseer()
        hero.Name = "Doctor Strange"
        hero.EntryTaunt = "I shall defend our world!"
        hero.Strength = 3
        hero.Agility = 4
        hero.Intellect = 8
        hero.Willpower = 16
        hero.Handsize = 5
        hero.StartingHandsize = 5
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
        hero.Bio = "At a young age, Stephen Strange had dreams of becoming a doctor. The eldest child of three, Strange was born in 1930 while his parents Eugene and Beverly Strange were on vacation in Philadelphia. At the age of eleven he aided his younger sister Donna when she was injured, which proved to be a formative experience for him, and he was inspired to attend med school after high school. Ironically, it was his inability to later save her from drowning when he was nineteen and on leave from college that undermined his belief in life’s meaning and the value of idealism. Nevertheless, he rapidly finished med school at a young age and became a successful neurosurgeon. Strange displayed phenomenal talent in his chosen field, and quickly attained wealth and notoriety. The more successful he became, the more arrogant he grew. Eventually this led to estrangement from his family and the undoing of his relationship with a United Nations translator named Madeline Revell to whom he had proposed marriage. So distant and self-absorbed did he become that he refused to visit his father on his deathbed. His enraged younger brother Victor Strange berated him for this, and then was killed as he ran into traffic. Stephen then placed the body of his brother into cryogenic storage. At a much later stage Stephen attempted to restore his brother through magical means, but instead imbued him with the curse of vampirism. A car accident that damaged the nerves in his hands changed everything for Stephen Strange. He was no longer able to be a surgeon, yet he refused to become an assistant or consultant, instead squandering his money traveling the world and searching for a cure. One day he heard a rumor of a mystical personage known as the Ancient One in Tibet. Marshaling the last of his inner and outer resources, Strange diligently searched until the fortress of the Ancient One was revealed to him. Though initially outraged that the aged mystic refused to cure his hands, Strange’s anger was quickly replaced by amazement when the reality of magical forces was demonstrated before his eyes as he witnessed an attack on the Ancient One. Circumstances revealed to Strange that it was none other than Baron Mordo, the Ancient One’s chief disciple, who was the perpetrator of the attack, and who continued to plot the destruction of the antediluvian mystic in an attempt to gain power. To his horror, Strange learned he was unable to reveal this after Mordo easily encircled him. Realizing the Ancient One was a force for good; Stephen selflessly abandoned his quest to restore his hands and committed himself to magical tutelage with the intention of foiling Mordo’s insidious scheme. By this act Strange proved himself to the Ancient One, to whom the entire melodrama had been transparent. Thus Doctor Strange put himself on the path to become the new Sorcerer Supreme of the Earth dimension, yet gained a deadly enemy in Baron Mordo."
        return hero
    }
    
    func humanTorch() -> ParagonOverseer {
        let hero = ParagonOverseer()
        hero.Name = "Human Torch"
        hero.EntryTaunt = "Flame on!"
        hero.Strength = 4
        hero.Agility = 8
        hero.Intellect = 5
        hero.Willpower = 6
        hero.Handsize = 4
        hero.StartingHandsize = 4
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
        hero.Bio = "Johnny Storm is the son of physician Franklin Storm and his wife Mary. He and his older sister Susan grew up in Glenville, New York. While still young, his mother was in a terrible car accident and she passed away, despite Franklin’s attempts to repair her body. After this tragic event, Franklin fell into a downward spiral of drinking and gambling, eventually leading to his arrest for the murder of a loan shark, which he claimed was self-defense. Johnny and Sue were then sent to their Aunt’s to live and Sue spend much time caring for her younger brother. As a teen, Johnny and his sister met a scientist named Reed Richards and volunteered to go on an experimental rocket designed by Reed. The rocket would help humanity fly to the stars if everything worked as planned. But the ship was not properly shielded from cosmic radiation and plummeted back to the Earth’s surface. They all survived the horrific crash but very soon found they had been changed. Sue, Reed and the pilot, Ben Grimm, gained super powers as a result. Johnny burst into flame and soon realized he could fly. On the spot they all agreed to use their powers for good and become the Fantastic Four. Still young and rebellious, Johnny was ecstatic to have his new found powers. Labeled the hot head of the group, Johnny would often make brash decisions and disobey direct orders. Although his sister would try to calm him, Johnny often had issues with following Reed’s orders. He would quit the team early on (and many more times) because of his temper. While at a local bar trying to avoid the other members of the team, Johnny recognized a man who claimed to be an amnesiac. Trying to see if he was right, he dropped the man in the ocean and his assumptions were correct – it was Namor, the King of the Sea. Learning Atlantis was destroyed; Namor waged war against the surface. Johnny helped the other team members stop him and rejoined the team, finally having cooled off a bit."
        return hero
    }
    
    func invisibleWoman() -> ParagonOverseer {
        let hero = ParagonOverseer()
        hero.Name = "Invisible Woman"
        hero.EntryTaunt = "What you can't see will hurt you!"
        hero.Strength = 4
        hero.Agility = 6
        hero.Intellect = 6
        hero.Willpower = 10
        hero.Handsize = 5
        hero.StartingHandsize = 5
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
        hero.Bio = "Sue Storm and her younger brother Johnny had a pretty normal and happy childhood until their mother died in a car accident. Their father, Dr. Franklin Storm who was a famous and talented surgeon, could not save her life. Unfortunately, Franklin was unable to cope with the loss. As a result he became an alcoholic and a gambler. He got into a scuffle with a loan shark and accidentally killed him, and was later charged with murder, sending him to jail. Sue visited him in jail but her father asked her not to visit anymore and to tell Johnny that he was dead. He felt ashamed of his actions and believed he was not worthy of his children. At this point Sue was forced to become both mother and sister to Johnny. Caring for her brother throughout most their childhood caused Sue to mature far earlier than most children her age. Eventually, the Storm siblings moved in with their aunt who owned a boarding house, and it was there she met the man who would shape her life. Sue met and fell for Reed Richards, a tenant of her aunt's boarding house. Richards was a genius and a brilliant scientist. He was attending Columbia University at the time. Many years passed before Sue and Reed finally crossed paths again. In an attempt to become an actress, young Susan went to California to pursue acting and met up with Reed once again. Reed was taken by the woman Susan had become and shortly afterward they began dating. Around this time, Reed was trying to accomplish his lifelong dream of building a spaceship, which he funded with his own money along with government grants. The government threatened to cut off funding as it was tiring of what they considered to be Reed's overly fastidious preparations. Desperate to try out the ship, Reed took his best friend and test pilot Ben Grimm, Sue, and Johnny on an unauthorized trip into outer space. They had all helped in the design, but the ship did not have adequate shielding and they were bombarded by cosmic rays. The ship was forced back into Earth's atmosphere and crashed-landed. The four discovered that the cosmic rays had mutated them and given them superhuman abilities. They decided to use their powers to fight evil and became the Fantastic Four. Their first adventure was against the Mole Man and his monster allies."
        return hero
    }
    
    func misterFantastic() -> ParagonOverseer {
        let hero = ParagonOverseer()
        hero.Name = "Mister Fantastic"
        hero.EntryTaunt = "I've calculated your demise!"
        hero.Strength = 3
        hero.Agility = 4
        hero.Intellect = 12
        hero.Willpower = 8
        hero.Handsize = 5
        hero.StartingHandsize = 5
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
        hero.Bio = "Reed Richards was born in Central City, California and the son of Nathaniel and Evelyn Richards. Reed’s father was a brilliant scientific genius and a trait that Reed inherited. Reed excelled in mathematics, physics, and mechanics and was enrolled in college by the age of 14. He went to multiple colleges including Massachusetts Institute of Technology, California Institute of Technology, Harvard University, Columbia University, and Empire State University. While attending EMU he met and became a roommate of Ben Grimm. They became great friends and Reed shared his dream of building a spaceship himself. After EMU, Reed continued to go to school at Columbia University, and he rented an apartment from Sue Storm's Aunt. Sue quickly fell in love with Reed. Reed, also met Victor Von Doom, while attending Columbia University. Doom loved that Reed could rival his intellect. Eventually Doom became jealous of Reed and began conducting reckless experiments that scarred his face. Reed next enrolled at Harvard and earned his P.H.D. in physics and a mastery in mechanical, aerospace and electrical engineering, chemistry and all levels of human and alien biology by the age of 22. After he was done with school he used his inheritance and government funding to finance his project. He began building his spaceship in Central City. Sue Storm would move to this same area and eventually found herself dating Reed again. Reed would ask Ben to pilot the ship for him. The government denied the flight into space so Reed, Sue, Ben, and Johnny decided to sneak onto the ship and they took the ship into outer space. Reed miscalculated and forgot the abnormality of the radiation from the cosmic radiation. The rays destroyed the ship and they crash-landed back on earth. After the crash Reed found out that he could stretch his body like elastic at will. Reed adopts the name Mr. Fantastic and convinces the four of them to use their powers for good."
        return hero
    }
    
    func nightcrawler() -> ParagonOverseer {
        let hero = ParagonOverseer()
        hero.Name = "Nightcrawler"
        hero.EntryTaunt = "Have faith that this will be swift!"
        hero.Strength = 6
        hero.Agility = 12
        hero.Intellect = 5
        hero.Willpower = 7
        hero.Handsize = 4
        hero.StartingHandsize = 4
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
        hero.Bio = "Kurt Wagner is the product of a love affair between two mutants, both with origins that have never fully been explained. His mother was the terrorist Mystique, who at the time was the wife of Baron Christian Wagner, believed to be the father of Nightcrawler for a long time. In truth, his father is the Neyaphem warlord, Azazel, who had a great master plan to impregnate earth women with his children so he could escape the brimstone dimension. When Nightcrawler was born, the townsfolk were horrified by Mystique' son's demonic appearance and so she threw him into a river, shape-shifted into another form and then claimed that she had killed the son and the mother. Azazel would not allow his son to die, so he saved him and gave him to one of his other lovers (and servant) Margali Szardos to raise. Margali tells a different tale to hide the truth and says that Nightcrawler was discovered by her when she was walking by his house. She discovered his father, Eric Wagner, had died of a heart attack outside and found his mother lying next to him dead. Margali took him in and raised him along with her real children Stefan and Jimaine (later known as Amanda Sefton) at the Bavarian circus. She worked as a fortune teller to hide the truth about her sorcery. Kurt had amazing agility and soon his mutant abilities would manifest. Because of these gifts, he did acrobat shows for the circus audience, while people assumed it was a man in a costume.When a millionaire circus owner from Texas approached them join his circus, he planned to move the circus to America and demanded that Kurt be in the freak show. Kurt was appalled at this, so he quit the circus and headed to Winzeldorf, Germany. He arrives there to find that his brother Stefan went insane and had been murdering children. Kurt battles him, hoping to stop the atrocity, but accidentally kills Stefan by breaking his neck. He tried to tell Margali about her son but she was not at the circus at the time. The coincidence is that, as children, Stefan had made Kurt swear to kill him if ever he took an innocent life. In turn, the villagers thought Kurt was the demon that killed the children."
        return hero
    }
    
    func silverSurfer() -> ParagonOverseer {
        let hero = ParagonOverseer()
        hero.Name = "Silver Surfer"
        hero.EntryTaunt = "The power cosmic will finish this!"
        hero.Strength = 20
        hero.Agility = 20
        hero.Intellect = 7
        hero.Willpower = 10
        hero.Handsize = 5
        hero.StartingHandsize = 5
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
        hero.Bio = "Norrin Radd lived on the peaceful planet Zenn-La (Deneb System, Milky Way Galaxy). The Zenn-Lavians effectively eliminated the plagues commonly associated with human life on Earth, such as hunger, disease, crime, and war. The result of their quest for advancement and scientific discovery, in effect, created a Utopian society. Norrin's parents were Jartran and Elmar Radd. Jartran was a scientist, and Norrin followed in his footsteps, constantly studying. Unable to cope with what Zenn-La had become (a society that had devolved into hedonism and, in essence, become directionless), Norrin's mother Elmar committed suicide when he was very young. Norrin always blamed himself for this. After his mother's passing, Norrin was nurtured by his father to become a great man. When Norrin entered manhood, his father was implicated in the theft of ideas belonging to another scientist. When Norrin confronted his father, he admitted negligence. Disgusted by his father's actions, Norrin completely withdrew from him. Depressed by his indiscretion made public and the apparent lack of support from his son, Jartran committed suicide. Much like his mother and father, Norrin also dreamed of a society that had more substance. He believed that no goals were left to be achieved on Zenn-La. He was filled with discontent and often went to the museum to watch holograms of Zenn-La's past that revolved around their wars and space travel. This often troubled his girlfriend, Shalla-Bal. She believed they had all they could ever want together, but Norrin always dreamed of more. One day, their peaceful existence was threatened by the presence of Galactus, the Devourer of Worlds, who subsists on the energies provided by entire planets. The Council of Scientists let Norrin use a spaceship to approach Galactus and plead on behalf of the planet. Seeing the hopeless situation of his home planet, Norrin Radd volunteered servitude to the Devourer of Worlds in order to spare Zenn-La from obliteration. Galactus accepted. Given a fraction of the Power Cosmic, and shaped by fantasies Norrin Radd entertained as a child, Galactus transformed Norrin Radd into the Silver Surfer. The Silver Surfer's main task was to find planets with the energy to satisfy Galactus's hunger. Over time it became more difficult to find planets without life on them. Knowing Norrin Radd would resist taking a life, Galactus deliberately altered Norrin's mind to repress his moral compass, allowing Norrin Radd to more efficiently carry out the grim task of finding suitable planets to feed upon. A decidedly introspective character plagued by the sins of his past, Norrin Radd forever seeks redemption, endeavoring to carry out justice throughout the universe."
        return hero
    }
    
    func thor() -> ParagonOverseer {
        let hero = ParagonOverseer()
        hero.Name = "Thor"
        hero.EntryTaunt = "Behold the god of thunder!"
        hero.Strength = 19
        hero.Agility = 5
        hero.Intellect = 5
        hero.Willpower = 8
        hero.Handsize = 5
        hero.StartingHandsize = 5
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
        hero.Bio = "Thor is the son of Odin, All-father of the Asgardian Gods, and the elder goddess Gaea, the living embodiment of Earth itself. Thor was born centuries ago in a cave in Norway. Once Thor was weened, Odin brought him to Asgard where he was raised to be the God of Thunder and heir to the throne. As the Asgardian God of Thunder, Thor commands the thunder, the lightning the wind and all the elements of the storm with his hammer Mjolnir, which was forged from the legendary, indestructible Asgardian metal; Uru. Mjolnir gives Thor the power of flight and helps him channel, focus or amplify his own godly elemental powers. Though the hammer is quite heavy by mortal standards, It can only be lifted by those deemed worthy to do so, regardless of the would-be wielder’s physical strength. After centuries of defending Asgard from its enemies, Thor became too proud and grew headstrong. It was because of this that he was banished to Midgard (Earth) by his father to teach him some needed humility. Made mortal and given the form of the handicapped human doctor Donald Blake, Thor learned what it was like to be small and frail and how to be humble and truly noble despite being mortal. When in his mortal guise of Dr. Blake he is able to transform into his true godly form by striking his walking stick (actually Mjolnir in disguise) upon any solid surface causing the transformation that changes him into Thor and his walking stick into his hammer Mjolnir. (In the past, this has now been taken away)"
        return hero
    }
    
    func blackPanther() -> ParagonOverseer {
        let hero = ParagonOverseer()
        hero.Name = "Black Panther"
        hero.EntryTaunt = "Wakanda forever!"
        hero.Strength = 9
        hero.Agility = 10
        hero.Intellect = 7
        hero.Willpower = 8
        hero.Handsize = 5
        hero.StartingHandsize = 5
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
        hero.Bio = "Long ago, a huge meteorite made of a rare mineral now known as vibranium, crashed landed in Wakanda. The first king of Wakanda, Black Panther Bashenga, harnessed the mineral and used it to nurture his nation. Thousands of years later, under the ruling of Black Panther T‘Chaka, Wakanda's level of technological and economic achievements continued to excel far beyond those of the modern world. T'Chaka concealed Wakanda from the rest of world to prevent it from being manipulated by outsiders. His first wife, N'Yami, died while in labor with Prince T’Challa. Years later, a Dutch scientist named Ulysses Klaw found a way into Wakanda, created a vibranium sound-based weapon, and used it to kill King T’Chaka. Prince T’Challa, only a child at the time, managed to turn the sound weapon on Klaw, destroying his right hand. Klaw fled the country, exposed Wakanda to the outside world, and vowed revenge. Prince T'Challa would later become king after defeating his uncle, King S'yan, in a once-a-year ritual that allowed anyone of Wakandan royalty to become king/queen by defeating the current ruler in hand-to-hand combat. Given the fact that the ruling Black Panther possessed enhanced and superhuman abilities from digesting the Wakandan Heart-shaped Herb, the chance of an average man defeating a Black Panther was slim. However, T’Challa succeeded. He also digested the Heart-shaped Herb, which gave him superhuman senses and provided him with enhanced agility, strength, and over all physical capability."
        return hero
    }
}

class EnemyGenerator {
    
    var numberOfVillains: Int = 12
    var numberOfHenchmen: Int = 3
    
    func drDoom() -> ParagonOverseer {
        let enemy = ParagonOverseer()
        
        enemy.Name = "Dr. Doom"
        enemy.EntryTaunt = "Now is doom!"
        enemy.Handsize = 6
        enemy.StartingHandsize = 6
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
        enemy.Bio = "Victor was the child of Gypsy travelers in Latveria, a small European country. Victor's mother, Cynthia, was killed soon after she called upon the demon Mephisto for power. She left Victor with his father, asking him to protect him from Mephisto. Victor's father, Werner, was a doctor who was called upon by King Vladimir of Latveria to treat his wife. Unable to do so, Werner fled with Victor and died soon afterward, trying to protect his son. Victor was left with his father's best friend, Boris. Victor later discovered his mother's mystical books and artifacts. With them, he was able to teach himself sorcery. He made several unsuccessful attempts to free his mother's soul from Mephisto. Victor excelled in science, developed several inventions, and was eventually given a scholarship to Empire State University. While attending this school, Victor met Reed Richards, who would later become his enemy, Mr. Fantastic. In school, they were considered scholarly rivals. One day, Victor designed an invention to rescue his mother, which would become his greatest downfall. Richards attempted to warn Victor of an error in his calculations. However, Von Doom's arrogance refused to let him listen. The machine then exploded, scarring his face, and led to his expulsion from the university. Von Doom later went to Tibet and found an old order of monks. He practiced their ways enough for him to become their leader. Von Doom then asked them to make his first suit of armor. Eager to wear the suit, Doom placed the still-hot steel faceplate to his face, making him even more scarred than before. As Dr. Doom, he killed Baron Vladimir, imprisoned his son Rudolfo, and gained control over Latveria. Rudolfo would escape, lead a rebellion, and become a thorn in Doom's side for years until his death. Later, Rudolfo's younger brother Zorba would take over where his brother left off. Doom, using his intellect and inventions, turned Latveria into a thriving nation."
        return enemy
    }
    
    func annihilus() -> ParagonOverseer {
        let enemy = ParagonOverseer()
        
        enemy.Name = "Annihilus"
        enemy.EntryTaunt = "Annihilation!"
        enemy.Handsize = 5
        enemy.StartingHandsize = 5
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
        enemy.Bio = "Long ago in the Negative Zone, when the Tyannans seeded life spores on barren planets, one of their ships was hit by a meteor and sent onto the volcanic planet of Arthros. Before dying, the crew released spores. Many years later, one of the spores evolved into an insectoid creature. Due to a mutation, he had notably high intelligence. Finding the wreckage of a Tyannan starship, he used a special helmet to transfer all information about the advanced Tyannan technology into himself. This caused him to grow stronger and smarter, gaining a \"Cosmic Control Rod\" and body armaments. The creature became known as Annihilus. He set out to destroy anything that was a threat to his existence, planning to conquer/destroy all planets near Arthros. Other creatures came from the spores as well, but Annihilus used his power to rule above them."
        return enemy
    }
    
    func galactus() -> ParagonOverseer {
        let enemy = ParagonOverseer()
        
        enemy.Name = "Galactus"
        enemy.EntryTaunt = "I am the Devourer of Worlds!"
        enemy.Handsize = 7
        enemy.StartingHandsize = 7
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
        enemy.Bio = "Galactus is the only survivor of the universe that existed before the Big Bang. He was born billions of years ago on the planet Taa. Taa was a paradise world, the most technologically advanced in all the universe. Galan (Galactus) was born during the last years of his universe, just as the Big Bang, which created the current universe, was approaching. As a scientist, Galan was able to inform his people of the impending doom to not only Taa but the universe itself. The very atoms of the universe were changing, and they watched as civilizations died. Soon, residents of Taa began dying of radiation poisoning, and even their advanced skills could not stop it. He persuaded some crewmen to fly along with himself in a space vessel into the terminal point of the universe as a last act of heroism for his people. Everyone on the ship died but himself, and a cosmic being calling itself the Sentience of the Universe appeared, telling Galan they both must die. The being combined with Galan and became part of the new universe as a cosmic egg. Galactus was created, along with his starship and the embodiments of Death and Eternity. He stayed within his starship, dormant, for billions of years. A Watcher found the ship and thought it to be interesting. He then brought it down out of a planet's orbit, thus breaking his oath of non-interference. He awoke the incredibly powerful entity on-board. Having one chance to destroy it but not wishing to interfere further, the Watcher allowed the entity to live. Upon awakening, Galactus learned to control his power, creating a unique bodysuit to help regulate his formidable energies. His ship became an incubation chamber, and Galactus stayed there for several hundred years longer. The ship eventually fell into orbit over Archeopia, and the residents dared not tamper with it. During a space war, his ship was fired upon, and Galactus was awakened again, his incubation complete. This was the first time Galactus fed upon the energy of a planet. The survivors of this planet who escaped became known as the Wanderers. Galactus gazed upon the ruin he had caused, knowing he had the power of creation as well as annihilation. He began to reconstruct the world, taking millennia to finish it. When completed, it was enormous, so enormous that planets orbited it as though it were a sun. The world-ship became Galactus's home, and he named it Taa II. At this time, Galactus could go centuries before needing to feed again. He started by feeding only upon the energies of uninhabited worlds. Soon, his hunger grew more quickly, and the time between feedings became shorter. At first, Galactus felt much guilt for his destruction. Eventually, though, he stopped worrying about feeding only upon uninhabited worlds as he felt he was above other beings. When he came across Death and Eternity, it was believed that Galactus served as the balance between the two forces."
        return enemy
    }
    
    func juggernaut() -> ParagonOverseer {
        let enemy = ParagonOverseer()
        
        enemy.Name = "Juggernaut"
        enemy.EntryTaunt = "I'm Juggernaut!"
        enemy.Handsize = 4
        enemy.StartingHandsize = 4
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
        enemy.Bio = "Cain Marko's mother died when he was young and he was raised by his father Kurt. With the (questionable) death of his father's colleague, Dr. Brian Xavier, Cain's father married Xavier's widow, Sharon. They moved into the Xavier Mansion (the later Xavier Institute for Higher Learning) in Westchester, New York. Cain was a bully to his stepbrother Charles, partly due to the fact that his father favored him over Cain. Unknown to Cain, Charles was succeeding because of his mutant ability to read minds, including Cain's. When he found out, Cain would never forgive Charles for this. During an argument with his father, Cain accidentally started a fire in his father's lab, the fire soon grew out of control and Kurt once again showed his preference for Charles when he saved him first. After going back for Cain, he died of smoke inhalation. Later, both Cain and Charles were drafted into the US army and were in the same unit during the Korean War. During one mission, they were in a fire fight and Cain deserted the unit, Charles went after him in the hopes of bringing him back before he got into trouble. Cain stumbled into a cave that had the lost Temple of Cyttorak inside. He discovered the Crimson Gem of Cyttorak on a plinth and when he touched it, magically appeared an inscription in English that read:\"Whosoever touches this gem shall be granted the power of the Crimson Bands of Cyttorak! Henceforth, you who read these words, shall become ... forevermore ... a human juggernaut!\" Cain was mystically transformed into Cyttorak's avatar, a living Juggernaut, but the unleashed mystical energies caused a cave -in; Charles managed to escape just in time. Charles and the world believed Cain to be dead, however, Cain was buried under the rubble of the immense mountain that covered the whole temple. The Juggernaut was not stopped by this and thanks to his ability to not eat or breathe, and his recently acquired unlimited superhuman strength and durability, he dug himself out of a trillion tons of rocks that fell on him. It took Juggernaut XX years (sliding timescale) to get out to the surface with nothing but thoughts of revenge against his step-brother on his mind. This event, undoubtedly, represents one of first daunting feats of Juggernaut's strength."
        return enemy
    }
    
    func loki() -> ParagonOverseer {
        let enemy = ParagonOverseer()
        
        enemy.Name = "Loki"
        enemy.EntryTaunt = "Beware the god of mischief!"
        enemy.Handsize = 5
        enemy.StartingHandsize = 5
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
        enemy.DamageBonuses = [0, 0, 0, 0]
        enemy.DodgeBonus = 0
        enemy.DamageResistance = 0
        enemy.WillpowerResistanceBonus = 0
        enemy.Bio = "Loki is the birth son of the Frost Giant Laufey, the former King of the Jotunnheim. Odin declared war and killed Laufey. When Odin saw Loki as a baby, he adopted him - This began a prophecy foretold by Odin's father, Bor. Loki was not like his brother Thor, He proved to be a mischievous child, and was often also jealous of the affection Odin showed his older brother Thor. He began studying Asgardian magic and science, both of which he would become very proficient in, eventually becoming one of the strongest sorcerers in Asgard. Loki is well known for cutting off the long, golden hair of Thor's love, Sif. He was forced by Thor to restore it. Loki then enlisted two dwarves to do so, but when he refused to pay them, they made new, black hair, out of nothing. In his youth, Loki tried again and again to gain advantage over his older brother Thor. Odin sent Thor, Balder, and Sif out in search of materials for a sword. Loki followed them secretly, but found that an evil goddess was about to attack, and was forced to alert them instead of stopping them. Meanwhile, Odin loved Thor so much that he was preparing his greatest gift to the young Thor. When Thor turned eight, Odin had a magical hammer created, an amazingly powerful one - Mjolnir. Loki was jealous, and he showed his first signs of evil. He interfered with Mjolnir while it was still being made-he caused the handle to be made too short. As a boy, he wanted Mjolnir's power which would someday be Thor's and often tried to steal it. This all had an effect on Loki. He grew angrier with each passing day, he was truly becoming evil. His hate for Thor and desire to rule Asgard manifested along with his sorcery and mischief. He became jaded and evil. He finally made a vow-to be the most powerful god in Asgard, and to kill his brother Thor."
        return enemy
    }
    
    func magneto() -> ParagonOverseer {
        let enemy = ParagonOverseer()
        
        enemy.Name = "Magneto"
        enemy.EntryTaunt = "I reign supreme!"
        enemy.Handsize = 6
        enemy.StartingHandsize = 6
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
        enemy.Bio = "The man that would become known as \"Magneto\" was born Max Eisenhardt in Germany during the 1920's to a middle class Jewish family. His father, Jakob Eisenhardt, was a World War I veteran and a proud German. The family struggled against discrimination and hardship during the Nazi's rise to power, the Nuremberg laws, and Kristallnacht. In the early 1930's, the family fled to Poland, where they were captured during the Nazi invasion and sent to the Warsaw Ghetto. They managed to escape the ghetto, but were captured again. Max's mother, father, and sister were executed, but Max survived (potentially thanks to an early manifestation of his powers) and was sent to the Auschwitz concentration camp. There, Max became a Sonderkommando, forced to dispose of gas chamber victims. While at the camp, Max was reunited with a girl he had fallen in love with during his school days named Magda. Max and and Magda escaped when Auschwitz was liberated and were soon married. They moved to the Ukrainian city of Vinnytsia, where they started their new lives together. Max adopted the name \"Magnus\" and Magda gave birth to their daughter who they named Anya. Magnus worked as a carpenter to support the family and for a time they lived happily. One night Magnus was attacked and instinctively lashed out with his mutant powers of magnetism (which had never surfaced before due to a bout of scarlet fever as a child), killing the attackers. Later that evening, he returned home to find his house on fire, with Anya trapped inside. Magnus rushed inside to rescue her but he was too late. Enraged at the death of his beloved daughter, he used his new powers to kill the surrounding mob that started the fire. Magda, terrified of her husband's strange abilities, fled to the forest and never saw her husband again. Magda made her way to Wundagore Mountain, where she gave birth to twins Pietro and Wanda (who would grew up to be Quicksilver and Scarlet Witch, respectively). Magda later disappeared, presumed deceased. During the next few years Magnus had an identity forger named Greg Odekirk create him a new identity, reinventing himself as a gypsy named \"Erik Magnus Lehnsherr\". It was while using this identity that he went to Israel to help at a psychiatric hospital. There, he met Professor Charles Xavier. The two became fast friends, playing chess and having intellectual debates about mutation and the future of mankind. When Baron Wolfgang Von Strucker attacked a young patient named Gabrielle Haller, Xavier and Magnus used their powers in order to save her. Following the battle, Charles and Magnus realized they had very differing ideologies. Magnus disappeared and the two friends would not meet again for many years. During the next few years, Magnus worked for the CIA hunting Nazis, but this association ended when they murdered a girl he was becoming close to. Magnus would not be seen again until he became the mutant known as Magneto."
        return enemy
    }
    
    func rhino() -> ParagonOverseer {
        let enemy = ParagonOverseer()
        
        enemy.Name = "Rhino"
        enemy.EntryTaunt = "I'll stomp you into the dirt!"
        enemy.Handsize = 3
        enemy.StartingHandsize = 3
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
        enemy.Bio = "The Rhino was born as Aleksei Sytsevich, a poor immigrant from Russia who was desperate to pay for the rest of his family and came to the United States in hope of finding work to provide for them. With little education and no real skills, the only paying jobs he could get were using his impressive strength and musculature as an enforcer for various criminal organizations. One day he was contacted by some Eastern Bloc agents, who offered him a vast sum of money for participating in an incredible experiment. Sytsevich agreed, and was subjected to intensive chemical and radioactive treatment, which bonded a super-strong polymer to his skin and greatly augmented his strength and speed. He was given the code name \"Rhino,\" and was sent to work as a super-assassin."
        return enemy
    }
    
    func sabertooth() -> ParagonOverseer {
        let enemy = ParagonOverseer()
        
        enemy.Name = "Sabertooth"
        enemy.EntryTaunt = "I'll tear you to shreds!"
        enemy.Handsize = 4
        enemy.StartingHandsize = 4
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
        enemy.Bio = "Sabretooth's memories have been tampered with by clandestine organizations such as Weapon X, and so much of what appears to be his past is not of credible account. His strongest and earliest memories involve being cruelly abused on numerous occasions by his father while being tied up in his parents' basement. Another memory of Victor's childhood was when his mutation first manifested, he killed his pediatrician at age 9 (Uncanny X-Men 1st series #326). Another memory involves Wolverine, whom at the time lived in a small community of Blackfoot Indians and settlers. One day, Sabretooth tracked him down in Canada, and he raped and seemingly murdered his lover, Silver Fox on Logan's birthday. This resulted in the first of many battles between the two, with Sabretooth savagely beating Logan. Creed eventually adopted a tradition of tracking Logan down on his birthday with the intention of fighting him. Eventually emerging as a costumed villain, Sabretooth became partners with the Constrictor and the two acted as enforcers for major criminal interests. During this time, Creed began to stalk and kill human beings for pleasure. This earned him the newspaper title of \"The Slasher.\" The Constrictor and Sabretooth eventually dissolved their partnership, and Sabretooth nearly killed the Constrictor at one time."
        return enemy
    }
    
    func superSkrull() -> ParagonOverseer {
        let enemy = ParagonOverseer()
        
        enemy.Name = "Super-Skrull"
        enemy.EntryTaunt = "My powers will destroy you!"
        enemy.Handsize = 5
        enemy.StartingHandsize = 5
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
        enemy.Bio = "The Skrull who became known as the Super-Skrull was born with the name Kl’rt on Tarnax IV. Kl’rt volunteered to be artificially augmented at the command of Emperor Dorrek who had vowed revenge after an invasion of Earth was foiled by the Fantastic Four. Kl’rt was given the combined abilities of the Fantastic Four, yet his powers exceeded the originals, he burned hotter and flew faster than Johnny Storm, he could stretch further than the Reed Richards, he exercised greater control over his invisibility and force fields than Susan Richards, and was stronger than Ben Grimm. Kl’rt retained his Skrullian shape-shifting abilities and his naturally strong hypnotic skills. He was dubbed the Super-Skrull by the Emperor himself, and was to be the point man in a second invasion of Earth. All he had to do was defeat the Fantastic Four."
        return enemy
    }
    
    func thanos() -> ParagonOverseer {
        let enemy = ParagonOverseer()
        
        enemy.Name = "Thanos"
        enemy.EntryTaunt = "I am inevitable!"
        enemy.Handsize = 5
        enemy.StartingHandsize = 5
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
        enemy.Bio = "Born to the Eternals Mentor and Sui-San, Thanos was subject to the Deviant gene at birth. As a result, Thanos became that of a 'mutant' of Titan (the sixth orbiting moon of Saturn). He developed a purple, hide-like skin, along with strength and other physical abilities far surpassing that of other Titans. This mutation also augmented the powers he inherently possessed as a descendant of the Eternals. Growing to become the most powerful Titan, his skin developed in such a fashion that allowed Thanos to absorb cosmic energy on an atomic level and then manipulate it as kinetic force via conscious choice. Though never shunned by his family in his youth, Thanos was feared and avoided by his fellow Titan peers due to his unique qualities. His brother, Eros, was groomed from childhood to eventually replace their father in the role of leader among their people. Eros would, throughout their youth, be fawned over by loving friends and family, whom much favored him over Thanos. Feeling the sting of such ostracism, Thanos would find solace and purpose in other pursuits. On one fateful day, in an all but forgotten subterranean temple, an enterprising young Thanos would find companionship in the form of Mistress Death. Decades would pass, and Thanos's relationship with Mistress Death grew, eventually blossoming into a dark and forbidden romance. Under Death's tutelage, he became even stronger and more powerful - well versed in the Black Arts, which had long been banned on Titan. She taught Thanos that knowledge is power, and that power is everything. With the revelations of Thanos's rebellious activities, his maturation, and rebellion against his father (The Mentor), Thanos's ensuing exile was not far from realization. When his father discovered Thanos conducting forbidden dark art experiments, he expelled Thanos from Titan - though not without a heavy heart. Fueled by his hatred for this slight, Thanos would begin to amass even more knowledge, skill, and power via mysticism, meditation, and bionics during his century-long isolation. Eventually, having surpassed all other Eternals in power and strength, Thanos decided to return to Titan to display his newfound might. Thanos would not come home with the intentions his father had hoped for after his punishment. Instead of atonement, Thanos attacked the planet with nuclear weaponry while orbiting Titan. Thanos had miscalculated Titan's defenses in his haste to sate his anger, which allowed some to escape the onslaught. However, only a handful of what was once thousands survived the invasion. As chance would have it, neither Thanos's brother nor father were on Titan during the assault. To Thanos's deep regret, though, his mother was not so fortunate, having stayed on Titan. In the aftermath, Thanos left the remains of Titan and returned to space, proving his devotion and worth to Death was all that mattered to him. During this time in the cosmos, Thanos conquered and pillaged many worlds, acquiring vast resources such as an assortment of followers, technology, weapons, and space-craft. At this point, Kronos (father of Mentor and the Earth-based Eternals' All-Father Zuras) sought to act out against Thanos's previous actions and any future actions he might take. Mentor pleaded this cause to Kronos in the interest that they might prevent further tragedy. To that end, Kronos created Drax the Destroyer to ward away the ill, which Kronos knew to be the future for The Mad Titan. Drax was formed as an avatar for the Eternal. Into Drax, Kronos would imbue the singular mission of seeking out Thanos to stop his schemes. Setting out upon his task, Drax would meet The Mad Titan on a living planet distant from our star system. The two mighty beings met in an incredibly violent physical confrontation. The clash rendered the landscape asunder, and the planet was destroyed - with the two combatants alone to drift within the debris. However, the planetary explosion would render Drax incapacitated, allowing the still-conscious Thanos to easily capture the Destroyer. After having dispatched Drax in such a fashion, Thanos made further plans for the stepping stones in his growing empire. Taking an interest in Earth, Thanos sent his henchmen, the Blood Brothers, to survey and deal with potential obstacles to his ambitions (one of which would become Iron Man). In the cosmic prison where Thanos had left him, Drax awoke to the coming danger of Thanos's plans. He then would reach out telepathically, warning Iron Man of the threat nearing his planet and the history the Titan had for violence. Yet the message was too late, as the brothers apprehended Tony before he could receive the distress call from Drax. The brothers would return Tony to Thanos's staging grounds. During this time, Tony drew upon an escape plan and ambushed the Brothers in an unsuspecting moment. Though able to catch the Brothers off-guard, Thanos became aware of the scuffle and stepped in. Thanos would crush the metal gloves around Tony's hands beneath his heel while Tony lay battered from a single Titan blow. However, Mentor had been monitoring events from Titan and fired unknown energy that reached Thanos, simultaneously saving Tony and setting Drax free. Thanos wasted no time deploying the brothers as a distraction while he began the self-destruct sequence and made his escape. After a fierce battle against the armored hordes of Thanos, the heroes then attacked the Titan himself. Yet to the heroes' dismay, they had attacked a robot look-alike left to keep them occupied until the ensuing explosion, which would allow for the Titan's full retreat. Witnessing this, Mentor was able to ward the heroes away before the blast reached critical mass. In the aftermath, Thanos's fortress was destroyed, but his whereabouts were unknown. True to his beginnings, Thanos ever seeks out the mysteries to power for personal use or as a ward from enemies seeking retribution. Yet even as Thanos continuously seeks power, he is forever-wed to his quest to be found worthy as Death's cohort. He has succeeded on multiple occasions, but is consistently defeated by his enemies. Most often, though (as in the case of the Cosmic Cube, The Infinity Gauntlet, and lastly, in the story told in Marvel: The End), it is a result of a deep psychological construct. In critical moments during these events, Thanos provides a window to his enemies into his subconscious, revealing a belief that he does not deserve or even want the power he seeks. This has been most often presented by the personification of his foil, Adam Warlock, who maintains a prescient link to Thanos through their extended contact within the Soul Gem."
        return enemy
    }
    
    func ultron() -> ParagonOverseer {
        let enemy = ParagonOverseer()
        
        enemy.Name = "Ultron"
        enemy.EntryTaunt = "I will make this world my own!"
        enemy.Handsize = 5
        enemy.StartingHandsize = 5
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
        enemy.Bio = "Ultron was created by Dr. Henry Pym, based upon his own thought and memory engrams. It was a foray into Artificial Intelligence that no scientist had ever taken before, not even Reed Richards. It started out as simply a box on treads with what appeared to be a head at the top. Dubbing the A.I. as Ultron-1, he hoped this represented a new era in scientific discovery. However something went horribly wrong, and Ultron became more than sentient and rebelled against his programming. He also defeated and then brainwashed Dr. Pym into forgetting that he had ever created him in the first place."
        return enemy
    }
    
    func venom() -> ParagonOverseer {
        let enemy = ParagonOverseer()
        
        enemy.Name = "Venom"
        enemy.EntryTaunt = "We are Venom!"
        enemy.Handsize = 4
        enemy.StartingHandsize = 4
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
        enemy.Bio = "Venom is of a race of alien symbiotes known as the Klyntar that are formed from a thick, liquid, organic material. They, as their symbiotic nature suggests, depend on other beings to help them sustain their life force. In exchange for this relationship, the symbiote offers great powers to its host. Unfortunately for the host, the symbiotes are not keen on the idea of separating and eventually start to fully consume both mind and body of their hosts. Removal of the symbiote is often only possible through the usage of strong sound waves produced from intensely loud and sustained noises."
        return enemy
    }
    
    func thug() -> ParagonOverseer {
        let enemy = ParagonOverseer()
        
        enemy.Name = "Thug"
        enemy.EntryTaunt = "I'ma smash you up!"
        enemy.Handsize = 3
        enemy.StartingHandsize = 3
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
        enemy.Bio = "A bag guy, doing bad stuff."
        return enemy
    }
    
    func brute() -> ParagonOverseer {
        let enemy = ParagonOverseer()
        
        enemy.Name = "Brute"
        enemy.EntryTaunt = "I'ma crush you!"
        enemy.Handsize = 4
        enemy.StartingHandsize = 4
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
        enemy.Bio = "The muscle and brawn of the streets."
        return enemy
    }
    
    func ninja() -> ParagonOverseer {
        let enemy = ParagonOverseer()
        
        enemy.Name = "Ninja"
        enemy.EntryTaunt = "The dark is my ally!"
        enemy.Handsize = 3
        enemy.StartingHandsize = 3
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
        enemy.Bio = "Unknown"
        return enemy
    }
}
