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
}

class PlayerPasswordsViewController: UIViewController {
    
    enum PlayerPasswordPhases {
        case playerOne
        case playerTwo
        case complete
    }

    // MARK: - IBOutlet Variables
    @IBOutlet weak var PreviousButton: UIButton!
    @IBOutlet weak var NextButton: UIButton!
    @IBOutlet weak var CancelButton: UIButton!
    
    
    // MARK: - Variables
    public var delegate: PlayerPasswordDelegate?
    var PasswordPhase: PlayerPasswordPhases = .playerOne
    
    
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
        setUpButtons()
    }
    
    func setUpInitialValues() {
        PasswordPhase = .playerOne
    }
    
    func setUpButtons() {
        switch PasswordPhase {
        case .playerOne:
            NextButton.setTitle("PLAYER ONE", for: .normal)
            NextButton.setBackgroundImage(UIImage(), for: .normal)
            NextButton.setTitleColor(UIColor.white, for: .normal)
            NextButton.backgroundColor = UIColor.blue
        case .playerTwo:
            NextButton.setTitle("PLAYER TWO", for: .normal)
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
        switch PasswordPhase {
        case .playerOne:
            PasswordPhase = .playerTwo
        case .playerTwo:
            PasswordPhase = .complete
        case .complete:
            pressFightButton()
        }
        setUpButtons()
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
}
