//
//  ParagonImprovementViewController.swift
//  Haymaker
//
//  Created by Mitchell Taitano on 4/6/21.
//  Copyright © 2021 Mitchell Taitano. All rights reserved.
//

import UIKit

class ParagonImprovementViewController: UIViewController {
    
    @IBOutlet weak var BackButton: UIButton!
    @IBOutlet weak var SaveButton: UIButton!
    @IBOutlet weak var EditButton: UIButton!
    
    @IBOutlet weak var ParagonNameLabel: UILabel!
    @IBOutlet weak var ParagonImageView: UIImageView!
    @IBOutlet weak var PowerGemImageView: UIImageView!
    @IBOutlet weak var PowerGemLabel: UILabel!
    @IBOutlet weak var PowerGemBorderView: UIView!
    
    @IBOutlet weak var HandSizeImageView: UIImageView!
    @IBOutlet weak var HandSizeLabel: UILabel!
    @IBOutlet weak var HandSizeIncreaseButton: UIButton!
    @IBOutlet weak var HandSizeDecreaseButton: UIButton!
    
    @IBOutlet weak var EdgeImageView: UIImageView!
    @IBOutlet weak var EdgeLabel: UILabel!
    @IBOutlet weak var EdgeIncreaseButton: UIButton!
    @IBOutlet weak var EdgeDecreaseButton: UIButton!
    
    @IBOutlet weak var HandSizeEdgeCostLabel: UILabel!
    
    @IBOutlet weak var IncreaseCostHolderView: UIView!
    @IBOutlet weak var IncreaseCostLabel: UILabel!
    
    @IBOutlet weak var StrengthIconImageView: UIImageView!
    @IBOutlet weak var AgilityIconImageView: UIImageView!
    @IBOutlet weak var IntellectIconImageView: UIImageView!
    @IBOutlet weak var WillpowerIconImageView: UIImageView!
    
    @IBOutlet weak var StrengthIconBackgroundImageView: UIImageView!
    @IBOutlet weak var AgilityIconBackgroundImageView: UIImageView!
    @IBOutlet weak var IntellectIconBackgroundImageView: UIImageView!
    @IBOutlet weak var WillpowerIconBackgroundImageView: UIImageView!
    
    @IBOutlet weak var StrengthValueLabel: UILabel!
    @IBOutlet weak var AgilityValueLabel: UILabel!
    @IBOutlet weak var IntellectValueLabel: UILabel!
    @IBOutlet weak var WillpowerValueLabel: UILabel!
    
    @IBOutlet weak var StrengthValueChangeLabel: UILabel!
    @IBOutlet weak var AgilityValueChangeLabel: UILabel!
    @IBOutlet weak var IntellectValueChangeLabel: UILabel!
    @IBOutlet weak var WillpowerValueChangeLabel: UILabel!
    
    @IBOutlet weak var StrengthDecreaseButton: UIButton!
    @IBOutlet weak var AgilityDecreaseButton: UIButton!
    @IBOutlet weak var IntellectDecreaseButton: UIButton!
    @IBOutlet weak var WillpowerDecreaseButton: UIButton!
    
    @IBOutlet weak var StrengthIncreaseButton: UIButton!
    @IBOutlet weak var AgilityIncreaseButton: UIButton!
    @IBOutlet weak var IntellectIncreaseButton: UIButton!
    @IBOutlet weak var WillpowerIncreaseButton: UIButton!
    
    @IBOutlet weak var StrengthPowerGemCostLabel: UILabel!
    @IBOutlet weak var AgilityPowerGemCostLabel: UILabel!
    @IBOutlet weak var IntellectPowerGemCostLabel: UILabel!
    @IBOutlet weak var WillpowerPowerGemCostLabel: UILabel!
    
    @IBOutlet weak var ResetPointAllocationButton: UIButton!
    
    var HandSizeCosts: [Int] = [0,0,0,0,20,50,100,500,1000,2000,5000]
    var EdgeCosts: [Int] = [0,0,10,50,100,5000,6000,7000,8000,9000,10000]
    var PowerPointCosts: [Int] = [0,1,1,1,2,2,3,3,4,4,5,6,7,8,9,10,11,12,13,14,15]
    
    public var ParagonToUpgrade: ParagonOverseer = ParagonOverseer()
    var NameValue: String = ""
    var StrengthCost: Int = 0
    var AgilityCost: Int = 0
    var IntellectCost: Int = 0
    var WillpowerCost: Int = 0
    var HandSizeEdgeCost: Int = 0
    
    var StrengthChangeValue: Int = 0
    var AgilityChangeValue: Int = 0
    var IntellectChangeValue: Int = 0
    var WillpowerChangeValue: Int = 0
    
