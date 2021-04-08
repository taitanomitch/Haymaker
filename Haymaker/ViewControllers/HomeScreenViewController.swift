//
//  ViewController.swift
//  Haymaker
//
//  Created by Mitchell Taitano on 11/13/18.
//  Copyright © 2018 Mitchell Taitano. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {

    @IBOutlet weak var PlayButton: UIButton!
    
    // MARK: - Loading Functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupPlayButton()
    }
    
    // MARK: - Setup Functions
    func setupPlayButton() {
        PlayButton.layer.cornerRadius = 6.0
        PlayButton.layer.borderWidth = 4.0
        PlayButton.layer.masksToBounds = true
        PlayButton.backgroundColor = UIColor.white
        PlayButton.layer.borderColor = UIColor.white.cgColor
        PlayButton.setTitleColor(UIColor.clear, for: .normal)
    }
    
    // MARK: - Button Functions
    @IBAction func pressPlayButton(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "MainMenuViewController") as! MainMenuViewController
        self.present(newViewController, animated: true) {
            
        }
    }
    
}

