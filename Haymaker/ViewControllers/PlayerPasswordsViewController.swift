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
    
    @IBOutlet weak var PreviousButton: UIButton!
    @IBOutlet weak var NextButton: UIButton!
    @IBOutlet weak var CancelButton: UIButton!
    
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
        if PromptType == .paswordSet {
            let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
            view.addGestureRecognizer(tap)
        }
        
        switch PromptType {
        case .paswordSet:
            PasswordSetHolderView.alpha = 1.0
            PasswordEntryHolderView.alpha = 0.0
            setUpPasswordSetButtons()
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
            AttemptParagonImageView.image = UIImage(named: ParagonForPassword.Name)
        }
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
            PasswordAttemptLabel.textColor = UIColor.black
            PasswordAttemptLabel.text = "\(ParagonForPassword.Name): Enter Your Password:"
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
        switch PasswordPhase {
        case .playerOne:
            PasswordTextfield.isUserInteractionEnabled = true
            PlayerOnePasswordLabel.text = "\(PlayerOneParagon.Name): Setting Password..."
            PlayerTwoPasswordLabel.text = "\(PlayerTwoParagon.Name): Up Next"
            AboveTextfieldLabel.textColor = UIColor.black
            AboveTextfieldLabel.text = "Enter 3-Digit Password:"
        case .playerTwo:
            PasswordTextfield.isUserInteractionEnabled = true
            PlayerOnePasswordLabel.text = "\(PlayerOneParagon.Name): Ready To Fight!"
            PlayerTwoPasswordLabel.text = "\(PlayerTwoParagon.Name): Setting Password..."
            AboveTextfieldLabel.textColor = UIColor.black
            AboveTextfieldLabel.text = "Enter 3-Digit Password:"
        case .complete:
            PasswordTextfield.isUserInteractionEnabled = false
            PlayerOnePasswordLabel.text = "\(PlayerOneParagon.Name): Ready To Fight!"
            PlayerTwoPasswordLabel.text = "\(PlayerTwoParagon.Name): Ready To Fight!"
            AboveTextfieldLabel.textColor = UIColor.black
            AboveTextfieldLabel.text = "Password Setting Complete!"
        }
    }
    
    func setUpPasswordSetButtons() {
        switch PasswordPhase {
        case .playerOne:
            NextButton.setTitle("Set Password", for: .normal)
            NextButton.setBackgroundImage(UIImage(), for: .normal)
            NextButton.setTitleColor(UIColor.white, for: .normal)
            NextButton.backgroundColor = UIColor.blue
        case .playerTwo:
            NextButton.setTitle("Set Password", for: .normal)
            NextButton.setBackgroundImage(UIImage(), for: .normal)
            NextButton.setTitleColor(UIColor.white, for: .normal)
            NextButton.backgroundColor = UIColor.blue
        case .complete:
            NextButton.setTitle("", for: .normal)
            NextButton.setBackgroundImage(UIImage(named: "Fight"), for: .normal)
            NextButton.setTitleColor(UIColor.white, for: .normal)
            NextButton.backgroundColor = UIColor.clear
        }
        PreviousButton.setTitle("Previous", for: .normal)
        PreviousButton.setTitleColor(UIColor.white, for: .normal)
        PreviousButton.backgroundColor = UIColor.blue
        CancelButton.setTitle("Cancel", for: .normal)
        CancelButton.setTitleColor(UIColor.darkGray, for: .normal)
        CancelButton.backgroundColor = UIColor.lightGray
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
                        AboveTextfieldLabel.textColor = UIColor.red
                    }
                case .playerTwo:
                    if passwordText.count == 3 {
                        PlayerTwoParagon.ParagonPassword = passwordText
                        PasswordPhase = .complete
                        PasswordTextfield.text = ""
                        setUpPasswordSetButtons()
                    } else {
                        AboveTextfieldLabel.text = "Enter 3-Digit Password!"
                        AboveTextfieldLabel.textColor = UIColor.red
                    }
                case .complete:
                    return
                }
            } else {
                AboveTextfieldLabel.text = "Enter 3-Digit Password!"
                AboveTextfieldLabel.textColor = UIColor.red
            }
        }
    }
    
    @IBAction func pressPreviousButton(_ sender: UIButton) {
        switch PasswordPhase {
        case .playerOne:
            return
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
            PasswordAttemptLabel.textColor = UIColor.red
            PasswordAttemptLabel.text = "\(ParagonForPassword.Name) Enter Correct Password!"
            return false
        }
    }
    
    @objc func dismissKeyboard() {
        if PromptType == .passwordTry {
            if(PasswordAttemptTextfield.text == ParagonForPassword.ParagonPassword) {
                pressFightButton()
            } else {
                PasswordAttemptLabel.textColor = UIColor.red
                PasswordAttemptLabel.text = "\(ParagonForPassword.Name) Enter Correct Password!"
            }
        }
        view.endEditing(true)
    }
}