    var RemainingPowerGems: Int = 0
    var HandSizeValue: Int = 0
    var EdgeValue: Int = 0
    var StrengthValue: Int = 0
    var AgilityValue: Int = 0
    var IntellectValue: Int = 0
    var WillpowerValue: Int = 0
    
    // MARK: - Loading Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        runSetUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    // MARK: - Setup Functions
    func runSetUp() {
        setUpPowerPointIndexes()
        setUpParagonImageUI()
        setUpHandSizeUI()
        setUpEdgeUI()
        setUpIncreaseCostsUI()
        setUpAbilityUI()
        setUpPowerGemBorderViewUI()
        setUpInitialValuesForLabels()
        setUpAllLabels()
    }
    
    func setUpParagonImageUI() {
        ParagonImageView.image = UIImage(named: ParagonToUpgrade.Image)
        ParagonImageView.layer.borderWidth = 2.0
        ParagonImageView.layer.borderColor = UIColor.black.cgColor
        ParagonImageView.layer.cornerRadius = 4.0
        ParagonImageView.layer.masksToBounds = true
    }
    
    func setUpHandSizeUI() {
        HandSizeImageView.image = UIImage(named: "Icon_CardsHand")
        HandSizeImageView.tintColor = UIColor.black
    }
    
    func setUpEdgeUI() {
        EdgeImageView.image = UIImage(named: "Icon_Edge2")
        EdgeImageView.tintColor = UIColor.black
    }
    
    func setUpPowerGemBorderViewUI() {
        PowerGemBorderView.layer.borderWidth = 2.0
        PowerGemBorderView.layer.borderColor = UIColor.black.cgColor
        PowerGemBorderView.layer.cornerRadius = 4.0
        PowerGemBorderView.layer.masksToBounds = true
    }
    
    func setUpIncreaseCostsUI() {
        IncreaseCostLabel.text = ""
    }
    
    func setUpAbilityUI() {
        StrengthIconImageView.image = UIImage(named: "Icon_Strength")
        StrengthIconImageView.tintColor = UIColor.white
        AgilityIconImageView.image = UIImage(named: "Icon_Agility")
        AgilityIconImageView.tintColor = UIColor.white
        IntellectIconImageView.image = UIImage(named: "Icon_Intellect")
        IntellectIconImageView.tintColor = UIColor.white
        WillpowerIconImageView.image = UIImage(named: "Icon_Willpower")
        WillpowerIconImageView.tintColor = UIColor.white
        
        StrengthIconBackgroundImageView.image = UIImage(named: "SelectGreen")
        StrengthIconBackgroundImageView.layer.cornerRadius = 4.0
        StrengthIconBackgroundImageView.layer.masksToBounds = true
        StrengthIconBackgroundImageView.contentMode = .scaleAspectFill
        AgilityIconBackgroundImageView.image = UIImage(named: "SelectRed")
        AgilityIconBackgroundImageView.layer.cornerRadius = 4.0
        AgilityIconBackgroundImageView.layer.masksToBounds = true
        AgilityIconBackgroundImageView.contentMode = .scaleAspectFill
        IntellectIconBackgroundImageView.image = UIImage(named: "SelectBlue")
        IntellectIconBackgroundImageView.layer.cornerRadius = 4.0
        IntellectIconBackgroundImageView.layer.masksToBounds = true
        IntellectIconBackgroundImageView.contentMode = .scaleAspectFill
        WillpowerIconBackgroundImageView.image = UIImage(named: "SelectPurple")
        WillpowerIconBackgroundImageView.layer.cornerRadius = 4.0
        WillpowerIconBackgroundImageView.layer.masksToBounds = true
        WillpowerIconBackgroundImageView.contentMode = .scaleAspectFill
        
        StrengthValueLabel.text = "\(ParagonToUpgrade.Strength)"
        AgilityValueLabel.text = "\(ParagonToUpgrade.Agility)"
        IntellectValueLabel.text = "\(ParagonToUpgrade.Intellect)"
        WillpowerValueLabel.text = "\(ParagonToUpgrade.Willpower)"
    }
    
    func setUpInitialValuesForLabels() {
        RemainingPowerGems = ParagonToUpgrade.PowerPoints
        
        NameValue = ParagonToUpgrade.Name
        HandSizeValue = ParagonToUpgrade.Handsize
        EdgeValue = ParagonToUpgrade.Edge
        StrengthValue = ParagonToUpgrade.Strength
        AgilityValue = ParagonToUpgrade.Agility
        IntellectValue = ParagonToUpgrade.Intellect
        WillpowerValue = ParagonToUpgrade.Willpower
        
        StrengthChangeValue = 0
        AgilityChangeValue = 0
        IntellectChangeValue = 0
        WillpowerChangeValue = 0
        
        StrengthCost = 0
        AgilityCost = 0
        IntellectCost = 0
        WillpowerCost = 0
    }
    
