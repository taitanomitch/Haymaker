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
}

class PlayerPasswordsViewController: UIViewController, UITextFieldDelegate {
    
    enum PlayerPasswordPhases {
        case playerOne
        case playerTwo
        case complete
    }

    // MARK: - IBOutlet Variables
    @IBOutlet weak var PreviousButton: UIButton!
    @IBOutlet weak var NextButton: UIButton!
    @IBOutlet weak var CancelButton: UIButton!
    
    @IBOutlet weak var PlayerOnePasswordLabel: UILabel!
    @IBOutlet weak var PlayerTwoPasswordLabel: UILabel!
    @IBOutlet weak var AboveTextfieldLabel: UILabel!
    @IBOutlet weak var PasswordTextfield: UITextField!
    
    // MARK: - Variables
    public var delegate: PlayerPasswordDelegate?
    var PasswordPhase: PlayerPasswordPhases = .playerOne
    var passwordOne: String = ""
    var passwordTwo: String = ""
    
    
    // MARK: - Loading Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        runSetup()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    // MARK: - Setup Functions
    func runSetup() {
        setUpButtons()
    }
    
    func setUpInitialValues() {
        PasswordPhase = .playerOne
    }
    
    func setUpLabels() {
        switch PasswordPhase {
        case .playerOne:
            PasswordTextfield.isUserInteractionEnabled = true
            PlayerOnePasswordLabel.text = "Player 1: Setting Password..."
            PlayerTwoPasswordLabel.text = "Player 2: Up Next"
            AboveTextfieldLabel.textColor = UIColor.black
            AboveTextfieldLabel.text = "Enter 3-Digit Password:"
        case .playerTwo:
            PasswordTextfield.isUserInteractionEnabled = true
            PlayerOnePasswordLabel.text = "Player 1: Ready To Fight!"
            PlayerTwoPasswordLabel.text = "Player 2: Setting Password..."
            AboveTextfieldLabel.textColor = UIColor.black
            AboveTextfieldLabel.text = "Enter 3-Digit Password:"
        case .complete:
            PasswordTextfield.isUserInteractionEnabled = false
            PlayerOnePasswordLabel.text = "Player 1: Ready To Fight!"
            PlayerTwoPasswordLabel.text = "Player 2: Ready To Fight!"
            AboveTextfieldLabel.textColor = UIColor.black
            AboveTextfieldLabel.text = "Password Setting Complete!"
        }
    }
    
    func setUpButtons() {
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
        delegate?.PasswordsSet(passwordOne: passwordOne, passwordTwo: passwordTwo)
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
                        passwordOne = passwordText
                        PasswordPhase = .playerTwo
                        PasswordTextfield.text = ""
                        setUpButtons()
                    } else {
                        AboveTextfieldLabel.text = "Enter 3-Digit Password!"
                        AboveTextfieldLabel.textColor = UIColor.red
                    }
                case .playerTwo:
                    if passwordText.count == 3 {
                        passwordTwo = passwordText
                        PasswordPhase = .complete
                        PasswordTextfield.text = ""
                        setUpButtons()
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
        setUpButtons()
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
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
