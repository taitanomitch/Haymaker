//
//  DeckOverseer.swift
//  Haymaker
//
//  Created by Mitchell Taitano on 11/13/18.
//  Copyright © 2018 Mitchell Taitano. All rights reserved.
//

import Foundation

class DeckOverseer {
    
    // MARK: - Variables
    var Deck: [Card]!
    var DiscardPile: [Card]!
    var PlayerHand: [Card]!
    var EnemyHand: [Card]!
    
    
    // MARK: - Deck Prep Functions
    public func prepareDeck() {
        if let _ = Deck {
            if let discardedPile = DiscardPile {
                Deck?.append(contentsOf: discardedPile)
                DiscardPile = []
                shuffleDek()
            } else {
                initializeDeck()
                initializeDiscardPile()
            }
        } else {
            initializeDeck()
            initializeDiscardPile()
        }
    }
    
    // MARK: - Hand Prep Functions
    public func prepareHand() {
        initializePlayerHand()
        initializeEnemyHand()
    }
    
    // MARK: - Get Functions
    public func getPlayerHandSize() -> Int {
        return PlayerHand.count
    }
    
    public func getEnemyHandSize() -> Int {
        return EnemyHand.count
    }
    
    // MARK: - Intializer Functions
    private func initializePlayerHand() {
        PlayerHand = []
    }
    
    private func initializeEnemyHand() {
        EnemyHand = []
    }
    
    private func initializeDiscardPile() {
        DiscardPile = []
    }
    
    private func initializeDeck() {
        Deck = []
        var myArr: NSArray?
        if let path = Bundle.main.path(forResource: "CardsDatabase", ofType: "plist") {
            myArr = NSArray(contentsOfFile: path)
        }
        if let arr = myArr {
            
            var nextCardData: NSDictionary
            var card: Card = Card()
            
            for index in 0..<arr.count {
                nextCardData = arr[index] as! NSDictionary
                
                let name: String = nextCardData.value(forKey: "Card Name")! as! String
                let typeString: String = nextCardData.value(forKey: "Card Type")! as! String
                let value: String = nextCardData.value(forKey: "Card Value")! as! String
                let event: String = nextCardData.value(forKey: "Card Event")! as! String
                let luckString: String = nextCardData.value(forKey: "Card Luck") as! String
                
                var type: ActionType = ActionType.doom
                switch typeString {
                case "Intellect":
                    type = ActionType.intellect
                case "Strength":
                    type = ActionType.strength
                case "Agility":
                    type = ActionType.agility
                case "Willpower":
                    type = ActionType.willpower
                case "Doom":
                    type = ActionType.doom
                default:
                    break
                }
                
                var luck: CardLuck = CardLuck.neutral
                switch luckString {
                case "Positive":
                    luck = CardLuck.positive
                case "Negative":
                    luck = CardLuck.negative
                case "Neutral":
                    luck = CardLuck.neutral
                default:
                    break
                }
                
                card = Card(name: name, type: type, value: value, event: event, luck: luck)
                Deck?.append(card)
            }
            shuffleDek()
        }

    }
    
    
    // MARK: - Action Functions
    private func shuffleDek() {
        Deck?.shuffle()
    }
    
    public func playerPlayCards(atPositions: [Int]) {
        var cardsToPlay = atPositions
        cardsToPlay.sort()
        cardsToPlay.reverse()
        if let _ = PlayerHand {
            for i in 0..<cardsToPlay.count {
                let card = (PlayerHand?.remove(at: cardsToPlay[i]))!
                DiscardPile?.append(card)
            }
        }
    }
    
    public func enemyPlayCards(atPositions: [Int]) {
        var cardsToPlay = atPositions
        cardsToPlay.sort()
        cardsToPlay.reverse()
        if let _ = EnemyHand {
            for i in 0..<cardsToPlay.count {
                let card = (EnemyHand?.remove(at: cardsToPlay[i]))!
                DiscardPile?.append(card)
            }
        }
    }
    
    public func playerPlayCard(atPosition: Int) -> Card {
        if let _ = PlayerHand {
            let card = (PlayerHand?.remove(at: atPosition))!
            DiscardPile?.append(card)
            return card
        } else {
            return Card()
        }
    }
    
    public func enemyPlayCard(atPosition: Int) -> Card {
        if let _ = EnemyHand {
            let card = (EnemyHand?.remove(at: atPosition))!
            DiscardPile?.append(card)
            return card
        } else {
            return Card()
        }
    }
    
    public func drawCardAndPlay() -> Card {
        if Deck.count == 0 {
            prepareDeck()
        }
        let nextCard = Deck.remove(at: 0)
        DiscardPile.append(nextCard)
        return nextCard
    }
    
    public func playerDrawCard() {
        if let _ = Deck {
            if let _ = PlayerHand {
                if((Deck?.count)! > 0) {
                    PlayerHand?.append((Deck?.remove(at: 0))!)
                } else {
                    prepareDeck()
                    PlayerHand?.append((Deck?.remove(at: 0))!)
                }
            }
        }
    }
    
    public func enemyDrawCard() {
        if let _ = Deck {
            if let _ = EnemyHand {
                if((Deck?.count)! > 0) {
                    EnemyHand?.append((Deck?.remove(at: 0))!)
                } else {
                    prepareDeck()
                    EnemyHand?.append((Deck?.remove(at: 0))!)
                }
            }
        }
    }
    
    // MARK: - Debug Functions
    public func printTop10Cards() {
        for i in 0..<10 {
            print(Deck[i].toString())
        }
    }
    
    public func printPlayerHand() {
        if let hand = PlayerHand {
            for i in 0..<hand.count {
                print("\(hand[i].getActionType().rawValue) - \(hand[i].getValue())")
            }
        }
    }
    
    public func printEnemyHand() {
        if let hand = EnemyHand {
            for i in 0..<hand.count {
                print("\(hand[i].getActionType().rawValue) - \(hand[i].getValue())")
            }
        }
    }
}

// MARK: - Collection Extensions
extension MutableCollection where Indices.Iterator.Element == Index {
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled , unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            self.swapAt(firstUnshuffled, i)
        }
    }
}

extension Sequence {
    func shuffled() -> [Iterator.Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}
