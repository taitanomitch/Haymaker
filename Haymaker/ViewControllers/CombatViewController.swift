//
//  CardPlayViewController.swift
//  Haymaker
//
//  Created by Mitchell Taitano on 11/16/18.
//  Copyright © 2018 Mitchell Taitano. All rights reserved.
//

import UIKit

protocol CombatViewDelegate {
    func CombatCompleted()
}

class CombatViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, PlayerPasswordDelegate {
    
    enum GameType {
        case pvp
        case pve
        case eve
        case none
    }
    
    enum PlayPhase {
        case selectAttack
        case edgeAttack
        case cardSelectAttack
        case damageToEnemy
        case enemyAttack
        case edgeDefend
        case cardSelectDefend
        case damageToHero
        case none
    }
    
    // MARK: - General IBOutlet Variables
    @IBOutlet weak var ActionLogPickerView: UIPickerView!
    @IBOutlet weak var ContainerHolderView: UIView!
    
    // MARK: - Card Show Section IBOutlet Variables
    @IBOutlet weak var TotalValueLabel: UILabel!
    @IBOutlet weak var PhaseLabel: UILabel!
    @IBOutlet weak var PlayCardsButton: UIButton!
    @IBOutlet weak var ActionTypeFrameView: UIView!
    @IBOutlet weak var ActionTypeColorView: UIView!
    @IBOutlet weak var ActionTypeValueView: UIView!
    @IBOutlet weak var CardPlayHolderView: UIView!
    @IBOutlet weak var CardPlayBackgroundView: UIView!
    @IBOutlet weak var CardHandHolderView: UIView!
    @IBOutlet weak var CardHandImageView: UIImageView!
    @IBOutlet weak var CardHandBackgroundView: UIView!
    @IBOutlet weak var CombatBackgroundImageView: UIImageView!
    @IBOutlet weak var PasswordPromptContainerView: UIView!
    
    // MARK: - Villain Sheet IBOutlet Variables
    @IBOutlet weak var HeroImageBackgroundView: UIView!
    @IBOutlet weak var HeroStatsBackgroundView: UIView!
    @IBOutlet weak var VillainImageBackgroundView: UIView!
    @IBOutlet weak var VillainStatsBackgroundView: UIView!
    
    // MARK: - Villain Sheet IBOutlet Variables
    @IBOutlet weak var VillainImageView: UIImageView!
    @IBOutlet weak var VillainImageHolderView: UIView!
    @IBOutlet weak var VillainTauntView: UIView!
    @IBOutlet weak var VillainTauntLabel: UILabel!
    @IBOutlet weak var VillainTauntBackgroundView: UIView!
    @IBOutlet weak var VillainDamagedView: UIView!
    @IBOutlet weak var VillainDamageReceivedLabel: UILabel!
    @IBOutlet weak var VillainDamageReceivedYConstraint: NSLayoutConstraint!
    @IBOutlet weak var VillainSheetView: UIView!
    @IBOutlet weak var VillainStrengthImageView: UIImageView!
    @IBOutlet weak var VillainAgilityImageView: UIImageView!
    @IBOutlet weak var VillainIntellectImageView: UIImageView!
    @IBOutlet weak var VillainWillpowerImageView: UIImageView!
    @IBOutlet weak var VillainHandSizeLabel: UILabel!
    @IBOutlet weak var VillainEdgeLabel: UILabel!
    @IBOutlet weak var VillainStrengthLabel: UILabel!
    @IBOutlet weak var VillainAgilityLabel: UILabel!
    @IBOutlet weak var VillainIntellectLabel: UILabel!
    @IBOutlet weak var VillainWillpowerLabel: UILabel!
    @IBOutlet weak var VillainAttackDefenseImageView: UIImageView!
    
    // MARK: - Hero Sheet IBOutlet Variables
    @IBOutlet weak var HeroImageView: UIImageView!
    @IBOutlet weak var HeroImageHolderView: UIView!
    @IBOutlet weak var HeroTauntView: UIView!
    @IBOutlet weak var HeroTauntLabel: UILabel!
    @IBOutlet weak var HeroTauntBackgroundView: UIView!
    @IBOutlet weak var HeroDamagedView: UIView!
    @IBOutlet weak var HeroDamageReceivedLabel: UILabel!
    @IBOutlet weak var HeroDamageReceivedYConstraint: NSLayoutConstraint!
    @IBOutlet weak var HeroSheetView: UIView!
    @IBOutlet weak var HeroStrengthImageView: UIImageView!
    @IBOutlet weak var HeroAgilityImageView: UIImageView!
    @IBOutlet weak var HeroIntellectImageView: UIImageView!
    @IBOutlet weak var HeroWillpowerImageView: UIImageView!
    @IBOutlet weak var HeroHandSizeLabel: UILabel!
    @IBOutlet weak var HeroEdgeLabel: UILabel!
    @IBOutlet weak var HeroStrengthLabel: UILabel!
    @IBOutlet weak var HeroAgilityLabel: UILabel!
    @IBOutlet weak var HeroIntellectLabel: UILabel!
    @IBOutlet weak var HeroWillpowerLabel: UILabel!
    @IBOutlet weak var HeroAttackDefenseImageView: UIImageView!
    
     // MARK: - Picker Log IBOutlet Variables
    @IBOutlet weak var ActionLogsHolderView: UIView!
    
    // MARK: - IBOutlet Constraint Variables
    @IBOutlet weak var CollectionViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var ActionSelectionViewBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Action Selector IBOutlet Variables
    @IBOutlet weak var ActionSelectorView: UIView!
    @IBOutlet weak var ActionSelectorBackgroundView: UIView!
    
    @IBOutlet weak var StrengthSelectorButton: UIButton!
    @IBOutlet weak var StrengthSelectorLabelsView: UIView!
    @IBOutlet weak var StrengthAttackNameLabel: UILabel!
    @IBOutlet weak var StrengthAttackValueLabel: UILabel!
    @IBOutlet weak var StrengthBonusDamageLabel: UILabel!
    @IBOutlet weak var StrengthShadowView: UIView!
    
    @IBOutlet weak var IntellectSelectorButton: UIButton!
    @IBOutlet weak var IntellectSelectorLabelsView: UIView!
    @IBOutlet weak var IntellectAttackNameLabel: UILabel!
    @IBOutlet weak var IntellectAttackValueLabel: UILabel!
    @IBOutlet weak var IntellectBonusDamageLabel: UILabel!
    @IBOutlet weak var IntellectShadowView: UIView!
    
    @IBOutlet weak var AgilitySelectorButton: UIButton!
    @IBOutlet weak var AgilitySelectorLabelsView: UIView!
    @IBOutlet weak var AgilityAttackNameLabel: UILabel!
    @IBOutlet weak var AgilityAttackValueLabel: UILabel!
    @IBOutlet weak var AgilityBonusDamageLabel: UILabel!
    @IBOutlet weak var AgilityShadowView: UIView!
    
    @IBOutlet weak var WillpowerSelectorButton: UIButton!
    @IBOutlet weak var WillpowerSelectorLabelsView: UIView!
    @IBOutlet weak var WillpowerAttackNameLabel: UILabel!
    @IBOutlet weak var WillpowerAttackValueLabel: UILabel!
    @IBOutlet weak var WillpowerBonusDamageLabel: UILabel!
    @IBOutlet weak var WillpowerShadowView: UIView!
    
    // MARK: - Card Collection IBOutlet Variables
    @IBOutlet weak var PlayerCardCollectionView: UICollectionView!
    @IBOutlet weak var CardsHolderView: UIView!
    
    // MARK: - Paragon Variables
    var HeroParagon: ParagonOverseer = ParagonOverseer()
    var VillainParagon: ParagonOverseer = ParagonOverseer()
    
    // MARK: - Variables
    public var delegate: CombatViewDelegate?
    var DeckController: DeckOverseer!
    var CurrentPlayerHandSize: Int = 0
    var PlayType: ActionType = .none
    var LogFontSize: CGFloat = 15.0
    
    // MARK: - Runtime Variables
    var InitialAttackType: ActionType = .none
    var PlayerEdgeCardLocations: [Int] = []
    var PlayerCardSelectionLocation: [Int] = []
    var PickerActionLog:[String] = ["Combat Begins!"]
    var CurrentPhase: PlayPhase = .none
    var CurrentGameType: GameType = .none
    var PlayerCardWidth: CGFloat = 0
    var PlayerCardHeight: CGFloat = 0
    var TotalPlayValue: Int = 0
    var EnemyTotalAttackValue: Int = 0
    var DamageToEnemy: Int = 0
    var DamageToHero: Int = 0
    var EnemyUnconscious: Bool = false
    var HeroUnconscious: Bool = false
    var CollectionViewIsDisplayed: Bool = false
    var AnimatingCollectionView: Bool = false
    var ActionSelectionViewIsDisplayed: Bool = false
    var AnimatingActionSelectionView: Bool = false
    var HeroAttacking: Bool = false
    var FirstSwap: Bool = false
    var UsingPasswords: Bool = false
    var PasswordViewController: PlayerPasswordsViewController = PlayerPasswordsViewController()
    var PlayWithRevives: Bool = true

    // MARK: - UI Variables
    var ScreenHeight: CGFloat = 0
    var NewCollectionConstraintConstant: CGFloat = 0
    
    // MARK: - Constant Variables
    var tauntDuration: Double = 3.2
    var indexStr: Int = 0
    var indexAgi: Int = 1
    var indexInt: Int = 2
    var indexWil: Int = 3
    var characterSheetTextColor: UIColor = UIColor.white
    var backgroundColor: UIColor = UIColor.black
    var backgroundAlpha: CGFloat = 0.60
    var shadowAlpha: CGFloat = 0.4
    var tauntLabelFont: String = "ActionMan"
    var tauntLabelFontSize: CGFloat = 16.0
    var reviveIncreaseConstant: Int = 4
    
