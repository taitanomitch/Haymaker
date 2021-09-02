//
//  ParagonCreatorViewController.swift
//  Haymaker
//
//  Created by Mitchell Taitano on 4/6/21.
//  Copyright © 2021 Mitchell Taitano. All rights reserved.
//

import UIKit

protocol ParagonCreatorDelegate {
    func CreationCompleted()
}

class ParagonCreatorViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    // MARK: - IBOutlet Variables
    @IBOutlet weak var NextButton: UIButton!
    @IBOutlet weak var CancelButton: UIButton!
    
    @IBOutlet weak var ParagonImageView: UIImageView!
    @IBOutlet weak var ParagonImageChangeLeftButton: UIButton!
    @IBOutlet weak var ParagonImageChangeRightButton: UIButton!
    @IBOutlet weak var ParagonNameTextField: UITextField!
    @IBOutlet weak var EnterNameLabel: UILabel!
    
    @IBOutlet weak var RemainingPointsLabel: UILabel!
    @IBOutlet weak var RemainingPointsNumberLabel: UILabel!
    
    @IBOutlet weak var StrengthSelectButton: UIButton!
    @IBOutlet weak var AgilitySelectButton: UIButton!
    @IBOutlet weak var IntellectSelectButton: UIButton!
    @IBOutlet weak var WillpowerSelectButton: UIButton!
    
    @IBOutlet weak var StengthLabel: UILabel!
    @IBOutlet weak var AgilityLabel: UILabel!
    @IBOutlet weak var IntellectLabel: UILabel!
    @IBOutlet weak var WillpowerLabel: UILabel!
    
    @IBOutlet weak var StrengthNumberLabel: UILabel!
    @IBOutlet weak var AgilityNumberLabel: UILabel!
    @IBOutlet weak var IntellectNumberLabel: UILabel!
    @IBOutlet weak var WillpowerNumberLabel: UILabel!
    
    @IBOutlet weak var StrengthLeftButton: UIButton!
    @IBOutlet weak var StrengthRightButton: UIButton!
    @IBOutlet weak var AgilityLeftButton: UIButton!
    @IBOutlet weak var AgilityRightButton: UIButton!
    @IBOutlet weak var IntellectLeftButton: UIButton!
    @IBOutlet weak var IntellectRightButton: UIButton!
    @IBOutlet weak var WillpowerLeftButton: UIButton!
    @IBOutlet weak var WillpowerRightButton: UIButton!
    
    @IBOutlet weak var StrengthAttackEnabledLabel: UILabel!
    @IBOutlet weak var AgilityAttackEnabledLabel: UILabel!
    @IBOutlet weak var IntellectAttackEnabledLabel: UILabel!
    @IBOutlet weak var WillpowerAttackEnabledLabel: UILabel!
    
    @IBOutlet weak var BioTextView: UITextView!
    @IBOutlet weak var EnterBioLabel: UILabel!
    @IBOutlet weak var BioHolderView: UIView!
    @IBOutlet weak var BioHiderView: UIView!
    @IBOutlet weak var BioHolderBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var FinishScreenHolderView: UIView!
    @IBOutlet weak var StrengthAttackTextField: UITextField!
    @IBOutlet weak var FinalStrengthNumberLabel: UILabel!
    @IBOutlet weak var AgilityAttackTextField: UITextField!
    @IBOutlet weak var FinalAgilityNumberLabel: UILabel!
    @IBOutlet weak var IntellectAttackTextField: UITextField!
    @IBOutlet weak var FinalIntellectNumberLabel: UILabel!
    @IBOutlet weak var WillpowerAttackTextField: UITextField!
    @IBOutlet weak var FinalWillpowerNumberLabel: UILabel!
    
    @IBOutlet weak var FinalNameLabel: UILabel!
    @IBOutlet weak var FinalBioLabel: UILabel!
    @IBOutlet weak var FinalBioTextView: UITextView!
    @IBOutlet weak var FinalBioHolderView: UIView!
    
    @IBOutlet weak var RemainingPowerPointsImageView: UIImageView!
    @IBOutlet weak var FinalRemainingPowerPointsLabel: UILabel!
    
    // MARK: - Variables
    var PowerPointCosts: [Int] = [0,1,1,1,2,2,3,3,4,4,5,6,7,8,9,10,11,12,13,14,15]
    var EnableAttackCost: [Int] = [2,2,2,2]
    var ParagonImageOptions:[UIImage] = []
    var CurrentImageSelection: Int = 0
    var TotalNumberOfImageOptions: Int = 8
    var RemainingPowerPoints: Int = 14
    var StrengthValue: Int = 0
    var AgilityValue: Int = 0
    var IntellectValue: Int = 0
    var WillpowerValue: Int = 0
    var KeyboardHeight: CGFloat = 325
    var TransitionSpeed: Double = 0.25
    var HiderViewAlphaForOn: CGFloat = 0.8
    var OnFinishScreen: Bool = false
    var HiderViewIsOn: Bool = false
    var StrengthSelected: Bool = false
    var AgilitySelected: Bool = false
    var IntellectSelected: Bool = false
    var WillpowerSelected: Bool = false
    var ParagonNameFont: String = "ActionMan"
    var ParagonNameFontSize: CGFloat = 27.0
    var AttackEnabledFont: String = "ActionMan"
    var AttackEnabledFontSize: CGFloat = 13.0
    public var delegate: ParagonCreatorDelegate?
    
    // MARK: - Loading Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        runSetup()
        setUpObserverFunctions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    // MARK: - Setup Functions
    func runSetup() {
        setUpButtons()
        setUpParagonImageViewUI()
        setUpBioUI()
        setUpAttackNameDefaultUI()
        setUpDelegates()
        setUpFinishScreen()
        setUpFinalNameLabel()
        setUpRemainingPointsNumberLabel()
        setUpFinalRemainingPoints()
        updateNextButton()
        updateRemainingPowerPoints()
        updateAllAttributeButtonsUI()
        updateAllAttributeLabels()
    }
    
    func setUpImageOptions() {
        for i in 0..<TotalNumberOfImageOptions {
            let nextImage = UIImage(named: "Option" + String(i))
            if !ParagonImageOptions.contains(nextImage!) {
                ParagonImageOptions.append(nextImage!)
            }
        }
    }
    
    func setUpParagonImageViewUI() {
        setUpImageOptions()
        ParagonImageView.tintColor = UIColor.black
        ParagonImageView.layer.borderWidth = 2.0
        ParagonImageView.layer.borderColor = UIColor.black.cgColor
        ParagonImageView.layer.cornerRadius = 4.0
        ParagonImageView.layer.masksToBounds = true
        updateParagonImageOption()
    }
    
    func setUpBioUI() {
        BioTextView.layer.borderWidth = 2.0
        BioTextView.layer.borderColor = UIColor.black.cgColor
        BioTextView.layer.cornerRadius = 4.0
        BioTextView.layer.masksToBounds = true
        
        FinalBioHolderView.layer.borderWidth = 2.0
        FinalBioHolderView.layer.borderColor = UIColor.black.cgColor
        FinalBioHolderView.layer.cornerRadius = 4.0
        FinalBioHolderView.layer.masksToBounds = true
    }
    
    func setUpAttackNameDefaultUI() {
        StrengthAttackEnabledLabel.alpha = 0.0
        StrengthAttackEnabledLabel.text = "Strength Attack Enabled"
        StrengthAttackEnabledLabel.font = UIFont(name: AttackEnabledFont, size: AttackEnabledFontSize)
        AgilityAttackEnabledLabel.alpha = 0.0
        AgilityAttackEnabledLabel.text = "Agility Attack Enabled"
        AgilityAttackEnabledLabel.font = UIFont(name: AttackEnabledFont, size: AttackEnabledFontSize)
        IntellectAttackEnabledLabel.alpha = 0.0
        IntellectAttackEnabledLabel.text = "Intellect Attack Enabled"
        IntellectAttackEnabledLabel.font = UIFont(name: AttackEnabledFont, size: AttackEnabledFontSize)
        WillpowerAttackEnabledLabel.alpha = 0.0
        WillpowerAttackEnabledLabel.text = "Willpower Attack Enabled"
        WillpowerAttackEnabledLabel.font = UIFont(name: AttackEnabledFont, size: AttackEnabledFontSize)
    }
    
    func setUpObserverFunctions() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func setUpDelegates() {
        BioTextView.delegate = self
        ParagonNameTextField.delegate = self
    }
    
    func setUpButtons() {
        NextButton.imageView!.contentMode = UIView.ContentMode.scaleAspectFit
        NextButton.setImage(UIImage(named: "Next"), for: .normal)
        CancelButton.imageView!.contentMode = UIView.ContentMode.scaleAspectFit
        CancelButton.setImage(UIImage(named: "Cancel"), for: .normal)
        StrengthLeftButton.imageView!.contentMode = UIView.ContentMode.scaleAspectFit
        StrengthRightButton.imageView!.contentMode = UIView.ContentMode.scaleAspectFit
        AgilityLeftButton.imageView!.contentMode = UIView.ContentMode.scaleAspectFit
        AgilityRightButton.imageView!.contentMode = UIView.ContentMode.scaleAspectFit
        IntellectLeftButton.imageView!.contentMode = UIView.ContentMode.scaleAspectFit
        IntellectRightButton.imageView!.contentMode = UIView.ContentMode.scaleAspectFit
        WillpowerLeftButton.imageView!.contentMode = UIView.ContentMode.scaleAspectFit
        WillpowerRightButton.imageView!.contentMode = UIView.ContentMode.scaleAspectFit
        
        StrengthSelectButton.layer.borderWidth = 2.0
        StrengthSelectButton.layer.borderColor = UIColor.black.cgColor
        StrengthSelectButton.layer.cornerRadius = 4.0
        StrengthSelectButton.layer.masksToBounds = true
        StrengthSelectButton.imageView!.contentMode = UIView.ContentMode.scaleAspectFill
        
        AgilitySelectButton.layer.borderWidth = 2.0
        AgilitySelectButton.layer.borderColor = UIColor.black.cgColor
        AgilitySelectButton.layer.cornerRadius = 4.0
        AgilitySelectButton.layer.masksToBounds = true
        AgilitySelectButton.imageView!.contentMode = UIView.ContentMode.scaleAspectFill
        
        IntellectSelectButton.layer.borderWidth = 2.0
        IntellectSelectButton.layer.borderColor = UIColor.black.cgColor
        IntellectSelectButton.layer.cornerRadius = 4.0
        IntellectSelectButton.layer.masksToBounds = true
        IntellectSelectButton.imageView!.contentMode = UIView.ContentMode.scaleAspectFill
        
        WillpowerSelectButton.layer.borderWidth = 2.0
        WillpowerSelectButton.layer.borderColor = UIColor.black.cgColor
        WillpowerSelectButton.layer.cornerRadius = 4.0
        WillpowerSelectButton.layer.masksToBounds = true
        WillpowerSelectButton.imageView!.contentMode = UIView.ContentMode.scaleAspectFill
    }
    
    func setUpFinishScreen() {
        FinishScreenHolderView.alpha = 0.0
    }
    
    func setUpFinalNameLabel() {
        FinalNameLabel.text = ""
        FinalNameLabel.font = UIFont(name: ParagonNameFont, size: ParagonNameFontSize)
    }
    
    func setUpRemainingPointsNumberLabel() {
        RemainingPointsNumberLabel.layer.borderWidth = 2.0
        RemainingPointsNumberLabel.layer.borderColor = UIColor.black.cgColor
        RemainingPointsNumberLabel.layer.cornerRadius = 4.0
        RemainingPointsNumberLabel.layer.masksToBounds = true
    }
    
    func setUpFinalRemainingPoints() {
        RemainingPowerPointsImageView.alpha = 0.0
        FinalRemainingPowerPointsLabel.alpha = 0.0
    }
    
    
    // MARK: - Update Functions
    func updateParagonImageOption() {
        ParagonImageView.image = ParagonImageOptions[CurrentImageSelection]
    }
    
    func updateRemainingPowerPoints() {
        RemainingPointsNumberLabel.text = String(RemainingPowerPoints)
    }
    
    func updateAttackNameFields() {
        if StrengthSelected {
            StrengthAttackTextField.isUserInteractionEnabled = true
            StrengthAttackTextField.placeholder = "Enter Strength Attack Name"
        } else {
            StrengthAttackTextField.isUserInteractionEnabled = false
            StrengthAttackTextField.placeholder = "-"
        }
        
        if AgilitySelected {
            AgilityAttackTextField.isUserInteractionEnabled = true
            AgilityAttackTextField.placeholder = "Enter Agility Attack Name"
        } else {
            AgilityAttackTextField.isUserInteractionEnabled = false
            AgilityAttackTextField.placeholder = "-"
        }
        
        if IntellectSelected {
            IntellectAttackTextField.isUserInteractionEnabled = true
            IntellectAttackTextField.placeholder = "Enter Intellect Attack Name"
        } else {
            IntellectAttackTextField.isUserInteractionEnabled = false
            IntellectAttackTextField.placeholder = "-"
        }
        
        if WillpowerSelected {
            WillpowerAttackTextField.isUserInteractionEnabled = true
            WillpowerAttackTextField.placeholder = "Enter Willpower Attack Name"
        } else {
            WillpowerAttackTextField.isUserInteractionEnabled = false
            WillpowerAttackTextField.placeholder = "-"
        }
    }
    
    func updateFinishScreen() {
        if OnFinishScreen {
            FinishScreenHolderView.alpha = 1.0
        } else {
            FinishScreenHolderView.alpha = 0.0
        }
    }
    
    func updateNextButton() {
        if (ParagonNameTextField.text != "") && (StrengthSelected || AgilitySelected || IntellectSelected || WillpowerSelected) {
            NextButton.alpha = 1.0
            if OnFinishScreen {
                NextButton.setImage(UIImage(named: "Create"), for: .normal)
            } else {
                NextButton.setImage(UIImage(named: "Next"), for: .normal)
            }
        } else {
            NextButton.alpha = 0.0
        }
    }
    
    func updateCancelButton() {
        if OnFinishScreen {
            CancelButton.setImage(UIImage(named: "Back"), for: .normal)
        } else {
            CancelButton.setImage(UIImage(named: "Cancel"), for: .normal)
        }
    }
    
    func updateIconChangeButtons() {
        if OnFinishScreen {
            ParagonImageChangeLeftButton.alpha = 0.0
            ParagonImageChangeRightButton.alpha = 0.0
        } else {
            ParagonImageChangeLeftButton.alpha = 1.0
            ParagonImageChangeRightButton.alpha = 1.0
        }
    }
    
    func updateParagonNameLabel() {
        if OnFinishScreen {
            FinalNameLabel.text = ParagonNameTextField.text
            FinalNameLabel.alpha = 1.0
            ParagonNameTextField.alpha = 0.0
        } else {
            FinalNameLabel.alpha = 0.0
            ParagonNameTextField.alpha = 1.0
        }
    }
    
    func updateFinalRemainingPoints() {
        if OnFinishScreen {
            FinalRemainingPowerPointsLabel.text = RemainingPointsNumberLabel.text
            RemainingPowerPointsImageView.alpha = 1.0
            FinalRemainingPowerPointsLabel.alpha = 1.0
        } else {
            RemainingPowerPointsImageView.alpha = 0.0
            FinalRemainingPowerPointsLabel.alpha = 0.0
        }
    }
    
    func updateAllAttributeLabels() {
        updateStengthLabel()
        updateAgilityLabel()
        updateIntellectLabel()
        updateWillpowerLabel()
    }
    
    func updateStengthLabel() {
        StrengthNumberLabel.text = String(StrengthValue)
        FinalStrengthNumberLabel.text = String(StrengthValue)
    }
    
    func updateAgilityLabel() {
        AgilityNumberLabel.text = String(AgilityValue)
        FinalAgilityNumberLabel.text = String(AgilityValue)
    }
    
    func updateIntellectLabel() {
        IntellectNumberLabel.text = String(IntellectValue)
        FinalIntellectNumberLabel.text = String(IntellectValue)
    }
    
    func updateWillpowerLabel() {
        WillpowerNumberLabel.text = String(WillpowerValue)
        FinalWillpowerNumberLabel.text = String(WillpowerValue)
    }
    
    func updateAllAttributeButtonsUI() {
        updateStrengthButtonsUI()
        updateAgilityButtonsUI()
        updateIntellectButtonsUI()
        updateWillpowerButtonsUI()
    }
    
    func updateAttackNameTextFields() {
        if StrengthSelected {
            StrengthAttackEnabledLabel.alpha = 1.0
        } else {
            StrengthAttackEnabledLabel.alpha = 0.0
        }
        if AgilitySelected {
            AgilityAttackEnabledLabel.alpha = 1.0
        } else {
            AgilityAttackEnabledLabel.alpha = 0.0
        }
        if IntellectSelected {
            IntellectAttackEnabledLabel.alpha = 1.0
        } else {
            IntellectAttackEnabledLabel.alpha = 0.0
        }
        if WillpowerSelected {
            WillpowerAttackEnabledLabel.alpha = 1.0
        } else {
            WillpowerAttackEnabledLabel.alpha = 0.0
        }
    }
    
    func updateSelectedAttributesButtons() {
        if StrengthSelected {
            StrengthSelectButton.setImage(UIImage(named: "SelectGreen")!.withRenderingMode(.alwaysOriginal), for: .normal)
        } else {
            StrengthSelectButton.setImage(UIImage(), for: .normal)
        }
        if AgilitySelected {
            AgilitySelectButton.setImage(UIImage(named: "SelectRed")!.withRenderingMode(.alwaysOriginal), for: .normal)
        } else {
            AgilitySelectButton.setImage(UIImage(), for: .normal)
        }
        if IntellectSelected {
            IntellectSelectButton.setImage(UIImage(named: "SelectBlue")!.withRenderingMode(.alwaysOriginal), for: .normal)
        } else {
            IntellectSelectButton.setImage(UIImage(), for: .normal)
        }
        if WillpowerSelected {
            WillpowerSelectButton.setImage(UIImage(named: "SelectPurple")!.withRenderingMode(.alwaysOriginal), for: .normal)
        } else {
            WillpowerSelectButton.setImage(UIImage(), for: .normal)
        }
    }
    
    func updateStrengthButtonsUI() {
        if StrengthValue == 0 {
            StrengthLeftButton.alpha = 0.0
        } else {
            StrengthLeftButton.alpha = 1.0
        }
        
        if calculatePowerPointsChange(StartingNumber: StrengthValue, EndingNumber: StrengthValue + 1) > RemainingPowerPoints {
            StrengthRightButton.alpha = 0.0
        } else {
            StrengthRightButton.alpha = 1.0
        }
    }
    
    func updateAgilityButtonsUI() {
        if AgilityValue == 0 {
            AgilityLeftButton.alpha = 0.0
        } else {
            AgilityLeftButton.alpha = 1.0
        }
        
        if calculatePowerPointsChange(StartingNumber: AgilityValue, EndingNumber: AgilityValue + 1) > RemainingPowerPoints {
            AgilityRightButton.alpha = 0.0
        } else {
            AgilityRightButton.alpha = 1.0
        }
    }
    
    func updateIntellectButtonsUI() {
        if IntellectValue == 0 {
            IntellectLeftButton.alpha = 0.0
        } else {
            IntellectLeftButton.alpha = 1.0
        }
        
        if calculatePowerPointsChange(StartingNumber: IntellectValue, EndingNumber: IntellectValue + 1) > RemainingPowerPoints {
            IntellectRightButton.alpha = 0.0
        } else {
            IntellectRightButton.alpha = 1.0
        }
    }
    
    func updateWillpowerButtonsUI() {
        if WillpowerValue == 0 {
            WillpowerLeftButton.alpha = 0.0
        } else {
            WillpowerLeftButton.alpha = 1.0
        }
        
        if calculatePowerPointsChange(StartingNumber: WillpowerValue, EndingNumber: WillpowerValue + 1) > RemainingPowerPoints {
            WillpowerRightButton.alpha = 0.0
        } else {
            WillpowerRightButton.alpha = 1.0
        }
    }
    
    
    // MARK: - Utility Functions
    func buildCreatedParagon() -> ParagonOverseer {
        let CreatedParagon = ParagonOverseer()
        CreatedParagon.Name = FinalNameLabel.text!
        CreatedParagon.Image = "Option\(CurrentImageSelection)"
        CreatedParagon.Bio = FinalBioTextView.text
        CreatedParagon.EntryTaunt = ""
        
        CreatedParagon.Strength = Int(FinalStrengthNumberLabel.text!)!
        CreatedParagon.Agility = Int(FinalAgilityNumberLabel.text!)!
        CreatedParagon.Intellect = Int(FinalIntellectNumberLabel.text!)!
        CreatedParagon.Willpower = Int(FinalWillpowerNumberLabel.text!)!
        
        CreatedParagon.Handsize = 3
        CreatedParagon.StartingHandsize = 3
        CreatedParagon.Edge = 1
        
        var AttackOptions: [Int] = [0, 0, 0, 0]
        var AttackNames: [String] = ["", "", "", ""]
        var AttackValues: [Int] = [0, 0, 0, 0]
        let DamageBonuses: [Int] = [0, 0, 0, 0]
        if StrengthSelected {
            AttackOptions[0] = 1
            AttackNames[0] = StrengthAttackTextField.text!
            AttackValues[0] = CreatedParagon.Strength
        }
        if AgilitySelected {
            AttackOptions[1] = 1
            AttackNames[1] = AgilityAttackTextField.text!
            AttackValues[1] = CreatedParagon.Agility
        }
        if IntellectSelected {
            AttackOptions[2] = 1
            AttackNames[2] = IntellectAttackTextField.text!
            AttackValues[2] = CreatedParagon.Intellect
        }
        if WillpowerSelected {
            AttackOptions[3] = 1
            AttackNames[3] = WillpowerAttackTextField.text!
            AttackValues[3] = CreatedParagon.Willpower
        }
        CreatedParagon.isCustom = true
        CreatedParagon.PossibleAttackTypeList = AttackOptions
        CreatedParagon.AttackTypeNames = AttackNames
        CreatedParagon.AttackValues = AttackValues
        CreatedParagon.DamageBonuses = DamageBonuses
        CreatedParagon.DodgeBonus = 0
        CreatedParagon.DamageResistance = 0
        CreatedParagon.WillpowerResistanceBonus = 0
        CreatedParagon.ParagonAbilityPower = .none
        CreatedParagon.ParagonAbilityPowerMultiplier = 0
        CreatedParagon.ParagonAbilityPowerText = ""
        
        CreatedParagon.PowerPoints = RemainingPowerPoints
        CreatedParagon.XP = 0
        CreatedParagon.Gems = 0
        
        return CreatedParagon
    }
    
    func calculatePowerPointsChange(StartingNumber: Int, EndingNumber: Int) -> Int {
        if StartingNumber > EndingNumber {
            return PowerPointCosts[StartingNumber]
        } else {
            return PowerPointCosts[EndingNumber]
        }
    }
    
    func runUpdatesForFinishScreenTransition() {
        updateFinishScreen()
        updateCancelButton()
        updateNextButton()
        updateParagonNameLabel()
        updateIconChangeButtons()
        updateFinalRemainingPoints()
    }
    
    
    // MARK: - Button Functions
    @IBAction func pressNextButton(_ sender: UIButton) {
        view.endEditing(true)
        if OnFinishScreen {
            let StrengthText = StrengthAttackTextField.text
            let AgilityText = AgilityAttackTextField.text
            let IntellecText = IntellectAttackTextField.text
            let WillpowerText = WillpowerAttackTextField.text
            if ((StrengthSelected && StrengthText != "") || !StrengthSelected) && ((AgilitySelected && AgilityText != "") || !AgilitySelected) && ((IntellectSelected && IntellecText != "") || !IntellectSelected) && ((WillpowerSelected && WillpowerText != "") || !WillpowerSelected) {
                let createdParagon = buildCreatedParagon()
                let ParagonGenerator = CustomParagonGenerator()
                ParagonGenerator.storeParagon(ParagonNumber: -1, Paragon: createdParagon)
                delegate?.CreationCompleted()
                self.dismiss(animated: true) {}
            }
        } else {
            FinalBioTextView.text = BioTextView.text
            OnFinishScreen = true
        }
        updateAttackNameFields()
        runUpdatesForFinishScreenTransition()
    }
    
    @IBAction func pressCancelButton(_ sender: UIButton) {
        if OnFinishScreen {
            OnFinishScreen = false
            runUpdatesForFinishScreenTransition()
        } else {
            self.dismiss(animated: true) {}
        }
    }
    
    @IBAction func pressPreviousImage(_ sender: UIButton) {
        CurrentImageSelection = CurrentImageSelection - 1
        if CurrentImageSelection < 0 {
            CurrentImageSelection = ParagonImageOptions.count - 1
        }
        updateParagonImageOption()
    }
    
    @IBAction func pressNextImage(_ sender: UIButton) {
        CurrentImageSelection = CurrentImageSelection + 1
        if CurrentImageSelection >= ParagonImageOptions.count {
            CurrentImageSelection = 0
        }
        updateParagonImageOption()
    }
    
    @IBAction func pressSelectStrength(_ sender: UIButton) {
        if StrengthSelected {
            StrengthSelected = !StrengthSelected
            RemainingPowerPoints += EnableAttackCost[0]
        } else {
            if RemainingPowerPoints >= EnableAttackCost[0] {
                StrengthSelected = !StrengthSelected
                RemainingPowerPoints -= EnableAttackCost[0]
            }
        }
        updateNextButton()
        updateAttackNameTextFields()
        updateSelectedAttributesButtons()
        updateAllAttributeButtonsUI()
        updateRemainingPowerPoints()
    }
    
    @IBAction func pressSelectAgility(_ sender: UIButton) {
        if AgilitySelected {
            AgilitySelected = !AgilitySelected
            RemainingPowerPoints += EnableAttackCost[1]
        } else {
            if RemainingPowerPoints >= EnableAttackCost[1] {
                AgilitySelected = !AgilitySelected
                RemainingPowerPoints -= EnableAttackCost[1]
            }
        }
        updateNextButton()
        updateAttackNameTextFields()
        updateSelectedAttributesButtons()
        updateAllAttributeButtonsUI()
        updateRemainingPowerPoints()
    }
    
    @IBAction func pressSelectIntellect(_ sender: UIButton) {
        if IntellectSelected {
            IntellectSelected = !IntellectSelected
            RemainingPowerPoints += EnableAttackCost[2]
        } else {
            if RemainingPowerPoints >= EnableAttackCost[2] {
                IntellectSelected = !IntellectSelected
                RemainingPowerPoints -= EnableAttackCost[2]
            }
        }
        updateNextButton()
        updateAttackNameTextFields()
        updateSelectedAttributesButtons()
        updateAllAttributeButtonsUI()
        updateRemainingPowerPoints()
    }
    
    @IBAction func pressSelectWillpower(_ sender: UIButton) {
        if WillpowerSelected {
            WillpowerSelected = !WillpowerSelected
            RemainingPowerPoints += EnableAttackCost[3]
        } else {
            if RemainingPowerPoints >= EnableAttackCost[3] {
                WillpowerSelected = !WillpowerSelected
                RemainingPowerPoints -= EnableAttackCost[3]
            }
        }
        updateNextButton()
        updateAttackNameTextFields()
        updateSelectedAttributesButtons()
        updateAllAttributeButtonsUI()
        updateRemainingPowerPoints()
    }
    
    @IBAction func pressDecreaseStrength(_ sender: UIButton) {
        let newValue = StrengthValue - 1
        let cost = calculatePowerPointsChange(StartingNumber: StrengthValue, EndingNumber: newValue)
        if newValue >= 0 {
            StrengthValue = newValue
            RemainingPowerPoints += cost
        }
        updateStengthLabel()
        updateAllAttributeButtonsUI()
        updateAllAttributeLabels()
        updateRemainingPowerPoints()
    }
    @IBAction func pressIncreaseStrength(_ sender: UIButton) {
        let newValue = StrengthValue + 1
        let cost = calculatePowerPointsChange(StartingNumber: StrengthValue, EndingNumber: newValue)
        if cost <= RemainingPowerPoints {
            StrengthValue = newValue
            RemainingPowerPoints -= cost
        }
        updateStengthLabel()
        updateAllAttributeButtonsUI()
        updateAllAttributeLabels()
        updateRemainingPowerPoints()
    }
    @IBAction func pressDecreaseAgility(_ sender: UIButton) {
        let newValue = AgilityValue - 1
        let cost = calculatePowerPointsChange(StartingNumber: AgilityValue, EndingNumber: newValue)
        if newValue >= 0 {
            AgilityValue = newValue
            RemainingPowerPoints += cost
        }
        updateAllAttributeButtonsUI()
        updateAllAttributeLabels()
        updateRemainingPowerPoints()
    }
    @IBAction func pressIncreaseAgility(_ sender: UIButton) {
        let newValue = AgilityValue + 1
        let cost = calculatePowerPointsChange(StartingNumber: AgilityValue, EndingNumber: newValue)
        if cost <= RemainingPowerPoints {
            AgilityValue = newValue
            RemainingPowerPoints -= cost
        }
        updateAllAttributeButtonsUI()
        updateAllAttributeLabels()
        updateRemainingPowerPoints()
    }
    @IBAction func pressDecreaseIntellect(_ sender: UIButton) {
        let newValue = IntellectValue - 1
        let cost = calculatePowerPointsChange(StartingNumber: IntellectValue, EndingNumber: newValue)
        if newValue >= 0 {
            IntellectValue = newValue
            RemainingPowerPoints += cost
        }
        updateAllAttributeButtonsUI()
        updateAllAttributeLabels()
        updateRemainingPowerPoints()
    }
    @IBAction func pressIncreaseIntellect(_ sender: UIButton) {
        let newValue = IntellectValue + 1
        let cost = calculatePowerPointsChange(StartingNumber: IntellectValue, EndingNumber: newValue)
        if cost <= RemainingPowerPoints {
            IntellectValue = newValue
            RemainingPowerPoints -= cost
        }
        updateAllAttributeButtonsUI()
        updateAllAttributeLabels()
        updateRemainingPowerPoints()
    }
    @IBAction func pressDecreaseWillpower(_ sender: UIButton) {
        let newValue = WillpowerValue - 1
        let cost = calculatePowerPointsChange(StartingNumber: WillpowerValue, EndingNumber: newValue)
        if newValue >= 0 {
            WillpowerValue = newValue
            RemainingPowerPoints += cost
        }
        updateAllAttributeButtonsUI()
        updateAllAttributeLabels()
        updateRemainingPowerPoints()
    }
    @IBAction func pressIncreaseWillpower(_ sender: UIButton) {
        let newValue = WillpowerValue + 1
        let cost = calculatePowerPointsChange(StartingNumber: WillpowerValue, EndingNumber: newValue)
        if cost <= RemainingPowerPoints {
            WillpowerValue = newValue
            RemainingPowerPoints -= cost
        }
        updateAllAttributeButtonsUI()
        updateAllAttributeLabels()
        updateRemainingPowerPoints()
    }
    
    // MARK: - TextView Functions
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if OnFinishScreen {
            return false
        } else {
            return true
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {

    }
    
    func textViewDidEndEditing(_ textView: UITextView) {

    }
    
    // MARK: - TextField Functions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        BioTextView.becomeFirstResponder()
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {

    }
    
    // MARK: - Observer Functions
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if OnFinishScreen {
            
        } else {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                self.BioHolderBottomConstraint.constant = keyboardSize.height
                UIView.animate(withDuration: TransitionSpeed) {
                    self.EnterBioLabel.textColor = UIColor.white
                    self.BioHiderView.alpha = self.HiderViewAlphaForOn
                    self.view.layoutIfNeeded()
                    self.HiderViewIsOn = true
                }
            }
        }
    }

    @objc func keyboardWillHide(notification: Notification) {
        updateNextButton()
        self.BioHolderBottomConstraint.constant = 0
        UIView.animate(withDuration: TransitionSpeed) {
            self.EnterBioLabel.textColor = UIColor.black
            self.BioHiderView.alpha = 0.0
            self.view.layoutIfNeeded()
            self.HiderViewIsOn = false
        }
    }

}
