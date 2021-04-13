//
//  PlayerPasswordsViewController.swift
//  Haymaker
//
//  Created by Mitchell Taitano on 2/3/21.
//  Copyright © 2021 Mitchell Taitano. All rights reserved.
//

import UIKit

protocol PlayerPasswordDelegate {
    func CancelButtonPressed()
    func FightButtonPressed()
    func FightButtonWithoutPasswords()
    func PasswordsSet(passwordOne: String, passwordTwo: String)
    func EnterButtonPressed()
}

class PlayerPasswordsViewController: UIViewController, UITextFieldDelegate {
    
    enum PlayerPasswordPhases {
        case playerOne
        case playerTwo
        case complete
    }
    
    enum PasswordEntryType {
        case paswordSet
        case passwordTry
        case none
    }

    // MARK: - IBOutlet Variables
    @IBOutlet weak var PasswordSetHolderView: UIView!
    @IBOutlet weak var PasswordEntryHolderView: UIView!
    
    @IBOutlet weak var FightWithoutPasswordsButton: UIButton!
    @IBOutlet weak var PreviousButton: UIButton!
    @IBOutlet weak var NextButton: UIButton!
    @IBOutlet weak var CancelButton: UIButton!
    
    @IBOutlet weak var PlayerOneParagonImageView: UIImageView!
    @IBOutlet weak var PlayerTwoParagonImageView: UIImageView!
    
    @IBOutlet weak var PlayerOnePasswordLabel: UILabel!
    @IBOutlet weak var PlayerTwoPasswordLabel: UILabel!
    @IBOutlet weak var AboveTextfieldLabel: UILabel!
    @IBOutlet weak var PasswordTextfield: UITextField!
    
    @IBOutlet weak var AttemptParagonImageView: UIImageView!
    @IBOutlet weak var PasswordAttemptLabel: UILabel!
    @IBOutlet weak var PasswordAttemptTextfield: UITextField!
    
    // MARK: - Variables
    public var delegate: PlayerPasswordDelegate?
    var PasswordPhase: PlayerPasswordPhases = .playerOne
    var PlayerOneParagon: ParagonOverseer = ParagonOverseer()
    var PlayerTwoParagon: ParagonOverseer = ParagonOverseer()
    var ParagonForPassword: ParagonOverseer = ParagonOverseer()
    var PromptType: PasswordEntryType = .none
    var LabelFont: String = "ActionMan"
    var LabelFontSize: CGFloat = 20.0
    var LabelFontSize2: CGFloat = 23.0
    
    
    // MARK: - Loading Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        runSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    // MARK: - Setup Functions
    func runSetup() {
        setUpTextfield()
        setUpButtons()
        if PromptType == .paswordSet {
            let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
            view.addGestureRecognizer(tap)
        }
        
        switch PromptType {
        case .paswordSet:
            PasswordSetHolderView.alpha = 1.0
            PasswordEntryHolderView.alpha = 0.0
            setUpPasswordSetButtons()
            setUpParagonImageViewsForPasswordSetting()
        case .passwordTry:
            PasswordSetHolderView.alpha = 0.0
            PasswordEntryHolderView.alpha = 1.0
            setUpPasswordAttemptUI()
        case .none:
            return
        }
    }
    
    func setUpParagonImageView() {
        if ParagonForPassword.Name.count > 0 {
            AttemptParagonImageView.image = UIImage(named: ParagonForPassword.Image)
        }
    }
    
    func setUpButtons() {
        FightWithoutPasswordsButton.setImage(UIImage(named: "FightNoPasswords"), for: UIControl.State.normal)
        FightWithoutPasswordsButton.imageView!.contentMode = UIView.ContentMode.scaleAspectFit
        FightWithoutPasswordsButton.setTitle("", for: .normal)
        FightWithoutPasswordsButton.setTitleColor(UIColor.clear, for: .normal)
        FightWithoutPasswordsButton.backgroundColor = UIColor.clear
        NextButton.setImage(UIImage(named: "Next"), for: UIControl.State.normal)
        NextButton.imageView!.contentMode = UIView.ContentMode.scaleAspectFit
        NextButton.setTitle("", for: .normal)
        NextButton.setTitleColor(UIColor.clear, for: .normal)
        NextButton.backgroundColor = UIColor.clear
        PreviousButton.setImage(UIImage(named: "Back"), for: UIControl.State.normal)
        PreviousButton.imageView!.contentMode = UIView.ContentMode.scaleAspectFit
        PreviousButton.setTitle("", for: .normal)
        PreviousButton.setTitleColor(UIColor.clear, for: .normal)
        PreviousButton.backgroundColor = UIColor.clear
        CancelButton.setImage(UIImage(named: "Cancel"), for: UIControl.State.normal)
        CancelButton.imageView!.contentMode = UIView.ContentMode.scaleAspectFit
        CancelButton.setTitle("", for: .normal)
        CancelButton.setTitleColor(UIColor.clear, for: .normal)
        CancelButton.backgroundColor = UIColor.clear
    }
    