    // MARK: - Loading Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpEntryTaunts()
        runSetup()
        if CurrentGameType == .pvp && UsingPasswords {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.promptPasswordEntry(ParagonForPassword: self.HeroParagon)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        for family in UIFont.familyNames.sorted() {
//            let names = UIFont.fontNames(forFamilyName: family)
//            print("Family: \(family) Font names: \(names)")
//        }
    }
    
    // MARK: - Setup Functions
    func runSetup() {
        setUpAttackOptions()
        determineInitiative()
        setUpDamgedViews()
        setupCardSizeUI()
        setPickerLineColors()
        updateTotalLabel()
        setInitialAttackType()
        setUpCardsButtonView()
        setUpActionTypeIndicatorFrame()
        setUpHolderViews()
        setAttackDefenseImages()
        setUpCharacterSheetViews()
        setPlayCardsButtonUI()
        setPlayCardsButtonText()
        setPhaseLabelValue()
        setUpHiddenViewPositions()
        setInitialActionSelectorViewPosition()
        setUpCombatBackgroundImageView()
        setUpBackgroundViews()
        setUpContainerView()
    }
    
    func runSwapSetup() {
        setUpAttackOptions()
        setUpDamgedViews()
        setupCardSizeUI()
        setPickerLineColors()
        updateTotalLabel()
        setInitialAttackType()
        setUpCardsButtonView()
        setUpActionTypeIndicatorFrame()
        setUpHolderViews()
        setAttackDefenseImages()
        setUpCharacterSheetViews()
        setPlayCardsButtonUI()
        setPlayCardsButtonText()
        setPhaseLabelValue()
        setUpHiddenViewPositions()
        setInitialActionSelectorViewPosition()
        PlayerCardCollectionView.reloadData()
    }
    
    
    // MARK: - Transition Functions
    func getDismissTransition() -> CATransition {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        return transition
    }
    
    func displayActionSelectionMenu() {
        setUpAttackOptions()
        if !AnimatingActionSelectionView {
            AnimatingActionSelectionView = true
            ActionSelectionViewIsDisplayed = !ActionSelectionViewIsDisplayed
            if ActionSelectionViewIsDisplayed {
                ActionSelectorView.alpha = 1.0
                ActionSelectionViewBottomConstraint.constant = 0
            } else {
                ActionSelectionViewBottomConstraint.constant = NewCollectionConstraintConstant
            }
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
            AnimatingActionSelectionView = false
        }
    }
    
    
    // MARK: - Utility Functions
    func calculateEnemyTotalDamage() {
        switch VillainParagon.CurrentActionType {
        case .strength:
            EnemyTotalAttackValue = EnemyTotalAttackValue + VillainParagon.DamageBonuses[indexStr]
        case .agility:
            EnemyTotalAttackValue = EnemyTotalAttackValue + VillainParagon.DamageBonuses[indexAgi]
        case .intellect:
            EnemyTotalAttackValue = EnemyTotalAttackValue + VillainParagon.DamageBonuses[indexInt]
        case .willpower:
            EnemyTotalAttackValue = EnemyTotalAttackValue + VillainParagon.DamageBonuses[indexWil]
        default:
            break
        }
    }
    
    func calculatePlayerTotalDamage() {
        switch HeroParagon.CurrentActionType {
        case .strength:
            TotalPlayValue = TotalPlayValue + HeroParagon.DamageBonuses[indexStr]
        case .agility:
            TotalPlayValue = TotalPlayValue + HeroParagon.DamageBonuses[indexAgi]
        case .intellect:
            TotalPlayValue = TotalPlayValue + HeroParagon.DamageBonuses[indexInt]
        case .willpower:
            TotalPlayValue = TotalPlayValue + HeroParagon.DamageBonuses[indexWil]
        default:
            break
        }
    }
    
    
    // MARK: - Phase Functions
    func beginSelectAttack() {
        if HeroParagon.CurrentActionType == .strength || HeroParagon.CurrentActionType == .agility || HeroParagon.CurrentActionType == .intellect || HeroParagon.CurrentActionType == .willpower {
            CurrentPhase = .edgeAttack
            setPlayCardsButtonText()
            setAbilityScoreToPlayValue()
            displayActionSelectionMenu()
            setActionIndicatorColor()
            setPhaseLabelValue()
            updateTotalLabel()
            addTextToLog(event: "\(HeroParagon.Name) Starting Attack: (\(TotalPlayValue))")
        } else if ActionSelectorView.alpha == 0 {
                showOrHideActionSelectorView()
        }
    }
    
    func beginEdgeAttack() {
        CurrentPhase = .cardSelectAttack
        setPhaseLabelValue()
        setPlayCardsButtonText()
        
        if PlayerEdgeCardLocations.count > 0 {
            addEdgeToTotal()
            removePlayedEdgeCards()
            updateTotalLabel()
            PlayerEdgeCardLocations = []
        }
        addTextToLog(event: "\(HeroParagon.Name) Current Attack: (\(TotalPlayValue))")
    }
    
    func beginCardSelectAttack() {
        if PlayerCardSelectionLocation.count > 0 {
            if CurrentGameType == .pvp {
                let cardPlayed = DeckController.playerPlayCard(atPosition: PlayerCardSelectionLocation[0])
                EnemyTotalAttackValue = TotalPlayValue + playCardAndReturnTotalValue(card: cardPlayed, type: HeroParagon.CurrentActionType)
                
                redrawCards()
                performParagonPowers(paragon: HeroParagon)
                
                addTextToLog(event: "\(HeroParagon.Name) Attack Value: (\(EnemyTotalAttackValue))")
                
                swapParagonSides()
                if(UsingPasswords) {
                    promptPasswordEntry(ParagonForPassword: HeroParagon)
                }
                
                CurrentPhase = .edgeDefend
                setPhaseLabelValue()
                setPlayCardsButtonText()
                
                setHeroDefenseActionType()
                setAbilityScoreToPlayValue()
                updateTotalLabel()
                addTextToLog(event: "\(HeroParagon.Name) Starting Dodge: (\(TotalPlayValue))")
            } else {
                CurrentPhase = .damageToEnemy
                setPhaseLabelValue()
                setPlayCardsButtonText()
                
                let cardPlayed = DeckController.playerPlayCard(atPosition: PlayerCardSelectionLocation[0])
                TotalPlayValue = TotalPlayValue + playCardAndReturnTotalValue(card: cardPlayed, type: HeroParagon.CurrentActionType)
                
                addTextToLog(event: "\(HeroParagon.Name) Attack Value: (\(TotalPlayValue))")
                
                redrawCards()
                performParagonPowers(paragon: HeroParagon)
                updateTotalLabel()
                PlayerCardCollectionView.reloadData()
                enemyAttemptToDodge()
                redrawEnemyCards()
                PlayerCardSelectionLocation = []
                if DamageToEnemy <= 0 {
                    CurrentPhase = .enemyAttack
                    HeroParagon.CurrentActionType = .doom
                    setActionIndicatorColor()
                    flipAttackDefenseImages()
                    resetTotalPlayValue()
                    updateTotalLabel()
                    setPhaseLabelValue()
                    setPlayCardsButtonText()
                }
            }
        }
    }
    
    func beginDamageToEnemy() {
        flashEnemyDamagedView()
        enemyTakeDamage()
        resetTotalPlayValue()
        if EnemyUnconscious {
            addTextToLog(event: "\(HeroParagon.Name) WINS!")
            CurrentPhase = .none
        } else {
            CurrentPhase = .enemyAttack
            HeroParagon.CurrentActionType = .doom
            updateTotalLabel()
            setActionIndicatorColor()
            if CurrentGameType != .eve {
                flipAttackDefenseImages()
            }
        }
        setPhaseLabelValue()
        setPlayCardsButtonText()
    }
    
    func beginEnemyAttack() {
        enemyAttack()
        addTextToLog(event: "\(VillainParagon.Name) Attack Value: (\(EnemyTotalAttackValue))")
        performParagonPowers(paragon: VillainParagon)
        
        if CurrentGameType == .pve {
            CurrentPhase = .edgeDefend
            setPhaseLabelValue()
            setPlayCardsButtonText()
            
            redrawEnemyCards()
            setHeroDefenseActionType()
            setAbilityScoreToPlayValue()
            setHandSizeLabels()
            updateTotalLabel()
            addTextToLog(event: "\(HeroParagon.Name) Dodge Value: (\(TotalPlayValue))")
        } else if CurrentGameType == .eve {
            CurrentPhase = .damageToEnemy
            TotalPlayValue = EnemyTotalAttackValue
            
            redrawEnemyCards()
            swapParagonSides()
            if FirstSwap {
                FirstSwap = false
                flipAttackDefenseImages()
            }
            enemyAttemptToDodge()
            redrawEnemyCards()
            if DamageToEnemy <= 0 {
                CurrentPhase = .enemyAttack
                HeroParagon.CurrentActionType = .doom
                setActionIndicatorColor()
                resetTotalPlayValue()
                setPhaseLabelValue()
            }
        }
    }
    
    func beginEdgeDefend() {
        CurrentPhase = .cardSelectDefend
        setPhaseLabelValue()
        setPlayCardsButtonText()
        
        if PlayerEdgeCardLocations.count > 0 {
            addEdgeToTotal()
            removePlayedEdgeCards()
            updateTotalLabel()
            PlayerEdgeCardLocations = []
        }
        addTextToLog(event: "\(HeroParagon.Name) Starting Dodge: (\(TotalPlayValue))")
    }
    
    func beginCardSelectDefend() {
        if PlayerCardSelectionLocation.count > 0 {
            let cardPlayed = DeckController.playerPlayCard(atPosition: PlayerCardSelectionLocation[0])
            TotalPlayValue = TotalPlayValue + playCardAndReturnTotalValue(card: cardPlayed, type: HeroParagon.CurrentActionType)
            redrawCards()
            updateTotalLabel()
            PlayerCardCollectionView.reloadData()
            PlayerCardSelectionLocation = []
            addTextToLog(event: "\(HeroParagon.Name) Dodge: (\(TotalPlayValue))")
            
            var heroResistance = 0
            if VillainParagon.CurrentActionType == .willpower {
                heroResistance = HeroParagon.Willpower + HeroParagon.WillpowerResistanceBonus
            } else {
                heroResistance = HeroParagon.Strength + HeroParagon.DamageResistance
            }
            
            if TotalPlayValue > EnemyTotalAttackValue {
                addTextToLog(event: "\(HeroParagon.Name) Dodged The Attack!")
                CurrentPhase = .selectAttack
                HeroParagon.CurrentActionType = .doom
                displayActionSelectionMenu()
                setActionIndicatorColor()
                updateTotalLabel()
                flipAttackDefenseImages()
            } else {
                calculateEnemyTotalDamage()
                addTextToLog(event: "\(VillainParagon.Name) Total Attack Damage: (\(EnemyTotalAttackValue))")
                addTextToLog(event: "\(HeroParagon.Name) Resistance: (\(heroResistance))")
                
                if EnemyTotalAttackValue - heroResistance <= 0 {
                    addTextToLog(event: "\(HeroParagon.Name) Resisted The Damage!")
                    CurrentPhase = .selectAttack
                    HeroParagon.CurrentActionType = .doom
                    
                    displayActionSelectionMenu()
                    setActionIndicatorColor()
                    updateTotalLabel()
                    flipAttackDefenseImages()
                } else {
                    CurrentPhase = .damageToHero
                    ActionTypeColorView.backgroundColor = ColorUtilities.BlackDoom
                    DamageToHero = EnemyTotalAttackValue - heroResistance
                    TotalValueLabel.text = "\(DamageToHero)"
                    addTextToLog(event: "\(HeroParagon.Name) Took \(DamageToHero) Damage!")
                    flashPlayerDamagedView()
                    
                    var HandTotal = 0
                    for i in 0..<DeckController.PlayerHand.count {
                        HandTotal = HandTotal + DeckController.PlayerHand[i].getValue()
                    }
                    
                    if HandTotal < DamageToHero {
                        if paragonWillpowerRevived(paragon: HeroParagon) {
                            DeckController.clearPlayerHand()
                            HeroParagon.Handsize = 2
                            redrawCards()
                            CurrentPhase = .selectAttack
                        } else {
                            HeroUnconscious = true
                            flipParagonToUnconscious()
                            CurrentPhase = .none
                            addTextToLog(event: "\(HeroParagon.Name) Has Feinted...")
                            addTextToLog(event: "\(VillainParagon.Name) WINS!")
                            setPlayCardsButtonText()
                            for _ in 0..<DeckController.PlayerHand.count {
                                let _ = DeckController.playerPlayCard(atPosition: DeckController.PlayerHand.count - 1)
                            }
                            HeroParagon.Handsize = 0
                            PlayerCardCollectionView.reloadData()
                            setHandSizeLabels()
                        }
                    }
                }
            }
            
            setPhaseLabelValue()
            setPlayCardsButtonText()
        }
    }
    
    func beginDamageToHero() {
        if getTotalValueOfSelectedCards() >= DamageToHero {
            HeroParagon.Handsize = HeroParagon.Handsize - PlayerCardSelectionLocation.count
            
            PlayerCardSelectionLocation.sort()
            PlayerCardSelectionLocation.reverse()
            for i in 0..<PlayerCardSelectionLocation.count {
                let _ = DeckController.playerPlayCard(atPosition: PlayerCardSelectionLocation[i])
            }
            PlayerCardSelectionLocation = []
            PlayerCardCollectionView.reloadData()
            redrawEnemyCards()
            setHandSizeLabels()
            
            if HeroParagon.Handsize == 0 {
                if paragonWillpowerRevived(paragon: HeroParagon) {
                    DeckController.clearPlayerHand()
                    HeroParagon.Handsize = 2
                    redrawCards()
                } else {
                    HeroUnconscious = true
                    flipParagonToUnconscious()
                }
            }
            
            if HeroUnconscious {
                CurrentPhase = .none
                addTextToLog(event: "\(HeroParagon.Name) Has Feinted...")
                addTextToLog(event: "\(VillainParagon.Name) WINS!")
                setPlayCardsButtonText()
            } else {
                CurrentPhase = .selectAttack
                HeroParagon.CurrentActionType = .doom
                displayActionSelectionMenu()
                setActionIndicatorColor()
                setPhaseLabelValue()
                setPlayCardsButtonText()
                updateTotalLabel()
                flipAttackDefenseImages()
            }
        }
    }
    
    // MARK: - Button Functions
    @IBAction func pressPlayCardsButton(_ sender: UIButton) {
        pressNextPhaseButton()
    }
    
    @IBAction func pressDisplayCardsButton(_ sender: UIButton) {
        if !AnimatingCollectionView && !AnimatingActionSelectionView {
            AnimatingCollectionView = true
            if CurrentPhase == .selectAttack {
                showOrHideActionSelectorView()
                if !CollectionViewIsDisplayed {
                    showOrHideCardsView()
                }
            } else {
                showOrHideCardsView()
            }
            AnimatingCollectionView = false
        }
    }

    func pressNextPhaseButton() {
        switch CurrentPhase {
        case .selectAttack:
            beginSelectAttack()
        case .edgeAttack:
            beginEdgeAttack()
        case .cardSelectAttack:
            beginCardSelectAttack()
        case .damageToEnemy:
            beginDamageToEnemy()
        case .enemyAttack:
            beginEnemyAttack()
        case .edgeDefend:
            beginEdgeDefend()
        case .cardSelectDefend:
            beginCardSelectDefend()
        case .damageToHero:
            beginDamageToHero()
        case .none:
            let transition = getDismissTransition()
            view.window!.layer.add(transition, forKey: kCATransition)
            self.dismiss(animated: false) {
                self.delegate?.CombatCompleted()
            }
            return
        }
    }
    
    @IBAction func pressEnterButton(_ sender: UIButton) {
        view.endEditing(true)
        if PasswordViewController.ifPasswordCorrect() {
            UIView.animate(withDuration: 0.4) {
                self.ContainerHolderView.alpha = 0.0
            }
        }
        PasswordViewController.clearPasswordAttemptTextfield()
    }
    
    @IBAction func pressSelectStrengthAction(_ sender: UIButton) {
        HeroParagon.CurrentActionType = .strength
        PlayCardsButton.setTitleColor(UIColor.white, for: .normal)
        PlayCardsButton.setTitle("Select Strength Attack", for: .normal)
    }
    
    @IBAction func pressSelectIntellectAction(_ sender: UIButton) {
        HeroParagon.CurrentActionType = .intellect
        PlayCardsButton.setTitleColor(UIColor.white, for: .normal)
        PlayCardsButton.setTitle("Select Intellect Attack", for: .normal)
    }
    
    @IBAction func pressSelectAgilityAction(_ sender: UIButton) {
        HeroParagon.CurrentActionType = .agility
        PlayCardsButton.setTitleColor(UIColor.white, for: .normal)
        PlayCardsButton.setTitle("Select Agility Attack", for: .normal)
    }
    
    @IBAction func pressSelectWillpowerAction(_ sender: UIButton) {
        HeroParagon.CurrentActionType = .willpower
        PlayCardsButton.setTitleColor(UIColor.white, for: .normal)
        PlayCardsButton.setTitle("Select Willpower Attack", for: .normal)
    }
    
    // MARK: - Side Swap Functions
    func swapParagonSides() {
        let TempParagon: ParagonOverseer = HeroParagon
        HeroParagon = VillainParagon
        VillainParagon = TempParagon
        DeckController.TempHand = DeckController.PlayerHand
        DeckController.PlayerHand = DeckController.EnemyHand
        DeckController.EnemyHand = DeckController.TempHand
        PlayerCardSelectionLocation.removeAll()
        VillainTauntLabel.text = VillainParagon.EntryTaunt
        VillainTauntLabel.textColor = characterSheetTextColor
        VillainTauntLabel.font = UIFont(name: tauntLabelFont, size: tauntLabelFontSize)
        HeroTauntLabel.text = HeroParagon.EntryTaunt
        HeroTauntLabel.textColor = characterSheetTextColor
        HeroTauntLabel.font = UIFont(name: tauntLabelFont, size: tauntLabelFontSize)
        runSwapSetup()
    }
    
    // MARK: - Card Playing Functions
    func setAbilityScoreToPlayValue() {
        if CurrentPhase == .edgeAttack {
            switch HeroParagon.CurrentActionType {
            case .strength:
                TotalPlayValue = HeroParagon.AttackValues[indexStr]
            case .agility:
                TotalPlayValue = HeroParagon.AttackValues[indexAgi]
            case .intellect:
                TotalPlayValue = HeroParagon.AttackValues[indexInt]
            case .willpower:
                TotalPlayValue = HeroParagon.AttackValues[indexWil]
            default:
                TotalPlayValue = 0
            }
        } else if CurrentPhase == .edgeDefend {
            switch HeroParagon.CurrentActionType {
            case .strength:
                TotalPlayValue = HeroParagon.Strength
            case .agility:
                TotalPlayValue = HeroParagon.Agility + HeroParagon.DodgeBonus
            case .intellect:
                TotalPlayValue = HeroParagon.Intellect
            case .willpower:
                TotalPlayValue = HeroParagon.Willpower
            default:
                TotalPlayValue = 0
            }
        }
    }
    
    func addEdgeToTotal() {
        for i in 0..<PlayerEdgeCardLocations.count {
            TotalPlayValue = TotalPlayValue + DeckController.PlayerHand[PlayerEdgeCardLocations[i]].getValue()
        }
    }
    
    func removePlayedEdgeCards() {
        PlayerEdgeCardLocations.sort()
        PlayerEdgeCardLocations.reverse()
        for i in 0..<PlayerEdgeCardLocations.count {
            let _ = DeckController.playerPlayCard(atPosition: PlayerEdgeCardLocations[i])
        }
        PlayerCardCollectionView.reloadData()
    }
    
    func playCardAndReturnTotalValue(card: Card, type: ActionType) -> Int {
        if card.getActionType() == type {
            var thisTotalPlayValue = card.getValue()
            var matchingActionType: Bool = true
            while(matchingActionType) {
                let nextCard = DeckController.drawCardAndPlay()
                thisTotalPlayValue = thisTotalPlayValue + nextCard.getValue()
                if(nextCard.getActionType() != type) {
                    matchingActionType = false
                }
            }
            return thisTotalPlayValue
        } else {
            return card.getValue()
        }
    }
    
    func getTotalValueOfSelectedCards() -> Int {
        var totalValueOfCards = 0
        for i in 0..<PlayerCardSelectionLocation.count {
            totalValueOfCards = totalValueOfCards + DeckController.PlayerHand[PlayerCardSelectionLocation[i]].getValue()
        }
        return totalValueOfCards
    }
    
    
    // MARK: - Hero Villain Sheet Functions
    func setHandSizeLabels() {
        HeroHandSizeLabel.text = "\(DeckController.getPlayerHandSize())"
        HeroHandSizeLabel.textColor = characterSheetTextColor
        HeroEdgeLabel.text = "(\(HeroParagon.Edge))"
        HeroEdgeLabel.textColor = characterSheetTextColor
        VillainHandSizeLabel.text = "\(DeckController.getEnemyHandSize())"
        VillainHandSizeLabel.textColor = characterSheetTextColor
        VillainEdgeLabel.text = "(\(VillainParagon.Edge))"
        VillainEdgeLabel.textColor = characterSheetTextColor
    }
    
    func setUpCharacterSheetViews() {
        setHandSizeLabels()
        
        HeroImageView.image = UIImage(named: HeroParagon.Name)
        VillainImageView.image = UIImage(named: VillainParagon.Name)
        HeroSheetView.layer.cornerRadius = 4.0
        HeroSheetView.layer.masksToBounds = true
        VillainSheetView.layer.cornerRadius = 4.0
        VillainSheetView.layer.masksToBounds = true
        HeroImageHolderView.layer.cornerRadius = 4.0
        HeroImageHolderView.layer.masksToBounds = true
        VillainImageHolderView.layer.cornerRadius = 4.0
        VillainImageHolderView.layer.masksToBounds = true
        
        HeroStrengthImageView.layer.cornerRadius = 4.0
        HeroStrengthImageView.layer.masksToBounds = true
        HeroStrengthImageView.backgroundColor = ColorUtilities.GreenStrength
        HeroStrengthImageView.image = HeroStrengthImageView.image!.withRenderingMode(.alwaysTemplate)
        HeroStrengthImageView.tintColor = UIColor.white
        HeroStrengthLabel.text = "\(HeroParagon.Strength)"
        HeroStrengthLabel.textColor = characterSheetTextColor
        HeroStrengthLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        HeroAgilityImageView.layer.cornerRadius = 4.0
        HeroAgilityImageView.layer.masksToBounds = true
        HeroAgilityImageView.image = HeroAgilityImageView.image!.withRenderingMode(.alwaysTemplate)
        HeroAgilityImageView.tintColor = UIColor.white
        HeroAgilityImageView.backgroundColor = ColorUtilities.RedAgility
        HeroAgilityLabel.text = "\(HeroParagon.Agility)"
        HeroAgilityLabel.textColor = characterSheetTextColor
        HeroAgilityLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        HeroIntellectImageView.layer.cornerRadius = 4.0
        HeroIntellectImageView.layer.masksToBounds = true
        HeroIntellectImageView.image = HeroIntellectImageView.image!.withRenderingMode(.alwaysTemplate)
        HeroIntellectImageView.tintColor = UIColor.white
        HeroIntellectImageView.backgroundColor = ColorUtilities.BlueIntellect
        HeroIntellectLabel.text = "\(HeroParagon.Intellect)"
        HeroIntellectLabel.textColor = characterSheetTextColor
        HeroIntellectLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        HeroWillpowerImageView.layer.cornerRadius = 4.0
        HeroWillpowerImageView.layer.masksToBounds = true
        HeroWillpowerImageView.image = HeroWillpowerImageView.image!.withRenderingMode(.alwaysTemplate)
        HeroWillpowerImageView.tintColor = UIColor.white
        HeroWillpowerImageView.backgroundColor = ColorUtilities.PurpleWillpower
        HeroWillpowerLabel.text = "\(HeroParagon.Willpower)"
        HeroWillpowerLabel.textColor = characterSheetTextColor
        HeroWillpowerLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        VillainStrengthImageView.layer.cornerRadius = 4.0
        VillainStrengthImageView.layer.masksToBounds = true
        VillainStrengthImageView.backgroundColor = ColorUtilities.GreenStrength
        VillainStrengthImageView.image = HeroStrengthImageView.image!.withRenderingMode(.alwaysTemplate)
        VillainStrengthImageView.tintColor = UIColor.white
        VillainStrengthLabel.text = "\(VillainParagon.Strength)"
        VillainStrengthLabel.textColor = characterSheetTextColor
        VillainStrengthLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        VillainAgilityImageView.layer.cornerRadius = 4.0
        VillainAgilityImageView.layer.masksToBounds = true
        VillainAgilityImageView.image = HeroAgilityImageView.image!.withRenderingMode(.alwaysTemplate)
        VillainAgilityImageView.tintColor = UIColor.white
        VillainAgilityImageView.backgroundColor = ColorUtilities.RedAgility
        VillainAgilityLabel.text = "\(VillainParagon.Agility)"
        VillainAgilityLabel.textColor = characterSheetTextColor
        VillainAgilityLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        VillainIntellectImageView.layer.cornerRadius = 4.0
        VillainIntellectImageView.layer.masksToBounds = true
        VillainIntellectImageView.image = HeroIntellectImageView.image!.withRenderingMode(.alwaysTemplate)
        VillainIntellectImageView.tintColor = UIColor.white
        VillainIntellectImageView.backgroundColor = ColorUtilities.BlueIntellect
        VillainIntellectLabel.text = "\(VillainParagon.Intellect)"
        VillainIntellectLabel.textColor = characterSheetTextColor
        VillainIntellectLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        VillainWillpowerImageView.layer.cornerRadius = 4.0
        VillainWillpowerImageView.layer.masksToBounds = true
        VillainWillpowerImageView.image = HeroWillpowerImageView.image!.withRenderingMode(.alwaysTemplate)
        VillainWillpowerImageView.tintColor = UIColor.white
        VillainWillpowerImageView.backgroundColor = ColorUtilities.PurpleWillpower
        VillainWillpowerLabel.text = "\(VillainParagon.Willpower)"
        VillainWillpowerLabel.textColor = characterSheetTextColor
        VillainWillpowerLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
    }
    
    func flipAttackDefenseImages() {
        HeroAttacking = !HeroAttacking
        if HeroAttacking {
            HeroAttackDefenseImageView.image = UIImage(named: "Icon_Attack")
            VillainAttackDefenseImageView.image = UIImage(named: "Icon_Defense")
        } else {
            VillainAttackDefenseImageView.image = UIImage(named: "Icon_Attack")
            HeroAttackDefenseImageView.image = UIImage(named: "Icon_Defense")
        }
        UIView.transition(with: HeroAttackDefenseImageView, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        UIView.transition(with: VillainAttackDefenseImageView, duration: 0.5, options: .transitionFlipFromRight, animations: nil, completion: nil)
    }
    
    func flipParagonToUnconscious() {
        if HeroUnconscious {
            HeroImageView.image = UIImage(named: "Icon_Unconscious")
            HeroImageView.tintColor = characterSheetTextColor
            UIView.transition(with: HeroImageView, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        } else if EnemyUnconscious {
            VillainImageView.image = UIImage(named: "Icon_Unconscious")
            VillainImageView.tintColor = characterSheetTextColor
            UIView.transition(with: VillainImageView, duration: 0.5, options: .transitionFlipFromRight, animations: nil, completion: nil)
        }
    }
    
    func setAttackDefenseImages() {
        HeroAttackDefenseImageView.tintColor = characterSheetTextColor
        VillainAttackDefenseImageView.tintColor = characterSheetTextColor
        if HeroAttacking {
            HeroAttackDefenseImageView.image = UIImage(named: "Icon_Attack")
            VillainAttackDefenseImageView.image = UIImage(named: "Icon_Defense")
        } else {
            VillainAttackDefenseImageView.image = UIImage(named: "Icon_Attack")
            HeroAttackDefenseImageView.image = UIImage(named: "Icon_Defense")
        }
    }
    
    
    // MARK: - Damage UI Functions
    func flashEnemyDamagedView() {
        UIView.animate(withDuration: 0.25) {
            self.VillainDamagedView.alpha = 0.6
        } completion: { (didComplete) in
            UIView.animate(withDuration: 0.25) {
                self.VillainDamagedView.alpha = 0.0
            } completion: { (didCompletePartTwo) in
                self.displayDamageToVillain()
            }
        }
    }
    
    func flashPlayerDamagedView() {
        UIView.animate(withDuration: 0.25) {
            self.HeroDamagedView.alpha = 0.6
        } completion: { (didCompletePartOne) in
            UIView.animate(withDuration: 0.25) {
                self.HeroDamagedView.alpha = 0.0
            } completion: { (didCompletePartTwo) in
                self.displayDamageToHero()
            }
        }
    }
    
    func displayDamageToVillain() {
        VillainDamageReceivedYConstraint.constant = 40
        let damageStringTextAttributes = [NSAttributedString.Key.strokeColor : UIColor.red, NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.strokeWidth : -6.0, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 40)] as [NSAttributedString.Key : Any]
        VillainDamageReceivedLabel.attributedText = NSMutableAttributedString(string: "-" + String(DamageToEnemy), attributes: damageStringTextAttributes)
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.2) {
            self.VillainDamageReceivedLabel.alpha = 1.0
        } completion: { (didCompletePartOne) in
            UIView.animate(withDuration: 0.2, delay: 1.1, options: UIView.AnimationOptions.init()) {
                self.VillainDamageReceivedLabel.alpha = 0.0
            } completion: { (didComplete) in }
        }
        
        UIView.animate(withDuration: 1.5) {
            self.VillainDamageReceivedYConstraint.constant = -40
            self.view.layoutIfNeeded()
        } completion: { (didComplete) in
            self.VillainDamageReceivedYConstraint.constant = 40
        }
    }
    
    func displayDamageToHero() {
        HeroDamageReceivedYConstraint.constant = 40
        let damageStringTextAttributes = [NSAttributedString.Key.strokeColor : UIColor.red, NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.strokeWidth : -6.0, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 40)] as [NSAttributedString.Key : Any]
        HeroDamageReceivedLabel.attributedText = NSMutableAttributedString(string: "-" + String(DamageToHero), attributes: damageStringTextAttributes)
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.2) {
            self.HeroDamageReceivedLabel.alpha = 1.0
        } completion: { (didCompletePartOne) in
            UIView.animate(withDuration: 0.2, delay: 1.1, options: UIView.AnimationOptions.init()) {
                self.HeroDamageReceivedLabel.alpha = 0.0
            } completion: { (didComplete) in }
        }
        
