//
//  CombatViewController.swift
//  Haymaker
//
//  Created by Mitchell Taitano on 11/13/18.
//  Copyright © 2018 Mitchell Taitano. All rights reserved.
//

import UIKit

class HeroSelectController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    enum PlayerType {
        case Player
        case Computer
    }
    
    // MARK: - IBOutlet Variables
    @IBOutlet weak var SelectedHeroImageView: UIImageView!
    @IBOutlet weak var SelectedOpponentImageView: UIImageView!
    @IBOutlet weak var LeftPlayerTypeButton: UIButton!
    @IBOutlet weak var RightPlayerTypeButton: UIButton!
    @IBOutlet weak var SelectedParagonsBackgroundView: UIView!
    @IBOutlet weak var HeroesCollectionView: UICollectionView!
    @IBOutlet weak var HeroesCollectionBackgroundView: UIView!
    @IBOutlet weak var OpponentsCollectionView: UICollectionView!
    @IBOutlet weak var OpponentsCollectionBackgroundView: UIView!
    @IBOutlet weak var BeginCombatBackgroundView: UIView!
    @IBOutlet weak var BeginCombatButton: UIButton!
    @IBOutlet weak var VersusTextLabel: UILabel!
    
    // MARK: - Player Hero
    var HeroParagon: ParagonOverseer = ParagonOverseer()
    var VillainParagon: ParagonOverseer = ParagonOverseer()
    
    // MARK: - Variables
    var NumberOfParagons: Int = 30
    var ParagonChoices: [ParagonOverseer] = []
    var OpponentChoices: [ParagonOverseer] = []
    var DeckController: DeckOverseer!
    var CurrentPlayerHandSize: Int = 0
    var CurrentEnemyHandSize: Int = 0
    
    // MARK: - Runtime Variables
    var UpdatingSelection: Bool = false
    var SelectedHero: ParagonOverseer = ParagonOverseer()
    var SelectedOpponent: ParagonOverseer = ParagonOverseer()
    var LeftPlayerType: PlayerType = .Player
    var RightPlayerType: PlayerType = .Computer
    
    
    // MARK: - Loading Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initialSetup()
    }
    
    
    // MARK: - Setup Functions
    func initialSetup() {
        setUpUI()
        setupDeck()
        setUpCharactersList()
        setUpParagons()
    }
    
    func setupDeck() {
        DeckController = DeckOverseer()
        DeckController.prepareDeck()
        DeckController.prepareHand()
    }
    
    func setUpCharactersList() {
        setUpParagonsList()
        setUpOppoentsList()
    }
    
    func setUpParagonsList() {
        ParagonChoices = listOfCharacaters()
    }
    
    func setUpOppoentsList() {
        OpponentChoices = listOfCharacaters()
    }
    
    func listOfCharacaters() -> [ParagonOverseer] {
        var availableCharaters: [ParagonOverseer] = []
        availableCharaters = listOfHeroes(characterList: availableCharaters)
        availableCharaters = listOfVillains(characterList: availableCharaters)
        availableCharaters = listOfHenchmen(characterList: availableCharaters)
        return availableCharaters
    }
    
    func listOfHeroes(characterList: [ParagonOverseer]) -> [ParagonOverseer]{
        let generator = HeroGenerator()
        var list = characterList
        for i in 0..<generator.numberOfHeroes {
            switch i {
            case 0:
                list.append(generator.captainAmerica())
            case 1:
                list.append(generator.daredevil())
            case 2:
                list.append(generator.doctorStrange())
            case 3:
                list.append(generator.hulk())
            case 4:
                list.append(generator.humanTorch())
            case 5:
                list.append(generator.invisibleWoman())
            case 6:
                list.append(generator.ironMan())
            case 7:
                list.append(generator.misterFantastic())
            case 8:
                list.append(generator.nightcrawler())
            case 9:
                list.append(generator.silverSurfer())
            case 10:
                list.append(generator.spiderman())
            case 11:
                list.append(generator.theThing())
            case 12:
                list.append(generator.thor())
            case 13:
                list.append(generator.wolverine())
            case 14:
                list.append(generator.blackPanther())
            default:
                break
            }
        }
        return list
    }
    
    func listOfVillains(characterList: [ParagonOverseer]) -> [ParagonOverseer] {
        let generator = EnemyGenerator()
        var list = characterList
        for i in 0..<generator.numberOfVillains {
            switch i {
            case 0:
                list.append(generator.annihilus())
            case 1:
                list.append(generator.drDoom())
            case 2:
                list.append(generator.galactus())
            case 3:
                list.append(generator.juggernaut())
            case 4:
                list.append(generator.loki())
            case 5:
                list.append(generator.magneto())
            case 6:
                list.append(generator.rhino())
            case 7:
                list.append(generator.sabertooth())
            case 8:
                list.append(generator.superSkrull())
            case 9:
                list.append(generator.thanos())
            case 10:
                list.append(generator.ultron())
            case 11:
                list.append(generator.venom())
            default:
                break
            }
        }
        return list
    }
    
    func listOfHenchmen(characterList: [ParagonOverseer]) -> [ParagonOverseer] {
        let generator = EnemyGenerator()
        var list = characterList
        for i in 0..<generator.numberOfHenchmen {
            switch i {
            case 0:
                list.append(generator.thug())
            case 1:
                list.append(generator.brute())
            case 2:
                list.append(generator.ninja())
            default:
                break
            }
        }
        return list
    }
    
    func setUpParagons() {
        selectRandomInitialParagons()
    }
    
    func selectRandomInitialParagons() {
        selectRandomInitialHeroParagon()
        selectRandomInitialOpponentParagon()
    }
    
    func selectRandomInitialHeroParagon() {
        let randomParagon = Int.random(in: 0..<ParagonChoices.count)
        SelectedHero = ParagonChoices[randomParagon]
        updateSelectedParagonImageView()
    }
    
    func selectRandomInitialOpponentParagon() {
        let randomParagon = Int.random(in: 0..<OpponentChoices.count)
        SelectedOpponent = OpponentChoices[randomParagon]
        updateSelectedOpponectImageView()
    }
    
    func setUpUI() {
        setUpBeginCombatButtonUI()
        setUpCollectionViewUI()
        setUpParagonSelectionUI()
        setUpPlayerTypeButtonUI()
    }
    
    func setUpBeginCombatButtonUI() {
        BeginCombatButton.layer.cornerRadius = 5.0
        BeginCombatButton.layer.masksToBounds = true
        BeginCombatButton.setTitle("", for: .normal)
        BeginCombatButton.backgroundColor = UIColor.clear
        BeginCombatBackgroundView.backgroundColor = UIColor.white
    }
    
    func setUpCollectionViewUI() {
        HeroesCollectionBackgroundView.backgroundColor = UIColor.white
        OpponentsCollectionView.backgroundColor = UIColor.white
    }
    
    func setUpParagonSelectionUI() {
        VersusTextLabel.textColor = UIColor.black
        VersusTextLabel.font = UIFont(name: "ComicZineOT", size: 55)
        SelectedHeroImageView.layer.cornerRadius = 5.0
        SelectedHeroImageView.layer.masksToBounds = true
        SelectedOpponentImageView.layer.cornerRadius = 5.0
        SelectedOpponentImageView.layer.masksToBounds = true
        SelectedParagonsBackgroundView.backgroundColor = UIColor.white
    }
    
    func setUpPlayerTypeButtonUI() {
        LeftPlayerType = .Player
        RightPlayerType = .Computer

        LeftPlayerTypeButton.setBackgroundImage(UIImage(named: "Icon_Player2"), for: .normal)
        RightPlayerTypeButton.setBackgroundImage(UIImage(named: "Icon_Computer2"), for: .normal)
        LeftPlayerTypeButton.imageView!.tintColor = UIColor.black
        RightPlayerTypeButton.imageView!.tintColor = UIColor.black
    }
    
    
    // MARK: - Transition Functions
    func showCardSelectionWindow() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var newCombatViewController = storyBoard.instantiateViewController(withIdentifier: "CombatViewController") as! CombatViewController
        newCombatViewController.HeroParagon = HeroParagon
        newCombatViewController.VillainParagon = VillainParagon
        newCombatViewController.DeckController = DeckController
        newCombatViewController.ScreenHeight = self.view.frame.height
        newCombatViewController.CurrentGameType = determineGameType()
        newCombatViewController = swapParagonsIfNeeded(GameViewController: newCombatViewController)
        let transition = getPresentTransition()
        view.window!.layer.add(transition, forKey: kCATransition)
        self.present(newCombatViewController, animated: false, completion: nil)
    }
    
    func getPresentTransition() -> CATransition {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        return transition
    }
    
    func swapParagonsIfNeeded(GameViewController: CombatViewController) -> CombatViewController {
        if LeftPlayerType == .Computer && RightPlayerType == .Player {
            let TempParagon: ParagonOverseer = GameViewController.HeroParagon
            GameViewController.HeroParagon = GameViewController.VillainParagon
            GameViewController.VillainParagon = TempParagon
        }
        return GameViewController
    }
    
    func determineGameType() -> CombatViewController.GameType {
        var selectedGameType: CombatViewController.GameType = .none
        if LeftPlayerType == .Player {
            if RightPlayerType == .Player {
                selectedGameType = .pvp
            } else {
                selectedGameType = .pve
            }
        } else {
            if RightPlayerType == .Player {
                selectedGameType = .pve
            } else {
                selectedGameType = .eve
            }
        }
        return selectedGameType
    }
    
    
    // MARK: - Hero Selection Functions
    func updateSelectedParagonImageView() {
        SelectedHeroImageView.image = UIImage(named: "\(SelectedHero.Name)")
        UIView.transition(with: SelectedHeroImageView, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
    }
    
    func updateSelectedOpponectImageView() {
        SelectedOpponentImageView.image = UIImage(named: "\(SelectedOpponent.Name)")
        UIView.transition(with: SelectedOpponentImageView, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
    }
    
    
    // MARK: - Enemy Functions
    func determinEnemyParagon() {
        VillainParagon = SelectedOpponent
        CurrentEnemyHandSize = 0
        redrawEnemyCards()
    }
    
    
    // MARK: - Player Functions
    func determinHeroParagon() {
        HeroParagon = SelectedHero
        CurrentPlayerHandSize = 0
        redrawPlayerCards()
    }
    
    
    // MARK: - Player Card Hand Functions
    func redrawPlayerCards() {
        let cardsToDraw = HeroParagon.StartingHandsize
        if cardsToDraw > 0 {
            for _ in 1...cardsToDraw {
                DeckController.playerDrawCard()
            }
        }
        CurrentPlayerHandSize = HeroParagon.StartingHandsize
    }
    
    func redrawEnemyCards() {
        let cardsToDraw = VillainParagon.StartingHandsize
        if cardsToDraw > 0 {
            for _ in 1...cardsToDraw {
                DeckController.enemyDrawCard()
            }
        }
        CurrentEnemyHandSize = VillainParagon.StartingHandsize
    }
    
    
    // MARK: - Button Functions
    @IBAction func pressBeginCombatButton(_ sender: UIButton) {
        DeckController.prepareHand()
        HeroParagon.resetHandSize()
        VillainParagon.resetHandSize()
        determinHeroParagon()
        determinEnemyParagon()
        showCardSelectionWindow()
    }
    
    @IBAction func pressLeftPlayerTypeButton(_ sender: UIButton) {
        if LeftPlayerType == .Player {
            LeftPlayerType = .Computer
            LeftPlayerTypeButton.setBackgroundImage(UIImage(named: "Icon_Computer2"), for: .normal)
        } else {
            LeftPlayerType = .Player
            LeftPlayerTypeButton.setBackgroundImage(UIImage(named: "Icon_Player2"), for: .normal)
        }
    }
    
    @IBAction func pressRightPlayerTypeButton(_ sender: UIButton) {
        if RightPlayerType == .Player {
            RightPlayerType = .Computer
            RightPlayerTypeButton.setBackgroundImage(UIImage(named: "Icon_Computer2"), for: .normal)
        } else {
            RightPlayerType = .Player
            RightPlayerTypeButton.setBackgroundImage(UIImage(named: "Icon_Player2"), for: .normal)
        }
    }
    
    
    // MARK: - Collection View Functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NumberOfParagons
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == HeroesCollectionView {
            let paragonOptionCell = HeroesCollectionView.dequeueReusableCell(withReuseIdentifier: "ParagonOptionCollectionViewCell", for: indexPath) as! ParagonOptionCollectionViewCell
            paragonOptionCell.setUpParagonOptionCell(paragon: ParagonChoices[indexPath.row])
            return paragonOptionCell
        } else {
            let paragonOptionCell = OpponentsCollectionView.dequeueReusableCell(withReuseIdentifier: "ParagonOptionCollectionViewCell2", for: indexPath) as! ParagonOptionCollectionViewCell
            paragonOptionCell.setUpParagonOptionCell(paragon: OpponentChoices[indexPath.row])
            return paragonOptionCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = collectionView.frame.width * (6/10)
        let width = (collectionView.frame.width / 2)  - 10
        let height = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !UpdatingSelection {
            UpdatingSelection = true
            if collectionView == HeroesCollectionView {
                SelectedHero = ParagonChoices[indexPath.row]
                updateSelectedParagonImageView()
            } else if collectionView == OpponentsCollectionView {
                SelectedOpponent = OpponentChoices[indexPath.row]
                updateSelectedOpponectImageView()
            }
            UpdatingSelection = false
        }
    }
}