    func setUpTextfield() {
        if PromptType == .passwordTry {
            if let _ = PasswordAttemptTextfield {
                PasswordAttemptTextfield.clearsOnBeginEditing = true
            }
        } else {
            if let _ = PasswordTextfield {
                PasswordTextfield.clearsOnBeginEditing = true
            }
        }
    }
    
    func setUpPasswordAttemptUI() {
        setUpParagonImageView()
        if let _ = PasswordAttemptLabel {
            PasswordAttemptLabel.textColor = UIColor.white
            PasswordAttemptLabel.font = UIFont(name: LabelFont, size: LabelFontSize2)
            PasswordAttemptLabel.text = "Enter Your Password:"
        }
    }
    
    func clearPasswordAttemptTextfield() {
        if let _ = PasswordAttemptTextfield {
            PasswordAttemptTextfield.text = ""
            PasswordAttemptTextfield.sendActions(for: .editingChanged)
        }
    }
    
    
    func setUpInitialValues() {
        PasswordPhase = .playerOne
    }
    
    func setUpLabels() {
        PlayerOnePasswordLabel.font = UIFont(name: LabelFont, size: LabelFontSize)
        PlayerTwoPasswordLabel.font = UIFont(name: LabelFont, size: LabelFontSize)
        AboveTextfieldLabel.font = UIFont(name: LabelFont, size: LabelFontSize)
        switch PasswordPhase {
        case .playerOne:
            PasswordTextfield.isUserInteractionEnabled = true
            PlayerOnePasswordLabel.text = "Setting Password"
            PlayerTwoPasswordLabel.text = "Up Next"
            PlayerOnePasswordLabel.textColor = UIColor.white
            PlayerTwoPasswordLabel.textColor = UIColor.white
            AboveTextfieldLabel.textColor = UIColor.white
            AboveTextfieldLabel.text = "Enter 3-Digit Password:"
            AboveTextfieldLabel.alpha = 1.0
            PasswordTextfield.alpha = 1.0
        case .playerTwo:
            PasswordTextfield.isUserInteractionEnabled = true
            PlayerOnePasswordLabel.text = "Ready To Fight!"
            PlayerTwoPasswordLabel.text = "Setting Password"
            PlayerOnePasswordLabel.textColor = UIColor.white
            PlayerTwoPasswordLabel.textColor = UIColor.white
            AboveTextfieldLabel.textColor = UIColor.white
            AboveTextfieldLabel.text = "Enter 3-Digit Password:"
            AboveTextfieldLabel.alpha = 1.0
            PasswordTextfield.alpha = 1.0
        case .complete:
            PasswordTextfield.isUserInteractionEnabled = false
            PlayerOnePasswordLabel.text = "Ready To Fight!"
            PlayerTwoPasswordLabel.text = "Ready To Fight!"
            PlayerOnePasswordLabel.textColor = UIColor.white
            PlayerTwoPasswordLabel.textColor = UIColor.white
            AboveTextfieldLabel.textColor = UIColor.white
            AboveTextfieldLabel.text = "Password Setting Complete!"
            AboveTextfieldLabel.alpha = 0.0
            PasswordTextfield.alpha = 0.0
        }
    }
    
    func setUpParagonImageViewsForPasswordSetting() {
        PlayerOneParagonImageView.image = UIImage(named: PlayerOneParagon.Image)
        PlayerTwoParagonImageView.image = UIImage(named: PlayerTwoParagon.Image)
    }
    
