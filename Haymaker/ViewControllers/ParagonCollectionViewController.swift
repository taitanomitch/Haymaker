//
//  ParagonCollectionViewController.swift
//  Haymaker
//
//  Created by Mitchell Taitano on 4/7/21.
//  Copyright © 2021 Mitchell Taitano. All rights reserved.
//

import UIKit

class ParagonCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextViewDelegate, ParagonCreatorDelegate {
    
    
    // MARK: - IBOutlet Variables
    @IBOutlet weak var CreateParagonButton: UIButton!
    @IBOutlet weak var ParagonsCollectionView: UICollectionView!
    @IBOutlet weak var SelectedParagonImageView: UIImageView!
    @IBOutlet weak var SelectedParagonNameLabel: UILabel!
    @IBOutlet weak var SelectedParagonHandSizeLabel: UILabel!
    @IBOutlet weak var SelectedParagonEdgeLabel: UILabel!
    @IBOutlet weak var SelectedParagonStrengthLabel: UILabel!
    @IBOutlet weak var SelectedParagonAgilityLabel: UILabel!
    @IBOutlet weak var SelectedParagonIntellectLabel: UILabel!
    @IBOutlet weak var SelectedParagonWillpowerLabel: UILabel!
    @IBOutlet weak var SelectedParagonCombatAbilitiesTextView: UITextView!
    @IBOutlet weak var SelectedParagonBioTextView: UITextView!
    @IBOutlet weak var UpgradeParagonButton: UIButton!
    
    @IBOutlet weak var AttributesHolderView: UIView!
    @IBOutlet weak var AbilityPowerHolderView: UIView!
    
    // MARK: - Variables
    var SelectedParagon: ParagonOverseer = ParagonOverseer()
    var NumberOfParagons: Int = 30
    var ParagonList: [ParagonOverseer] = []
    
    // MARK: - Setup Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ParagonsCollectionView.register(UINib(nibName: "BasicParagonCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BasicParagonCollectionViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUp()
    }
    
    
    // MARK: - Setup Functions
    func setUp() {
        setUpParagonsList()
        setInitialSelectedParagon()
        setUpViewsUI()
        setUpSelectedParagonImageView()
        setUpUpgradeButton()
    }
    
    func setUpParagonsList() {
        ParagonList = listOfCharacaters()
        NumberOfParagons = ParagonList.count
    }
    
    func setInitialSelectedParagon() {
        SelectedParagon = ParagonList.first!
        updateSelectedParagon()
    }
    
    func setUpViewsUI() {
        setUpBioTextfield()
        setUpAttributesView()
        setUpCombatAbilityView()
    }
    
    func setUpBioTextfield() {
        SelectedParagonBioTextView.textColor = UIColor.black
        SelectedParagonBioTextView.layer.borderWidth = 2.0
        SelectedParagonBioTextView.layer.borderColor = UIColor.black.cgColor
        SelectedParagonBioTextView.layer.cornerRadius = 4.0
        SelectedParagonBioTextView.layer.masksToBounds = true
    }
    
    func setUpAttributesView() {
        AttributesHolderView.layer.borderWidth = 2.0
        AttributesHolderView.layer.borderColor = UIColor.black.cgColor
        AttributesHolderView.layer.cornerRadius = 4.0
        AttributesHolderView.layer.masksToBounds = true
    }
    
    func setUpCombatAbilityView() {
        AbilityPowerHolderView.layer.borderWidth = 2.0
        AbilityPowerHolderView.layer.borderColor = UIColor.black.cgColor
        AbilityPowerHolderView.layer.cornerRadius = 4.0
        AbilityPowerHolderView.layer.masksToBounds = true
    }
    
    func setUpSelectedParagonImageView() {
        SelectedParagonImageView.tintColor = UIColor.black
    }
    
    func setUpUpgradeButton() {
        if SelectedParagon.isCustom {
            UpgradeParagonButton.alpha = 1.0
        } else {
            UpgradeParagonButton.alpha = 0.0
        }
    }
    
    // MARK: - Update Functions
    func updateSelectedParagon() {
        updateSelectedParagonImage()
        updateSelectedParagonLabels()
        updateCombatAbilityText()
        setUpUpgradeButton()
    }
    
    func updateSelectedParagonLabels() {
        SelectedParagonNameLabel.text = "\(SelectedParagon.Name)"
        SelectedParagonHandSizeLabel.text = "\(SelectedParagon.StartingHandsize)"
        SelectedParagonEdgeLabel.text = "\(SelectedParagon.Edge)"
        SelectedParagonStrengthLabel.text = "\(SelectedParagon.Strength)"
        SelectedParagonAgilityLabel.text = "\(SelectedParagon.Agility)"
        SelectedParagonIntellectLabel.text = "\(SelectedParagon.Intellect)"
        SelectedParagonWillpowerLabel.text = "\(SelectedParagon.Willpower)"
        SelectedParagonBioTextView.text = "\(SelectedParagon.Bio)"
    }
    
    func updateSelectedParagonImage() {
        SelectedParagonImageView.image = UIImage(named: "\(SelectedParagon.Image)")
    }
    
    func updateCombatAbilityText() {
        SelectedParagonCombatAbilitiesTextView.text = SelectedParagon.getParagonCombatAbilityText()
    }
    
    
    // MARK: - Utility Functions
    func listOfCharacaters() -> [ParagonOverseer] {
        var availableCharaters: [ParagonOverseer] = []
        availableCharaters = listOfHeroes(characterList: availableCharaters)
        availableCharaters = listOfVillains(characterList: availableCharaters)
        availableCharaters = listOfHenchmen(characterList: availableCharaters)
        availableCharaters = listOfCustomParagon(characterList: availableCharaters)
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
    
    func listOfCustomParagon(characterList: [ParagonOverseer]) -> [ParagonOverseer] {
        let ParagonGenerator = CustomParagonGenerator()
        let CustomerParagonList = ParagonGenerator.retrieveAllCustomParagons()
        
        var list = characterList
        list.append(contentsOf: CustomerParagonList)
        return list
    }
    
    // MARK: - TextView Functions
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return false
    }
    
    // MARK: - ParagonCreatorDelegate Functions
    func CreationCompleted() {
        setUp()
        ParagonsCollectionView.reloadData()
    }
    
    // MARK: - Button Functions
    @IBAction func pressCreateParagonButton(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ParagonCreatorViewController") as! ParagonCreatorViewController
        newViewController.delegate = self
        self.present(newViewController, animated: true) {
            
        }
    }
    
    @IBAction func pressBackButton(_ sender: UIButton) {
        self.dismiss(animated: true) {}
    }
    
    
    @IBAction func pressUpgradeButton(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ParagonImprovementViewController") as! ParagonImprovementViewController
        self.present(newViewController, animated: true) {
            
        }
    }
    
    
    // MARK: - Collection View Functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NumberOfParagons
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let paragonCell = ParagonsCollectionView.dequeueReusableCell(withReuseIdentifier: "ParagonOptionCollectionViewCell", for: indexPath) as! ParagonOptionCollectionViewCell
        paragonCell.setUpParagonOptionCell(paragon: ParagonList[indexPath.row])
        return paragonCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height  - 2
        let width = height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        SelectedParagon = ParagonList[indexPath.row]
        updateSelectedParagon()
    }
    
    
}