    func setUpAllLabels() {
        PowerGemLabel.text = String(RemainingPowerGems)
        
        ParagonNameLabel.text = "\(NameValue)"
        HandSizeLabel.text = "\(HandSizeValue)"
        EdgeLabel.text = "\(EdgeValue)"
        
        StrengthValueLabel.text = String(StrengthValue)
        AgilityValueLabel.text = String(AgilityValue)
        IntellectValueLabel.text = String(IntellectValue)
        WillpowerValueLabel.text = String(WillpowerValue)
        
        if StrengthChangeValue >= 0 {
            StrengthValueChangeLabel.text = "+\(StrengthChangeValue)"
        } else {
            StrengthValueChangeLabel.text = "\(StrengthChangeValue)"
        }
        if AgilityChangeValue >= 0 {
            AgilityValueChangeLabel.text = "+\(AgilityChangeValue)"
        } else {
            AgilityValueChangeLabel.text = "\(AgilityChangeValue)"
        }
        if IntellectChangeValue >= 0 {
            IntellectValueChangeLabel.text = "+\(IntellectChangeValue)"
        } else {
            IntellectValueChangeLabel.text = "\(IntellectChangeValue)"
        }
        if WillpowerChangeValue >= 0 {
            WillpowerValueChangeLabel.text = "+\(WillpowerChangeValue)"
        } else {
            WillpowerValueChangeLabel.text = "\(WillpowerChangeValue)"
        }
        
        if StrengthCost == 0 {
            StrengthPowerGemCostLabel.text = "\(StrengthCost)"
        } else if StrengthCost > 0 {
            StrengthPowerGemCostLabel.text = "-\(StrengthChangeValue)"
        } else {
            StrengthPowerGemCostLabel.text = "+\(StrengthChangeValue.magnitude)"
        }
        
        if AgilityCost == 0 {
            AgilityPowerGemCostLabel.text = "\(AgilityCost)"
        } else if AgilityCost > 0 {
            AgilityPowerGemCostLabel.text = "-\(AgilityCost)"
        } else {
            AgilityPowerGemCostLabel.text = "+\(AgilityCost.magnitude)"
        }
        
        if IntellectCost == 0 {
            IntellectPowerGemCostLabel.text = "\(IntellectCost)"
        } else if IntellectCost > 0 {
            IntellectPowerGemCostLabel.text = "-\(IntellectCost)"
        } else {
            IntellectPowerGemCostLabel.text = "+\(IntellectCost.magnitude)"
        }
        
        if WillpowerCost == 0 {
            WillpowerPowerGemCostLabel.text = "\(WillpowerCost)"
        } else if WillpowerCost > 0 {
            WillpowerPowerGemCostLabel.text = "-\(WillpowerCost)"
        } else {
            WillpowerPowerGemCostLabel.text = "+\(WillpowerCost.magnitude)"
        }
        
        if HandSizeEdgeCost == 0 {
            HandSizeEdgeCostLabel.text = "\(HandSizeEdgeCost)"
        } else if HandSizeEdgeCost > 0 {
            HandSizeEdgeCostLabel.text = "-\(HandSizeEdgeCost)"
        } else {
            HandSizeEdgeCostLabel.text = "+\(HandSizeEdgeCost.magnitude)"
        }
    }
    
    
    // MARK: - Utility Functions
    func setUpPowerPointIndexes() {
        
    }
    
    func calculatePowerPointsChange(StartingNumber: Int, EndingNumber: Int) -> Int {
        if StartingNumber > EndingNumber {
            return PowerPointCosts[StartingNumber]
        } else {
            return PowerPointCosts[EndingNumber]
        }
    }
    
    func calculatePowerPointsChange_HandSize(StartingNumber: Int, EndingNumber: Int) -> Int {
        if StartingNumber > EndingNumber {
            return HandSizeCosts[StartingNumber]
        } else {
            return HandSizeCosts[EndingNumber]
        }
    }
    