    func setUpPasswordSetButtons() {
        switch PasswordPhase {
        case .playerOne:
            NextButton.setImage(UIImage(named: "Next"), for: UIControl.State.normal)
        case .playerTwo:
            NextButton.setImage(UIImage(named: "Next"), for: UIControl.State.normal)
        case .complete:
            NextButton.setImage(UIImage(named: "Fight"), for: UIControl.State.normal)
        }
        PreviousButton.setImage(UIImage(named: "Back"), for: UIControl.State.normal)
        CancelButton.setImage(UIImage(named: "Cancel"), for: UIControl.State.normal)
        setUpLabels()
    }
    
    
    // MARK: - Delegate Call Functions
    func pressFightWithoutPasswordsButton() {
        let transition = getDismissTransition()
        view.window!.layer.add(transition, forKey: kCATransition)
        self.dismiss(animated: false) {
            self.delegate?.FightButtonWithoutPasswords()
        }
    }
    
    func pressFightButton() {
        delegate?.PasswordsSet(passwordOne: PlayerOneParagon.ParagonPassword, passwordTwo: PlayerTwoParagon.ParagonPassword)
        let transition = getDismissTransition()
        view.window!.layer.add(transition, forKey: kCATransition)
        self.dismiss(animated: false) {
            self.delegate?.FightButtonPressed()
        }
    }
    
    func pressCancelButton() {
        let transition = getDismissTransition()
        view.window!.layer.add(transition, forKey: kCATransition)
        self.dismiss(animated: false) {
            self.delegate?.CancelButtonPressed()
        }
    }
    
    
    // MARK: - Transition Functions
    func getDismissTransition() -> CATransition {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromBottom
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        return transition
    }
    
    
    // MARK: - Button Press Functions
    @IBAction func pressFightWithoutPasswords(_ sender: UIButton) {
        pressFightWithoutPasswordsButton()
    }
    
    @IBAction func pressNextButton(_ sender: UIButton) {
        if PasswordPhase == .complete {
            pressFightButton()
        } else {
            if let passwordText = PasswordTextfield.text, !passwordText.isEmpty {
                switch PasswordPhase {
                case .playerOne:
                    if passwordText.count == 3 {
                        PlayerOneParagon.ParagonPassword = passwordText
                        PasswordPhase = .playerTwo
                        PasswordTextfield.text = ""
                        setUpPasswordSetButtons()
                    } else {
                        AboveTextfieldLabel.text = "Enter 3-Digit Password!"
                        AboveTextfieldLabel.textColor = UIColor.yellow
                    }
                case .playerTwo:
                    if passwordText.count == 3 {
                        PlayerTwoParagon.ParagonPassword = passwordText
                        PasswordPhase = .complete
                        PasswordTextfield.text = ""
                        setUpPasswordSetButtons()
                    } else {
                        AboveTextfieldLabel.text = "Enter 3-Digit Password!"
                        AboveTextfieldLabel.textColor = UIColor.yellow
                    }
                case .complete:
                    return
                }
            } else {
                AboveTextfieldLabel.text = "Enter 3-Digit Password!"
                AboveTextfieldLabel.textColor = UIColor.yellow
            }
        }
    }
    
    @IBAction func pressPreviousButton(_ sender: UIButton) {
        switch PasswordPhase {
        case .playerOne:
            pressCancelButton()
        case .playerTwo:
            PasswordPhase = .playerOne
        case .complete:
            PasswordPhase = .playerTwo
        }
        setUpPasswordSetButtons()
    }
    
    @IBAction func pressCancelButton(_ sender: UIButton) {
        pressCancelButton()
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.isSecureTextEntry = false
    }
    
    func ifPasswordCorrect() -> Bool {
        if(PasswordAttemptTextfield.text == ParagonForPassword.ParagonPassword) {
            return true
        } else {
            PasswordAttemptLabel.textColor = UIColor.yellow
            PasswordAttemptLabel.text = "Enter Correct Password!"
            return false
        }
    }
    
    @objc func dismissKeyboard() {
        if PromptType == .passwordTry {
            if(PasswordAttemptTextfield.text == ParagonForPassword.ParagonPassword) {
                pressFightButton()
            } else {
                PasswordAttemptLabel.textColor = UIColor.yellow
                PasswordAttemptLabel.text = "Enter Correct Password!"
            }
        }
        view.endEditing(true)
    }
}
