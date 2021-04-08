//
//  PlaySelectionMenuViewController.swift
//  Haymaker
//
//  Created by Mitchell Taitano on 4/7/21.
//  Copyright © 2021 Mitchell Taitano. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    @IBOutlet weak var PlayButton: UIButton!
    @IBOutlet weak var HerosJourneyButton: UIButton!
    @IBOutlet weak var ParagonCollectionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func pressPlayButton(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "HeroSelectController") as! HeroSelectController
        self.present(newViewController, animated: true) {
            
        }
    }
    
    @IBAction func pressHerosJourneyButton(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "HeroSelectController") as! HeroSelectController
        self.present(newViewController, animated: true) {
            
        }
    }
    
    @IBAction func pressParagonCollectionButton(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ParagonCollectionViewController") as! ParagonCollectionViewController
        self.present(newViewController, animated: true) {
            
        }
    }
    
}