    func calculatePowerPointsChange_Edge(StartingNumber: Int, EndingNumber: Int) -> Int {
        if StartingNumber > EndingNumber {
            return EdgeCosts[StartingNumber]
        } else {
            return EdgeCosts[EndingNumber]
        }
    }

    
    // MARK: - Button Functions
    @IBAction func pressHandsizeIncreaseButton(_ sender: UIButton) {
        let newValue = HandSizeValue + 1
        let cost = calculatePowerPointsChange_HandSize(StartingNumber: HandSizeValue, EndingNumber: newValue)
        if cost <= RemainingPowerGems {
            HandSizeValue = newValue
            RemainingPowerGems -= cost
            HandSizeEdgeCost += cost
        }
        setUpAllLabels()
    }
    @IBAction func pressHandsizeDecreaseButton(_ sender: UIButton) {
        let newValue = HandSizeValue - 1
        let cost = calculatePowerPointsChange_HandSize(StartingNumber: HandSizeValue, EndingNumber: newValue)
        if newValue >= 0 {
            HandSizeValue = newValue
            RemainingPowerGems += cost
            HandSizeEdgeCost -= cost
        }
        setUpAllLabels()
    }
    @IBAction func pressEdgeIncreaseButton(_ sender: UIButton) {
        let newValue = EdgeValue + 1
        let cost = calculatePowerPointsChange_Edge(StartingNumber: EdgeValue, EndingNumber: newValue)
        if cost <= RemainingPowerGems {
            EdgeValue = newValue
            RemainingPowerGems -= cost
            HandSizeEdgeCost += cost
        }
        setUpAllLabels()
    }
    @IBAction func pressEdgeDecreaseButton(_ sender: UIButton) {
        let newValue = EdgeValue - 1
        let cost = calculatePowerPointsChange_Edge(StartingNumber: EdgeValue, EndingNumber: newValue)
        if newValue >= 0 {
            EdgeValue = newValue
            RemainingPowerGems += cost
            HandSizeEdgeCost -= cost
        }
        setUpAllLabels()
    }
    @IBAction func pressStengthIncreaseButton(_ sender: UIButton) {
        let newValue = StrengthValue + 1
        let cost = calculatePowerPointsChange(StartingNumber: StrengthValue, EndingNumber: newValue)
        if cost <= RemainingPowerGems {
            StrengthValue = newValue
            StrengthChangeValue += 1
            StrengthCost += cost
            RemainingPowerGems -= cost
        }
        setUpAllLabels()
    }
    @IBAction func pressStengthDecreaseButton(_ sender: UIButton) {
        let newValue = StrengthValue - 1
        let cost = calculatePowerPointsChange(StartingNumber: StrengthValue, EndingNumber: newValue)
        if newValue >= 0 {
            StrengthValue = newValue
            StrengthChangeValue -= 1
            StrengthCost -= cost
            RemainingPowerGems += cost
        }
        setUpAllLabels()
    }
    @IBAction func pressAgilityIncreaseButton(_ sender: UIButton) {
        let newValue = AgilityValue + 1
        let cost = calculatePowerPointsChange(StartingNumber: AgilityValue, EndingNumber: newValue)
        if cost <= RemainingPowerGems {
            AgilityValue = newValue
            AgilityChangeValue += 1
            AgilityCost += cost
            RemainingPowerGems -= cost
        }
        setUpAllLabels()
    }
    @IBAction func pressAgilityDecreaseButton(_ sender: UIButton) {
        let newValue = AgilityValue - 1
        let cost = calculatePowerPointsChange(StartingNumber: AgilityValue, EndingNumber: newValue)
        if newValue >= 0 {
            AgilityValue = newValue
            AgilityChangeValue -= 1
            AgilityCost -= cost
            RemainingPowerGems += cost
        }
        setUpAllLabels()
    }
    @IBAction func pressIntellectIncreaseButton(_ sender: UIButton) {
        let newValue = IntellectValue + 1
        let cost = calculatePowerPointsChange(StartingNumber: IntellectValue, EndingNumber: newValue)
        if cost <= RemainingPowerGems {
            IntellectValue = newValue
            IntellectChangeValue += 1
            IntellectCost += cost
            RemainingPowerGems -= cost
        }
        setUpAllLabels()
    }
    @IBAction func pressIntellectDecreaseButton(_ sender: UIButton) {
        let newValue = IntellectValue - 1
        let cost = calculatePowerPointsChange(StartingNumber: IntellectValue, EndingNumber: newValue)
        if newValue >= 0 {
            IntellectValue = newValue
            IntellectChangeValue -= 1
            IntellectCost -= cost
            RemainingPowerGems += cost
        }
        setUpAllLabels()
    }
    @IBAction func pressWillpowerIncreaseButton(_ sender: UIButton) {
        let newValue = WillpowerValue + 1
        let cost = calculatePowerPointsChange(StartingNumber: WillpowerValue, EndingNumber: newValue)
        if cost <= RemainingPowerGems {
            WillpowerValue = newValue
            WillpowerChangeValue += 1
            WillpowerCost += cost
            RemainingPowerGems -= cost
        }
        setUpAllLabels()
    }
    @IBAction func pressWillpowerDecreaseButton(_ sender: UIButton) {
        let newValue = WillpowerValue - 1
        let cost = calculatePowerPointsChange(StartingNumber: WillpowerValue, EndingNumber: newValue)
        if newValue >= 0 {
            WillpowerValue = newValue
            WillpowerChangeValue -= 1
            WillpowerCost -= cost
            RemainingPowerGems += cost
        }
        setUpAllLabels()
    }
    @IBAction func pressResetPointAllocationButton(_ sender: UIButton) {
    }
    
}