        UIView.animate(withDuration: 1.5) {
            self.HeroDamageReceivedYConstraint.constant = -40
            self.view.layoutIfNeeded()
        } completion: { (didComplete) in
            self.HeroDamageReceivedYConstraint.constant = 40
        }
    }
    
    
    // MARK: - Enemy Damage Functions
    func enemyTakeDamage() {
        if DeckController.EnemyHand.count == 0 {
            if paragonWillpowerRevived(paragon: VillainParagon) {
                DeckController.clearEnemyHand()
                VillainParagon.Handsize = 2
                redrawEnemyCards()
            } else {
                EnemyUnconscious = true
                flipParagonToUnconscious()
            }
            return
        }
        
        if DamageToEnemy <= 0 {
            return
        }
        
        var cardsToPay: [Int] = []
        
        var singleCardPay: Bool = false
        for i in 0..<DeckController.EnemyHand.count {
            
            if DeckController.EnemyHand[i].getValue() >= DamageToEnemy {
                if singleCardPay {
                    if DeckController.EnemyHand[cardsToPay[0]].getValue() < DeckController.EnemyHand[i].getValue() {
                        cardsToPay.removeAll()
                        cardsToPay.append(i)
                    }
                } else {
                    singleCardPay = true
                    cardsToPay.append(i)
                }
            }
        }
        
        if !singleCardPay {
            var positionHolder: [Int] = []
            var calculationComplete = false
            while(!calculationComplete) {
                if DeckController.EnemyHand.count == positionHolder.count {
                    cardsToPay = []
                    for i in 0..<DeckController.EnemyHand.count {
                        cardsToPay.append(i)
                    }
                    calculationComplete = true
                    break
                }
                
                var largestCardPosition = -1
                var largestCardValue = -1
                for i in 0..<DeckController.EnemyHand.count {
                    if !positionHolder.contains(i) {
                        if DeckController.EnemyHand[i].getValue() > largestCardValue {
                            largestCardValue = DeckController.EnemyHand[i].getValue()
                            largestCardPosition = i
                        } else if DeckController.EnemyHand[i].getValue() == largestCardValue {
                            if DeckController.EnemyHand[i].getActionType() == .doom  && DeckController.EnemyHand[largestCardPosition].getActionType() != .doom {
                                largestCardValue = DeckController.EnemyHand[i].getValue()
                                largestCardPosition = i
                            }
                        }
                    }
                }
                if largestCardValue > 0 {
                    positionHolder.append(largestCardPosition)
                }
                
                var paymentSum = 0
                for i in 0..<positionHolder.count {
                    paymentSum = paymentSum + DeckController.EnemyHand[i].getValue()
                }
                if paymentSum >= DamageToEnemy {
                    calculationComplete = true
                    for i in 0..<positionHolder.count {
                        for j in 0..<DeckController.EnemyHand.count {
                            if !positionHolder.contains(j) {
                                let newValue = paymentSum - DeckController.EnemyHand[positionHolder[i]].getValue() + DeckController.EnemyHand[j].getValue()
                                if (newValue < paymentSum) && (paymentSum >= DamageToEnemy) {
                                    positionHolder.remove(at: i)
                                    positionHolder.append(j)
                                }
                            }
                        }
                    }
                }
            }
            
            cardsToPay = positionHolder
        }
        
        cardsToPay.sort()
        cardsToPay.reverse()
        for i in 0..<cardsToPay.count {
            let _ = DeckController.enemyPlayCard(atPosition: cardsToPay[i])
        }
        
        if DeckController.EnemyHand.count == 0 {
            if paragonWillpowerRevived(paragon: VillainParagon) {
                DeckController.clearEnemyHand()
                VillainParagon.Handsize = 2
                redrawEnemyCards()
            } else {
                EnemyUnconscious = true
                flipParagonToUnconscious()
                addTextToLog(event: "\(VillainParagon.Name) Has Feinted...")
            }
        } else {
            VillainParagon.Handsize = DeckController.EnemyHand.count
        }
        setHandSizeLabels()
    }
    
    
    // MARK: - Enemy Attack Functions
    func enemyAttack() {
        VillainParagon.CurrentActionType = determineEnemyAttackType()
        
        EnemyTotalAttackValue = 0
        switch VillainParagon.CurrentActionType {
        case .strength:
            EnemyTotalAttackValue = VillainParagon.AttackValues[indexStr]
        case .agility:
            EnemyTotalAttackValue = VillainParagon.AttackValues[indexAgi]
        case .intellect:
            EnemyTotalAttackValue = VillainParagon.AttackValues[indexInt]
        case .willpower:
            EnemyTotalAttackValue = VillainParagon.AttackValues[indexWil]
        default:
            EnemyTotalAttackValue = 0
        }

        EnemyTotalAttackValue = EnemyTotalAttackValue + enemyPlayEdgeCards()
        
        var cardToPlayPosition = -1
        var cardMatchingType = false
        var highestCardValuePosition = -1
        var highestCardValue = 0
        var highestMatchingCardPosition = -1
        var highestMatchingCardValue = 0
        
        for i in 0..<DeckController.EnemyHand.count {
            let cardValue = DeckController.EnemyHand[i].getValue()
            let cardType = DeckController.EnemyHand[i].getActionType()
            
            if cardValue > highestCardValue {
                highestCardValue = DeckController.EnemyHand[i].getValue()
                highestCardValuePosition = i
            }
            if cardValue > highestMatchingCardValue && VillainParagon.CurrentActionType == cardType {
                highestMatchingCardValue = DeckController.EnemyHand[i].getValue()
                highestMatchingCardPosition = i
                cardMatchingType = true
            }
        }
        
        if ((cardMatchingType) && (highestCardValue < (highestMatchingCardValue + 5))) {
            cardToPlayPosition = highestMatchingCardPosition
        } else {
            cardToPlayPosition = highestCardValuePosition
        }
        
        EnemyTotalAttackValue = EnemyTotalAttackValue + DeckController.EnemyHand[cardToPlayPosition].getValue()
        let _ = DeckController.enemyPlayCard(atPosition: cardToPlayPosition)
    }
    
    func determineEnemyAttackType() -> ActionType {
        var selectedType: ActionType = .none
        
        var highestCard = -1
        var highestStrengthCard = -1
        var highestAgilityCard = -1
        var highestIntellectCard = -1
        var highestWillpowerCard = -1
        for i in 0..<DeckController.EnemyHand.count {
            if DeckController.EnemyHand[i].getValue() > highestCard {
                highestCard = DeckController.EnemyHand[i].getValue()
            }
            switch DeckController.EnemyHand[i].getActionType() {
            case .strength:
                if DeckController.EnemyHand[i].getValue() > highestStrengthCard {
                    highestStrengthCard = DeckController.EnemyHand[i].getValue()
                }
            case .agility:
                if DeckController.EnemyHand[i].getValue() > highestAgilityCard {
                    highestAgilityCard = DeckController.EnemyHand[i].getValue()
                }
            case .intellect:
                if DeckController.EnemyHand[i].getValue() > highestIntellectCard {
                    highestIntellectCard = DeckController.EnemyHand[i].getValue()
                }
            case .willpower:
                if DeckController.EnemyHand[i].getValue() > highestWillpowerCard {
                    highestWillpowerCard = DeckController.EnemyHand[i].getValue()
                }
            default:
                break
            }
        }
        
        let boolStrength = VillainParagon.PossibleAttackTypeList.contains(.strength)
        let boolAgility = VillainParagon.PossibleAttackTypeList.contains(.agility)
        let boolIntellect = VillainParagon.PossibleAttackTypeList.contains(.intellect)
        let boolWillpower = VillainParagon.PossibleAttackTypeList.contains(.willpower)
        
        let strengthVal = VillainParagon.Strength + highestStrengthCard
        let agilityVal = VillainParagon.Agility + highestAgilityCard
        let intellectVal = VillainParagon.Intellect + highestIntellectCard
        let willpowerVal = VillainParagon.Willpower + highestWillpowerCard
        
        if boolStrength {
            if !((boolAgility && agilityVal > strengthVal) || (boolIntellect && intellectVal > strengthVal) || (boolWillpower && willpowerVal > strengthVal)) {
                selectedType = .strength
            }
        }
        if boolAgility {
            if !((boolStrength && strengthVal > agilityVal) || (boolIntellect && intellectVal > agilityVal) || (boolWillpower && willpowerVal > agilityVal)) {
                selectedType = .agility
            }
        }
        if boolIntellect {
            if !((boolStrength && strengthVal > intellectVal) || (boolAgility && agilityVal > intellectVal) || (boolWillpower && willpowerVal > intellectVal)) {
                selectedType = .intellect
            }
        }
        if boolWillpower {
            if !((boolStrength && strengthVal > willpowerVal) || (boolAgility && agilityVal > willpowerVal) || (boolIntellect && intellectVal > willpowerVal)) {
                selectedType = .willpower
            }
        }
        
        var useHighestCombination = true
        var highestCombination = -1
        var combinationType: ActionType = .none
        if boolStrength && (VillainParagon.Strength + highestCard > highestCombination) {
            highestCombination = VillainParagon.Strength + highestCard
            combinationType = .strength
        }
        if boolAgility && (VillainParagon.Agility + highestCard > highestCombination) {
            highestCombination = VillainParagon.Agility + highestCard
            combinationType = .agility
        }
        if boolIntellect && (VillainParagon.Intellect + highestCard > highestCombination) {
            highestCombination = VillainParagon.Intellect + highestCard
            combinationType = .intellect
        }
        if boolWillpower && (VillainParagon.Willpower + highestCard > highestCombination) {
            highestCombination = VillainParagon.Willpower + highestCard
            combinationType = .willpower
        }
        
        if boolStrength && (highestCombination < strengthVal + 5) {
            useHighestCombination = false
        }
        if boolAgility && (highestCombination < agilityVal + 5) {
            useHighestCombination = false
        }
        if boolIntellect && (highestCombination < intellectVal + 5) {
            useHighestCombination = false
        }
        if boolWillpower && (highestCombination < willpowerVal + 5) {
            useHighestCombination = false
        }
        
        if useHighestCombination {
            selectedType = combinationType
        }
        
        return selectedType
    }
    
    
    // MARK: - Enemy Play Functions
    func enemyPlayEdgeCards() -> Int {
        
        //If one card in had, cannot play Edge
        if DeckController.EnemyHand.count == 1 {
            return 0
        }
        
        //Gathers the positions of the Edge cards in enemy hand
        var playableEdgeCardPositions: [Int] = []
        for i in 0..<DeckController.EnemyHand.count {
            if DeckController.EnemyHand[i].getValue() <= VillainParagon.Edge {
                playableEdgeCardPositions.append(i)
            }
        }
        
        //If no edge cards available, cannot play Edge
        if playableEdgeCardPositions.count == 0 {
            return 0
        }
        
        //If all cards in Hand are Edge-Playable, decides the card to save for Action-Play
        if playableEdgeCardPositions.count == DeckController.EnemyHand.count {
            var largestValuePosition = -1
            var largestValue = 0
            var matchesType = false
            for i in 0..<playableEdgeCardPositions.count {
                if matchesType {
                    if DeckController.EnemyHand[playableEdgeCardPositions[i]].getActionType() == VillainParagon.CurrentActionType && DeckController.EnemyHand[playableEdgeCardPositions[i]].getValue() > largestValue {
                        largestValuePosition = i
                        largestValue = DeckController.EnemyHand[playableEdgeCardPositions[i]].getValue()
                    }
                } else {
                    if DeckController.EnemyHand[playableEdgeCardPositions[i]].getActionType() == VillainParagon.CurrentActionType {
                        matchesType = true
                        largestValuePosition = i
                        largestValue = DeckController.EnemyHand[playableEdgeCardPositions[i]].getValue()
                    } else if DeckController.EnemyHand[playableEdgeCardPositions[i]].getValue() > largestValue {
                        largestValuePosition = i
                        largestValue = DeckController.EnemyHand[playableEdgeCardPositions[i]].getValue()
                    }
                }
            }
            playableEdgeCardPositions.remove(at: largestValuePosition)
        }
        
        var matchingCardTypePositions: [Int] = []
        for i in 0..<DeckController.EnemyHand.count {
            if DeckController.EnemyHand[i].getActionType() == VillainParagon.CurrentActionType {
                matchingCardTypePositions.append(i)
            }
        }
        
        //Holds total value of played edge cards to return
        var playValueOfEdgeCards = 0
        
        //Checks for an edge card to hold for Play-Card if needed
        if matchingCardTypePositions.count == 1 {
            let valueOfCard = DeckController.EnemyHand[matchingCardTypePositions[0]].getValue()
            if valueOfCard <= VillainParagon.Edge {
                var betterCardToPlay = false
                for i in 0..<DeckController.EnemyHand.count {
                    if DeckController.EnemyHand[i].getValue() >= valueOfCard + 5 {
                        betterCardToPlay = true
                        break
                    }
                }
                if !betterCardToPlay {
                    playableEdgeCardPositions.removeAll { (intValue) -> Bool in
                        intValue == matchingCardTypePositions[0]
                    }
                }
            }
        } else if matchingCardTypePositions.count > 1 {
            var nonEdgeOfMatchingTypeExists = false
            for i in 0..<matchingCardTypePositions.count {
                if DeckController.EnemyHand[matchingCardTypePositions[i]].getValue() > VillainParagon.Edge {
                    nonEdgeOfMatchingTypeExists = true
                    break
                }
            }
            if !nonEdgeOfMatchingTypeExists {
                var largestValue = 0
                var largestValuePosition = -1
                for i in 0..<matchingCardTypePositions.count {
                    let nextValue = DeckController.EnemyHand[matchingCardTypePositions[i]].getValue()
                    if nextValue > largestValue {
                        largestValue = nextValue
                        largestValuePosition = i
                    }
                }
                var betterCardToPlay = false
                for i in 0..<DeckController.EnemyHand.count {
                    if DeckController.EnemyHand[i].getValue() >= largestValue + 5 {
                        betterCardToPlay = true
                        break
                    }
                }
                if !betterCardToPlay {
                    playableEdgeCardPositions.removeAll { (intValue) -> Bool in
                        intValue == matchingCardTypePositions[largestValuePosition]
                    }
                }
            }
        }
        
        playableEdgeCardPositions.sort()
        playableEdgeCardPositions.reverse()
        for i in 0..<playableEdgeCardPositions.count {
            playValueOfEdgeCards = playValueOfEdgeCards + DeckController.EnemyHand[playableEdgeCardPositions[i]].getValue()
            let _ = DeckController.enemyPlayCard(atPosition: playableEdgeCardPositions[i])
        }
        return playValueOfEdgeCards
    }
    
    
    // MARK: - Enemy Defense Functions
    func enemyAttemptToDodge() {
        if HeroParagon.CurrentActionType == .willpower {
            VillainParagon.CurrentActionType = .willpower
        } else {
            VillainParagon.CurrentActionType = .agility
        }
        
        var totalDodgeValue = 0
        if VillainParagon.CurrentActionType == .agility {
            totalDodgeValue = VillainParagon.Agility + VillainParagon.DodgeBonus
        } else {
            totalDodgeValue = VillainParagon.Willpower
        }
        let dodgeAmountNeeded = TotalPlayValue + 1 - totalDodgeValue
        
        addTextToLog(event: "\(VillainParagon.Name) Starting Dodge Value: (\(totalDodgeValue))")
        
        var canDodgeWithSingleCard = false
        var hasAgilityCard = false
        var hasGoodChance = false
        
        var lowestSuccessValue = 11
        var lowestSuccessCard = Card()
        var lowestHandValue = 11
        var lowestHandCard = Card()
        var highestMatchTypeValue = 0
        var highestMatchTypeCard = Card()
        var goodOptionCard = Card()
        
        for i in 0..<DeckController.EnemyHand.count {
            if DeckController.EnemyHand[i].getValue() < lowestHandValue {
                lowestHandValue = DeckController.EnemyHand[i].getValue()
                lowestHandCard = DeckController.EnemyHand[i]
            }
            if DeckController.EnemyHand[i].getValue() > highestMatchTypeValue && DeckController.EnemyHand[i].getActionType() == VillainParagon.CurrentActionType {
                hasAgilityCard = true
                highestMatchTypeValue = DeckController.EnemyHand[i].getValue()
                highestMatchTypeCard = DeckController.EnemyHand[i]
            }
            if DeckController.EnemyHand[i].getValue() > dodgeAmountNeeded && DeckController.EnemyHand[i].getValue() < lowestSuccessValue {
                canDodgeWithSingleCard = true
                lowestSuccessValue = DeckController.EnemyHand[i].getValue()
                lowestSuccessCard = DeckController.EnemyHand[i]
            }
            let checkValue = dodgeAmountNeeded - DeckController.EnemyHand[i].getValue()
            let safetyValue = 2 + (arc4random_uniform(1))
            if checkValue < safetyValue {
                hasGoodChance = true
                goodOptionCard = DeckController.EnemyHand[i]
            }
        }
        
        var enemyDodged = false
        var cardIndex = -1
        var playingCard: Card = Card()
        
        if canDodgeWithSingleCard {
            cardIndex = DeckController.EnemyHand.firstIndex(of: lowestSuccessCard)!
        } else if hasGoodChance {
            cardIndex = DeckController.EnemyHand.firstIndex(of: goodOptionCard)!
        } else if hasAgilityCard {
            cardIndex = DeckController.EnemyHand.firstIndex(of: highestMatchTypeCard)!
        } else {
            cardIndex = DeckController.EnemyHand.firstIndex(of: lowestHandCard)!
        }
        
        playingCard = DeckController.enemyPlayCard(atPosition: cardIndex)
        totalDodgeValue = totalDodgeValue + playCardAndReturnTotalValue(card: playingCard, type: VillainParagon.CurrentActionType)
        
        var opponentResistance = 0
        if HeroParagon.CurrentActionType == .willpower {
            opponentResistance = VillainParagon.Willpower + VillainParagon.WillpowerResistanceBonus
        } else {
            opponentResistance = VillainParagon.Strength + VillainParagon.DamageResistance
        }
        
        addTextToLog(event: "\(VillainParagon.Name) Dodge Value: (\(totalDodgeValue))")
        
        if totalDodgeValue > TotalPlayValue {
            enemyDodged = true
        } else {
            enemyDodged = false
        }
        
        if enemyDodged {
            addTextToLog(event: "\(VillainParagon.Name) Dodged! (\(totalDodgeValue))")
            DamageToEnemy = 0
        } else {
            calculatePlayerTotalDamage()
            addTextToLog(event: "\(HeroParagon.Name) Total Attack Damage: (\(TotalPlayValue))")
            addTextToLog(event: "\(VillainParagon.Name) Resistance: (\(opponentResistance))")
            
            DamageToEnemy = TotalPlayValue - opponentResistance
            let NoDamageToEnemy = DamageToEnemy <= 0
            if NoDamageToEnemy {
                addTextToLog(event: "\(VillainParagon.Name) Resisted The Damage!")
            } else {
                addTextToLog(event: "\(VillainParagon.Name) Hit For \(DamageToEnemy) Damage!")
            }
        }
    }
    

    // MARK: - Password Entry Functions
    func promptPasswordEntry(ParagonForPassword: ParagonOverseer) {
        PasswordViewController.ParagonForPassword = ParagonForPassword
        PasswordViewController.PromptType = .passwordTry
        PasswordViewController.runSetup()
        UIView.animate(withDuration: 0.4) {
            self.ContainerHolderView.alpha = 1.0
        }
    }
    
    func getPresentTransitionPlayerPasswords() -> CATransition {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromTop
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        return transition
    }
    
    
    // MARK: - Player Password Delegate Functions
    func CancelButtonPressed() {}
    func FightButtonPressed() {}
    func FightButtonWithoutPasswords() {}
    func PasswordsSet(passwordOne: String, passwordTwo: String) {}
    func EnterButtonPressed() {
        view.endEditing(true)
    }
    
    
    // MARK: - Hand Redraw Functions
    func redrawCards() {
        let cardsToDraw = HeroParagon.Handsize - DeckController.PlayerHand.count
        if cardsToDraw <= 0 {
            return
        }
        for _ in 1...cardsToDraw {
            DeckController.playerDrawCard()
        }
    }
    
    func redrawEnemyCards() {
        let cardsToDraw = VillainParagon.Handsize - DeckController.EnemyHand.count
        if cardsToDraw <= 0 {
            return
        }
        for _ in 1...cardsToDraw {
            DeckController.enemyDrawCard()
        }
    }
    
    
    // MARK: - Collection View Functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let handsize = DeckController.PlayerHand?.count {
            return handsize
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cardCell : CardCollectionViewCell = PlayerCardCollectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as! CardCollectionViewCell
        cardCell.setUpCardCell(value: DeckController.PlayerHand[indexPath.row].getValue(), type: DeckController.PlayerHand[indexPath.row].getActionType())
        cardCell.unhighlightCard()
        switch CurrentPhase {
        case .edgeAttack, .edgeDefend:
            if PlayerEdgeCardLocations.contains(indexPath.row) {
                cardCell.highlightCard()
            }
        case .cardSelectAttack, .cardSelectDefend:
            if PlayerCardSelectionLocation.contains(indexPath.row) {
                cardCell.highlightCard()
            }
        case .selectAttack, .enemyAttack, .damageToEnemy, .damageToHero, .none:
            break
        }
        return cardCell
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: PlayerCardWidth, height: PlayerCardHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch CurrentPhase {
        case .selectAttack, .damageToEnemy, .enemyAttack:
            return
        case .edgeAttack:
            if DeckController.PlayerHand[indexPath.row].getValue() <= HeroParagon.Edge {
                if !PlayerEdgeCardLocations.contains(indexPath.row) {
                    if PlayerEdgeCardLocations.count + 1 != DeckController.PlayerHand.count {
                        PlayerEdgeCardLocations.append(indexPath.row)
                        let thisCard: CardCollectionViewCell = PlayerCardCollectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
                        thisCard.highlightCard()
                    }
                } else {
                    PlayerEdgeCardLocations.removeAll { (nextInt) -> Bool in
                        nextInt == indexPath.row
                    }
                    let thisCard: CardCollectionViewCell = PlayerCardCollectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
                    thisCard.unhighlightCard()
                }
                
                setPlayCardsButtonText()
                var valueOfEdge: Int = 0
                for i in 0..<PlayerEdgeCardLocations.count {
                    valueOfEdge = valueOfEdge + DeckController.PlayerHand[PlayerEdgeCardLocations[i]].getValue()
                }
                let valueForLabel = TotalPlayValue + valueOfEdge
                TotalValueLabel.text = "\(valueForLabel)"
            }
        case .cardSelectAttack:
            if !PlayerCardSelectionLocation.contains(indexPath.row) {
                if(PlayerCardSelectionLocation.count != 0) {
                    let indexPathToCard = IndexPath(row: PlayerCardSelectionLocation[0], section: 0)
                    let thisCard: CardCollectionViewCell = PlayerCardCollectionView.cellForItem(at: indexPathToCard) as! CardCollectionViewCell
                    thisCard.unhighlightCard()
                    PlayerCardSelectionLocation.removeAll()
                }
                    
                PlayerCardSelectionLocation.append(indexPath.row)
                let thisCard: CardCollectionViewCell = PlayerCardCollectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
                thisCard.highlightCard()
                
                let valueForLabel = TotalPlayValue + DeckController.PlayerHand[indexPath.row].getValue()
                if DeckController.PlayerHand[indexPath.row].getActionType() == HeroParagon.CurrentActionType {
                    TotalValueLabel.text = "\(valueForLabel)+"
                } else {
                    TotalValueLabel.text = "\(valueForLabel)"
                }
            } else {
                PlayerCardSelectionLocation.removeAll()
                let thisCard: CardCollectionViewCell = PlayerCardCollectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
                thisCard.unhighlightCard()
                updateTotalLabel()
            }
            setPlayCardsButtonText()
        case .edgeDefend:
            if DeckController.PlayerHand[indexPath.row].getValue() <= HeroParagon.Edge {
                if !PlayerEdgeCardLocations.contains(indexPath.row) {
                    if PlayerEdgeCardLocations.count + 1 != DeckController.PlayerHand.count {
                        PlayerEdgeCardLocations.append(indexPath.row)
                        let thisCard: CardCollectionViewCell = PlayerCardCollectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
                        thisCard.highlightCard()
                    }
                } else {
                    PlayerEdgeCardLocations.removeAll { (nextInt) -> Bool in
                        nextInt == indexPath.row
                    }
                    let thisCard: CardCollectionViewCell = PlayerCardCollectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
                    thisCard.unhighlightCard()
                }
                
                setPlayCardsButtonText()
                var valueOfEdge: Int = 0
                for i in 0..<PlayerEdgeCardLocations.count {
                    valueOfEdge = valueOfEdge + DeckController.PlayerHand[PlayerEdgeCardLocations[i]].getValue()
                }
                let valueForLabel = TotalPlayValue + valueOfEdge
                TotalValueLabel.text = "\(valueForLabel)"
            }
        case .cardSelectDefend:
            if !PlayerCardSelectionLocation.contains(indexPath.row) {
                if(PlayerCardSelectionLocation.count != 0) {
                    let indexPathToCard = IndexPath(row: PlayerCardSelectionLocation[0], section: 0)
                    let thisCard: CardCollectionViewCell = PlayerCardCollectionView.cellForItem(at: indexPathToCard) as! CardCollectionViewCell
                    thisCard.unhighlightCard()
                    PlayerCardSelectionLocation.removeAll()
                }
                
                PlayerCardSelectionLocation.append(indexPath.row)
                let thisCard: CardCollectionViewCell = PlayerCardCollectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
                thisCard.highlightCard()
                
                let valueForLabel = TotalPlayValue + DeckController.PlayerHand[indexPath.row].getValue()
                if DeckController.PlayerHand[indexPath.row].getActionType() == HeroParagon.CurrentActionType {
                    TotalValueLabel.text = "\(valueForLabel)+"
                } else {
                    TotalValueLabel.text = "\(valueForLabel)"
                }
            } else {
                PlayerCardSelectionLocation.removeAll()
                let thisCard: CardCollectionViewCell = PlayerCardCollectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
                thisCard.unhighlightCard()
                updateTotalLabel()
            }
            setPlayCardsButtonText()
        case .damageToHero:
            if !PlayerCardSelectionLocation.contains(indexPath.row) {
                if !(DamageToHero - getTotalValueOfSelectedCards() <= 0) {
                    PlayerCardSelectionLocation.append(indexPath.row)
                    let thisCard: CardCollectionViewCell = PlayerCardCollectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
                    thisCard.highlightCard()
                }
            } else {
                PlayerCardSelectionLocation.removeAll { (intValue) -> Bool in
                    intValue == indexPath.row
                }
                let thisCard: CardCollectionViewCell = PlayerCardCollectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
                thisCard.unhighlightCard()
            }
            setPlayCardsButtonText()
            let valueForText = DamageToHero - getTotalValueOfSelectedCards()
            TotalValueLabel.text = "\(valueForText)"
        case .none:
            return
        }
    }
    
    // MARK: - Picker View Functions
    func reloadActionLog() {
        ActionLogPickerView.reloadAllComponents()
    }
    
    func addTextToLog(event: String) {
        if event != "" {
            PickerActionLog.append(event)
            reloadActionLog()
            let row = 0
            ActionLogPickerView.selectRow(row, inComponent: 0, animated: true)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return PickerActionLog.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var copyOfLogs = PickerActionLog
        copyOfLogs.reverse()
        
        let pickerLabel = UILabel()
        pickerLabel.backgroundColor = UIColor.clear
        let titleData = copyOfLogs[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: LogFontSize),NSAttributedString.Key.foregroundColor:UIColor.white])
        pickerLabel.attributedText = myTitle
        pickerLabel.textAlignment = .center
        return pickerLabel
    }
    
    
    // MARK: - Paragon Functions
    func performParagonPowers(paragon: ParagonOverseer) {
        if paragon.Name == HeroParagon.Name {
            paragon.performAbilityPower()
            redrawCards()
        } else {
            paragon.performAbilityPower()
            redrawEnemyCards()
        }
        addTextToLog(event: paragon.ParagonAbilityPowerText)
        setUpCharacterSheetViews()
    }
    
    func paragonWillpowerRevived(paragon: ParagonOverseer) -> Bool {
        let reviveThresholdValue: Int = 10 * (reviveIncreaseConstant * paragon.ReviveAttemptCount)
        let reviveAttempt: Int = paragon.Willpower + DeckController.drawCardAndPlay().getValue()
        let WillRevive = PlayWithRevives && (reviveAttempt >= reviveThresholdValue)
        
        if WillRevive {
            addTextToLog(event: "\(paragon.Name) stabalized with willpower! (\(reviveAttempt))")
            paragon.ReviveAttemptCount = paragon.ReviveAttemptCount + 1
        } else {
            addTextToLog(event: "\(paragon.Name) unable to stabalize. (\(reviveAttempt))")
        }
        
        return WillRevive
    }
    
    // MARK: - Miscellaneous UI Functions
    func setActionIndicatorColor() {
        if CurrentGameType == .eve {
            ActionTypeColorView.backgroundColor = ColorUtilities.BlackDoom
        } else {
            switch HeroParagon.CurrentActionType {
            case .agility:
                ActionTypeColorView.backgroundColor = ColorUtilities.RedAgility
            case .strength:
                ActionTypeColorView.backgroundColor = ColorUtilities.GreenStrength
            case .intellect:
                ActionTypeColorView.backgroundColor = ColorUtilities.BlueIntellect
            case .willpower:
                ActionTypeColorView.backgroundColor = ColorUtilities.PurpleWillpower
            default:
                ActionTypeColorView.backgroundColor = ColorUtilities.BlackDoom
            }
        }
    }
    
    func setPickerLineColors() {
        for subview in self.ActionLogPickerView.subviews {
            
            if subview.frame.height <= 5 {
                subview.backgroundColor = UIColor.white
                subview.tintColor = UIColor.white
                subview.layer.borderColor = UIColor.white.cgColor
                subview.layer.borderWidth = 2            }
        }
    }
    
    func showOrHideActionSelectorView() {
        if ActionSelectorView.alpha == 0.0 {
            UIView.animate(withDuration: 0.5) {
                self.ActionSelectorView.alpha = 1.0
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                self.ActionSelectorView.alpha = 0.0
            }
        }
    }
    
    func showOrHideCardsView() {
        CollectionViewIsDisplayed = !CollectionViewIsDisplayed
        if CollectionViewIsDisplayed {
            CollectionViewBottomConstraint.constant = 0
        } else {
            CollectionViewBottomConstraint.constant = NewCollectionConstraintConstant
        }
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - Setup Functions
    func setUpEntryTaunts() {
        HeroTauntView.alpha = 1.0
        HeroTauntView.layer.cornerRadius = 4.0
        HeroTauntView.layer.masksToBounds = true
        VillainTauntView.alpha = 1.0
        VillainTauntView.layer.cornerRadius = 4.0
        VillainTauntView.layer.masksToBounds = true
        VillainTauntBackgroundView.backgroundColor = backgroundColor
        HeroTauntBackgroundView.backgroundColor = backgroundColor
        VillainTauntLabel.textColor = characterSheetTextColor
        VillainTauntLabel.font = UIFont(name: tauntLabelFont, size: tauntLabelFontSize)
        HeroTauntLabel.textColor = characterSheetTextColor
        HeroTauntLabel.font = UIFont(name: tauntLabelFont, size: tauntLabelFontSize)
        VillainTauntLabel.text = VillainParagon.EntryTaunt
        HeroTauntLabel.text = HeroParagon.EntryTaunt
        DispatchQueue.main.asyncAfter(deadline: .now() + tauntDuration) {
            UIView.animate(withDuration: 0.3) {
                self.HeroTauntView.alpha = 0.0
                self.VillainTauntView.alpha = 0.0
                self.HeroImageBackgroundView.alpha = self.backgroundAlpha
                self.VillainImageBackgroundView.alpha = self.backgroundAlpha
            }
        }
    }
    
    func setUpAttackOptions() {
        setUpSelectorButtonUI()
        if HeroParagon.PossibleAttackTypeList.contains(.strength) {
            StrengthSelectorButton.alpha = 1.0
            StrengthSelectorLabelsView.alpha = 1.0
            StrengthAttackNameLabel.text = HeroParagon.AttackTypeNames[0]
            StrengthAttackValueLabel.alpha = 1.0
            StrengthAttackValueLabel.text = "Attack: \(HeroParagon.AttackValues[0])"
            if HeroParagon.DamageBonuses[indexStr] > 0 {
                StrengthBonusDamageLabel.alpha = 1.0
                StrengthBonusDamageLabel.text = "Damage: +\(HeroParagon.DamageBonuses[indexStr])"
            } else {
                StrengthBonusDamageLabel.alpha = 0.0
                StrengthBonusDamageLabel.text = "Damage: +\(HeroParagon.DamageBonuses[indexStr])"
            }
        } else {
            StrengthSelectorButton.alpha = 0.0
            StrengthSelectorLabelsView.alpha = 0.0
        }
        
        if HeroParagon.PossibleAttackTypeList.contains(.agility) {
            AgilitySelectorButton.alpha = 1.0
            AgilitySelectorLabelsView.alpha = 1.0
            AgilityAttackNameLabel.text = HeroParagon.AttackTypeNames[1]
            AgilityAttackValueLabel.alpha = 1.0
            AgilityAttackValueLabel.text = "Attack: \(HeroParagon.AttackValues[1])"
            if HeroParagon.DamageBonuses[indexAgi] > 0 {
                AgilityBonusDamageLabel.alpha = 1.0
                AgilityBonusDamageLabel.text = "Damage: +\(HeroParagon.DamageBonuses[indexAgi])"
            } else {
                AgilityBonusDamageLabel.alpha = 0.0
                AgilityBonusDamageLabel.text = "Damage: +\(HeroParagon.DamageBonuses[indexAgi])"
            }
        } else {
            AgilitySelectorButton.alpha = 0.0
            AgilitySelectorLabelsView.alpha = 0.0
        }
        
        if HeroParagon.PossibleAttackTypeList.contains(.intellect) {
            IntellectSelectorButton.alpha = 1.0
            IntellectSelectorLabelsView.alpha = 1.0
            IntellectAttackNameLabel.text = HeroParagon.AttackTypeNames[2]
            IntellectAttackValueLabel.alpha = 1.0
            IntellectAttackValueLabel.text = "Attack: \(HeroParagon.AttackValues[2])"
            if HeroParagon.DamageBonuses[indexInt] > 0 {
                IntellectBonusDamageLabel.alpha = 1.0
                IntellectBonusDamageLabel.text = "Damage: +\(HeroParagon.DamageBonuses[indexInt])"
            } else {
                IntellectBonusDamageLabel.alpha = 0.0
                IntellectBonusDamageLabel.text = "Damage: +\(HeroParagon.DamageBonuses[indexInt])"
            }
        } else {
            IntellectSelectorButton.alpha = 0.0
            IntellectSelectorLabelsView.alpha = 0.0
        }
        
        if HeroParagon.PossibleAttackTypeList.contains(.willpower) {
            WillpowerSelectorButton.alpha = 1.0
            WillpowerSelectorLabelsView.alpha = 1.0
            WillpowerAttackNameLabel.text = HeroParagon.AttackTypeNames[3]
            WillpowerAttackValueLabel.alpha = 1.0
            WillpowerAttackValueLabel.text = "Attack: \(HeroParagon.AttackValues[3])"
            if HeroParagon.DamageBonuses[indexWil] > 0 {
                WillpowerBonusDamageLabel.alpha = 1.0
                WillpowerBonusDamageLabel.text = "Damage: +\(HeroParagon.DamageBonuses[indexWil])"
            } else {
                WillpowerBonusDamageLabel.alpha = 0.0
                WillpowerBonusDamageLabel.text = "Damage: +\(HeroParagon.DamageBonuses[indexWil])"
            }
        } else {
            WillpowerSelectorButton.alpha = 0.0
            WillpowerSelectorLabelsView.alpha = 0.0
        }
    }
    
    func setUpSelectorButtonUI() {
        ActionSelectorBackgroundView.backgroundColor = ColorUtilities.hexUIColor(hex: "EAE3EB")
        StrengthSelectorButton.layer.cornerRadius = 5.0
        StrengthSelectorButton.layer.masksToBounds = true
        
        StrengthSelectorButton.backgroundColor = UIColor.clear
        StrengthSelectorLabelsView.backgroundColor = ColorUtilities.GreenStrength
        StrengthSelectorLabelsView.layer.cornerRadius = 5.0
        StrengthSelectorLabelsView.layer.masksToBounds = true
        StrengthShadowView.backgroundColor = UIColor.black
        StrengthShadowView.alpha = shadowAlpha
        StrengthShadowView.layer.cornerRadius = 4.0
        StrengthShadowView.layer.masksToBounds = true
        
        AgilitySelectorButton.layer.cornerRadius = 5.0
        AgilitySelectorButton.layer.masksToBounds = true
        AgilitySelectorButton.backgroundColor = UIColor.clear
        AgilitySelectorLabelsView.backgroundColor = ColorUtilities.RedAgility
        AgilitySelectorLabelsView.layer.cornerRadius = 5.0
        AgilitySelectorLabelsView.layer.masksToBounds = true
        AgilityShadowView.backgroundColor = UIColor.black
        AgilityShadowView.alpha = shadowAlpha
        AgilityShadowView.layer.cornerRadius = 4.0
        AgilityShadowView.layer.masksToBounds = true
        
        IntellectSelectorButton.layer.cornerRadius = 5.0
        IntellectSelectorButton.layer.masksToBounds = true
        IntellectSelectorButton.backgroundColor = UIColor.clear
        IntellectSelectorLabelsView.backgroundColor = ColorUtilities.BlueIntellect
        IntellectSelectorLabelsView.layer.cornerRadius = 5.0
        IntellectSelectorLabelsView.layer.masksToBounds = true
        IntellectShadowView.backgroundColor = UIColor.black
        IntellectShadowView.alpha = shadowAlpha
        IntellectShadowView.layer.cornerRadius = 4.0
        IntellectShadowView.layer.masksToBounds = true
        
        WillpowerSelectorButton.layer.cornerRadius = 5.0
        WillpowerSelectorButton.layer.masksToBounds = true
        WillpowerSelectorButton.backgroundColor = UIColor.clear
        WillpowerSelectorLabelsView.backgroundColor = ColorUtilities.PurpleWillpower
        WillpowerSelectorLabelsView.layer.cornerRadius = 5.0
        WillpowerSelectorLabelsView.layer.masksToBounds = true
        WillpowerShadowView.backgroundColor = UIColor.black
        WillpowerShadowView.alpha = shadowAlpha
        WillpowerShadowView.layer.cornerRadius = 4.0
        WillpowerShadowView.layer.masksToBounds = true
    }
    
    func determineInitiative() {
        if CurrentGameType == .pve {
            if HeroParagon.Agility >= VillainParagon.Agility {
                CurrentPhase = .selectAttack
                HeroAttacking = true
            } else {
                CurrentPhase = .enemyAttack
                HeroAttacking = false
            }
        } else if CurrentGameType == .pvp {
            if HeroParagon.Agility >= VillainParagon.Agility {
                CurrentPhase = .selectAttack
                HeroAttacking = true
            } else {
                CurrentPhase = .selectAttack
                HeroAttacking = true
                swapParagonSides()
            }
        } else if CurrentGameType == .eve {
            if HeroParagon.Agility >= VillainParagon.Agility {
                swapParagonSides()
            }
            CurrentPhase = .enemyAttack
            FirstSwap = true
            HeroAttacking = false
        }
        HeroParagon.CurrentActionType = .doom
        setActionIndicatorColor()
    }
    
    func getPlayType() {
        PlayType = HeroParagon.CurrentActionType
    }
    
    func setUpCardsButtonView() {
        CardHandHolderView.layer.cornerRadius = 4.0
        CardHandHolderView.layer.masksToBounds = true
        CardHandImageView.layer.cornerRadius = 4.0
        CardHandImageView.layer.masksToBounds = true
        
        CardHandImageView.image = CardHandImageView.image!.withRenderingMode(.alwaysTemplate)
        CardHandImageView.tintColor = UIColor.white
        
        CardHandBackgroundView.backgroundColor = ColorUtilities.hexUIColor(hex: "84d1ef")
    }
    
    func setUpHiddenViewPositions() {
        let halfHeight = ScreenHeight / 2
        NewCollectionConstraintConstant = -1 * halfHeight
        CollectionViewBottomConstraint.constant = NewCollectionConstraintConstant
        ActionSelectionViewBottomConstraint.constant = NewCollectionConstraintConstant
        self.view.layoutIfNeeded()
    }
    
    func setUpHolderViews() {
        ActionLogsHolderView.layer.cornerRadius = 4.0
        ActionLogsHolderView.layer.masksToBounds = true
        CardPlayHolderView.layer.cornerRadius = 4.0
        CardPlayHolderView.layer.masksToBounds = true
    }
    
    func setUpActionTypeIndicatorFrame() {
        ActionTypeFrameView.layer.cornerRadius = 4.0
        ActionTypeValueView.layer.cornerRadius = 4.0
        ActionTypeColorView.layer.cornerRadius = 4.0
        ActionTypeFrameView.layer.masksToBounds = true
        ActionTypeValueView.layer.masksToBounds = true
        ActionTypeColorView.layer.masksToBounds = true
        setActionIndicatorColor()
    }
    
    func setInitialAttackType() {
        InitialAttackType = HeroParagon.CurrentActionType
    }
    
    func setPlayCardsButtonUI() {
        PlayCardsButton.layer.borderColor = UIColor.white.cgColor
        PlayCardsButton.layer.borderWidth = 2
        PlayCardsButton.layer.cornerRadius = 5.0
        PlayCardsButton.layer.masksToBounds = true
    }
    
    func setPlayCardsButtonText() {
        PlayCardsButton.titleLabel?.adjustsFontSizeToFitWidth = true
        switch CurrentPhase {
        case .selectAttack:
            PlayCardsButton.setTitleColor(ColorUtilities.hexUIColor(hex: "84d1ef"), for: .normal)
            PlayCardsButton.setTitle("Select an Attack Type", for: .normal)
        case .edgeAttack:
            PlayCardsButton.setTitleColor(UIColor.white, for: .normal)
            if PlayerEdgeCardLocations.count == 0 {
                PlayCardsButton.setTitle("Skip Edge Cards", for: .normal)
            } else {
                PlayCardsButton.setTitle("Play Cards (\(PlayerEdgeCardLocations.count))", for: .normal)
            }
        case .cardSelectAttack:
            PlayCardsButton.setTitleColor(UIColor.white, for: .normal)
            if PlayerCardSelectionLocation.count == 0 {
                PlayCardsButton.setTitle("Select Card", for: .normal)
            } else {
                PlayCardsButton.setTitle("Play Card", for: .normal)
            }
        case .damageToEnemy:
            PlayCardsButton.setTitleColor(UIColor.white, for: .normal)
            PlayCardsButton.setTitle("Next", for: .normal)
        case .enemyAttack:
            PlayCardsButton.setTitleColor(UIColor.white, for: .normal)
            PlayCardsButton.setTitle("Next", for: .normal)
        case .edgeDefend:
            PlayCardsButton.setTitleColor(UIColor.white, for: .normal)
            if PlayerEdgeCardLocations.count == 0 {
                PlayCardsButton.setTitle("Skip Edge Cards", for: .normal)
            } else {
                PlayCardsButton.setTitle("Play Cards (\(PlayerEdgeCardLocations.count))", for: .normal)
            }
        case .cardSelectDefend:
            PlayCardsButton.setTitleColor(UIColor.white, for: .normal)
            if PlayerCardSelectionLocation.count == 0 {
                PlayCardsButton.setTitle("Select Card", for: .normal)
            } else {
                PlayCardsButton.setTitle("Play Card", for: .normal)
            }
        case .damageToHero:
            PlayCardsButton.setTitleColor(UIColor.white, for: .normal)
            if PlayerCardSelectionLocation.count == 0 {
                PlayCardsButton.setTitle("Select Cards for Damage", for: .normal)
            } else {
                PlayCardsButton.setTitle("Pay Cards (\(PlayerCardSelectionLocation.count))", for: .normal)
            }
        case .none:
            PlayCardsButton.setTitleColor(UIColor.white, for: .normal)
            PlayCardsButton.setTitle("Finish Combat", for: .normal)
        }
    }
    
    
    func setUpDamgedViews() {
        HeroDamagedView.alpha = 0.0
        HeroDamagedView.backgroundColor = UIColor.red
        VillainDamagedView.alpha = 0.0
        VillainDamagedView.backgroundColor = UIColor.red
        
        let damageStringTextAttributes = [NSAttributedString.Key.strokeColor : UIColor.red, NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.strokeWidth : -6.0, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 40)] as [NSAttributedString.Key : Any]
        HeroDamageReceivedLabel.attributedText = NSMutableAttributedString(string: "", attributes: damageStringTextAttributes)
        VillainDamageReceivedLabel.attributedText = NSMutableAttributedString(string: "", attributes: damageStringTextAttributes)
        HeroDamageReceivedYConstraint.constant = 40
        VillainDamageReceivedYConstraint.constant = 40
        HeroDamageReceivedLabel.alpha = 0.0
        VillainDamageReceivedLabel.alpha = 0.0
    }
    
    
    func setUpCombatBackgroundImageView() {
        CombatBackgroundImageView.image = UIImage(named: ImageUtilities.selectBackgroundImageView())
    }
    
    
    func setPhaseLabelValue() {
        switch CurrentPhase {
        case .selectAttack:
            PhaseLabel.text = "Phase: Select Attack"
        case .edgeAttack:
            PhaseLabel.text = "Phase: Edge - Attack"
        case .cardSelectAttack:
            PhaseLabel.text = "Phase: Card Select - Attack"
        case .damageToEnemy:
            if CurrentGameType == .eve {
                PhaseLabel.text = "Phase: Paragon Damaged!"
            } else {
                PhaseLabel.text = "Phase: Damaging Enemy"
            }
        case .enemyAttack:
            if CurrentGameType == .eve {
                PhaseLabel.text = "Phase: Brawling!"
            } else {
                PhaseLabel.text = "Phase: Enemy Attack"
            }
        case .edgeDefend:
            PhaseLabel.text = "Phase: Edge - Defense"
        case .cardSelectDefend:
            PhaseLabel.text = "Phase: Card Select - Defense"
        case .damageToHero:
            PhaseLabel.text = "Phase: Damage to Hero"
        case .none:
            PhaseLabel.text = "Combat Complete!"
        }
    }
    
    func setupCardSizeUI() {
        PlayerCardHeight = PlayerCardCollectionView.frame.height * 0.6
        PlayerCardWidth = PlayerCardHeight / 1.75
    }
    
    func updateTotalLabel() {
        if CurrentGameType == .eve || CurrentPhase == .selectAttack || CurrentPhase == .enemyAttack {
            TotalValueLabel.text = "-"
        } else {
            TotalValueLabel.text = String(TotalPlayValue)
        }
    }
    
    func resetTotalPlayValue() {
        TotalPlayValue = 0
    }
    
    func setHeroDefenseActionType() {
        if CurrentPhase == .edgeDefend || CurrentPhase == .cardSelectDefend {
            if VillainParagon.CurrentActionType == .willpower {
                HeroParagon.CurrentActionType = .willpower
            } else {
                HeroParagon.CurrentActionType = .agility
            }
        }
        setActionIndicatorColor()
    }
    
    func setInitialActionSelectorViewPosition() {
        if CurrentPhase == .selectAttack {
            ActionSelectionViewIsDisplayed = true
            ActionSelectionViewBottomConstraint.constant = 0
        } else {
            ActionSelectionViewIsDisplayed = false
            ActionSelectionViewBottomConstraint.constant = NewCollectionConstraintConstant
        }
        self.view.layoutIfNeeded()
    }
    
    func setUpBackgroundViews() {
        HeroStatsBackgroundView.backgroundColor = backgroundColor
        HeroStatsBackgroundView.alpha = backgroundAlpha
        HeroImageBackgroundView.backgroundColor = backgroundColor
        HeroImageBackgroundView.alpha = 1.0
        VillainStatsBackgroundView.backgroundColor = backgroundColor
        VillainStatsBackgroundView.alpha = backgroundAlpha
        VillainImageBackgroundView.backgroundColor = backgroundColor
        VillainImageBackgroundView.alpha = 1.0
    }
    
    func setUpContainerView() {
        ContainerHolderView.alpha = 0.0
        PasswordPromptContainerView.layer.cornerRadius = 6.0
        PasswordPromptContainerView.layer.masksToBounds = true
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newPlayerPasswordsViewController = storyBoard.instantiateViewController(withIdentifier: "PlayerPasswordsViewController") as! PlayerPasswordsViewController
        newPlayerPasswordsViewController.delegate = self
        newPlayerPasswordsViewController.PromptType = .passwordTry
        
        PasswordViewController = newPlayerPasswordsViewController
        
        PasswordViewController.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        PasswordViewController.view.frame = PasswordPromptContainerView.bounds
        PasswordPromptContainerView.addSubview(PasswordViewController.view)
        
        PasswordViewController.PasswordAttemptTextfield.delegate = self
    }
    
    
    // MARK: - Textfield Functions
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 3
    }
    
    
    // MARK: - Objc Functions
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - Extensions
extension UILabel {
    func fixPickerLabelMargins(margin: CGFloat = 10, _ leftMarginOnly: Bool = true) {
            if let textString = self.text {
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.firstLineHeadIndent = margin
                paragraphStyle.headIndent = margin
                if !leftMarginOnly {
                    paragraphStyle.tailIndent = -margin
                }
                let attributedString = NSMutableAttributedString(string: textString)
                attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
                attributedText = attributedString
            }
        }
}
