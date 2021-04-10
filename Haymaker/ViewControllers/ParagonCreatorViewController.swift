//
//  ParagonCreatorViewController.swift
//  Haymaker
//
//  Created by Mitchell Taitano on 4/6/21.
//  Copyright © 2021 Mitchell Taitano. All rights reserved.
//

import UIKit

class ParagonCreatorViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    // MARK: - IBOutlet Variables
    @IBOutlet weak var NextButton: UIButton!
    
    @IBOutlet weak var ParagonImageView: UIImageView!
    @IBOutlet weak var ParagonImageChangeLeftButton: UIButton!
    @IBOutlet weak var ParagonImageChangeRightButton: UIButton!
    @IBOutlet weak var ParagonNameTextField: UITextField!
    
    @IBOutlet weak var RemainingPointsLabel: UILabel!
    @IBOutlet weak var RemainingPointsNumberLabel: UILabel!
    
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
    
    @IBOutlet weak var BioTextView: UITextView!
    @IBOutlet weak var EnterBioLabel: UILabel!
    @IBOutlet weak var BioHolderView: UIView!
    @IBOutlet weak var BioHiderView: UIView!
    @IBOutlet weak var BioHolderBottomConstraint: NSLayoutConstraint!
    
    
    // MARK: - Variables
    var PowerPointCosts: [Int] = [0,1,1,1,2,2,3,3,4,4,5,6,7,8,9,10,11,12,13,14,15]
    var ParagonImageOptions:[UIImage] = []
    var CurrentImageSelection: Int = 0
    var RemainingPowerPoints: Int = 12
    var StengthValue: Int = 0
    var AgilityValue: Int = 0
    var IntellectValue: Int = 0
    var WillpowerValue: Int = 0
    var KeyboardHeight: CGFloat = 325
    var TransitionSpeed: Double = 0.25
    var HiderViewAlphaForOn: CGFloat = 0.8
    var HiderViewIsOn: Bool = false
    
    
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
        setUpNextButton()
        setUpParagonImageViewUI()
        setUpBioUI()
        setUpDelegates()
        updateRemainingPowerPoints()
        updateAllAttributeButtonsUI()
        updateAllAttributeLabels()
    }
    
    func setUpNextButton() {
        NextButton.imageView!.contentMode = UIView.ContentMode.scaleAspectFit
    }
    
    func setUpImageOptions() {
        for i in 1...8 {
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
    
    
    // MARK: - Update Functions
    func updateParagonImageOption() {
        ParagonImageView.image = ParagonImageOptions[CurrentImageSelection]
    }
    
    func updateRemainingPowerPoints() {
        RemainingPointsNumberLabel.text = String(RemainingPowerPoints)
    }
    
    func updateAllAttributeLabels() {
        updateStengthLabel()
        updateAgilityLabel()
        updateIntellectLabel()
        updateWillpowerLabel()
    }
    
    func updateStengthLabel() {
        StrengthNumberLabel.text = String(StengthValue)
    }
    
    func updateAgilityLabel() {
        AgilityNumberLabel.text = String(AgilityValue)
    }
    
    func updateIntellectLabel() {
        IntellectNumberLabel.text = String(IntellectValue)
    }
    
    func updateWillpowerLabel() {
        WillpowerNumberLabel.text = String(WillpowerValue)
    }
    
    func updateAllAttributeButtonsUI() {
        updateStrengthButtonsUI()
        updateAgilityButtonsUI()
        updateIntellectButtonsUI()
        updateWillpowerButtonsUI()
    }
    
    func updateStrengthButtonsUI() {
        if StengthValue == 0 {
            StrengthLeftButton.alpha = 0.0
        } else {
            StrengthLeftButton.alpha = 1.0
        }
        
        if calculatePowerPointsChange(StartingNumber: StengthValue, EndingNumber: StengthValue + 1) > RemainingPowerPoints {
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
    func calculatePowerPointsChange(StartingNumber: Int, EndingNumber: Int) -> Int {
        if StartingNumber > EndingNumber {
            return PowerPointCosts[StartingNumber]
        } else {
            return PowerPointCosts[EndingNumber]
        }
    }
    
    
    // MARK: - Button Functions
    @IBAction func pressNextButton(_ sender: UIButton) {
        
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
    
    @IBAction func pressDecreaseStrength(_ sender: UIButton) {
        let newValue = StengthValue - 1
        let cost = calculatePowerPointsChange(StartingNumber: StengthValue, EndingNumber: newValue)
        if newValue >= 0 {
            StengthValue = newValue
            RemainingPowerPoints += cost
        }
        updateStengthLabel()
        updateAllAttributeButtonsUI()
        updateAllAttributeLabels()
        updateRemainingPowerPoints()
    }
    @IBAction func pressIncreaseStrength(_ sender: UIButton) {
        let newValue = StengthValue + 1
        let cost = calculatePowerPointsChange(StartingNumber: StengthValue, EndingNumber: newValue)
        if cost <= RemainingPowerPoints {
            StengthValue = newValue
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
    func textViewDidBeginEditing(_ textView: UITextView) {
//        if !HiderViewIsOn {
//            self.BioHolderBottomConstraint.constant = self.KeyboardHeight
//            UIView.animate(withDuration: TransitionSpeed) {
//                self.EnterBioLabel.textColor = UIColor.white
//                self.BioHiderView.alpha = self.HiderViewAlphaForOn
//                self.view.layoutIfNeeded()
//                self.HiderViewIsOn = true
//            }
//        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
//        if HiderViewIsOn {
//            self.BioHolderBottomConstraint.constant = 0
//            UIView.animate(withDuration: TransitionSpeed) {
//                self.EnterBioLabel.textColor = UIColor.black
//                self.BioHiderView.alpha = 0.0
//                self.view.layoutIfNeeded()
//                self.HiderViewIsOn = false
//            }
//        }
    }
    
    // MARK: - TextField Functions
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        if !HiderViewIsOn {
//            self.BioHolderBottomConstraint.constant = self.KeyboardHeight
//            UIView.animate(withDuration: TransitionSpeed) {
//                self.EnterBioLabel.textColor = UIColor.white
//                self.BioHiderView.alpha = self.HiderViewAlphaForOn
//                self.view.layoutIfNeeded()
//                self.HiderViewIsOn = true
//            }
//        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        if HiderViewIsOn {
//            self.BioHolderBottomConstraint.constant = 0
//            UIView.animate(withDuration: TransitionSpeed) {
//                self.EnterBioLabel.textColor = UIColor.black
//                self.BioHiderView.alpha = 0.0
//                self.view.layoutIfNeeded()
//                self.HiderViewIsOn = false
//            }
//        }
    }
    
    // MARK: - Observer Functions
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
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

    @objc func keyboardWillHide(notification: Notification) {
        self.BioHolderBottomConstraint.constant = 0
        UIView.animate(withDuration: TransitionSpeed) {
            self.EnterBioLabel.textColor = UIColor.black
            self.BioHiderView.alpha = 0.0
            self.view.layoutIfNeeded()
            self.HiderViewIsOn = false
        }
    }

}
