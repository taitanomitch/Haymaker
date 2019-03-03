//
//  CardCollectionViewCell.swift
//  Haymaker
//
//  Created by Mitchell Taitano on 11/14/18.
//  Copyright © 2018 Mitchell Taitano. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlet Variables
    @IBOutlet weak var CardValueLabel: UILabel!
    @IBOutlet weak var CardBackgroundView: UIView!
    @IBOutlet weak var CardEdgeView: UIView!
    @IBOutlet weak var CardSelectHighlightView: UIView!
    @IBOutlet weak var CardImageView: UIImageView!
    
    private var CardGreen: UIColor = ColorUtilities.hexUIColor(hex: "1DA15D")
    private var CardBlue: UIColor = ColorUtilities.hexUIColor(hex: "255BBC")
    private var CardRed: UIColor = ColorUtilities.hexUIColor(hex: "DD2726")
    private var CardPurple: UIColor = ColorUtilities.hexUIColor(hex: "8F31D8")
    private var CardBlack: UIColor = UIColor.black
    
    // MARK: - UI Variables
    var CardFontSize: CGFloat = 40
    var ImageAlpha: CGFloat = 0.7
    var DoomImageAlpha: CGFloat = 0.4
    
    // MARK: - Setup Functions
    func setUpCardCell(value: Int, type: ActionType) {
        CardEdgeView.layer.cornerRadius = 5.0
        CardEdgeView.layer.masksToBounds = true
        CardBackgroundView.layer.cornerRadius = 5.0
        CardBackgroundView.layer.masksToBounds = true
        CardSelectHighlightView.layer.cornerRadius = 5.0
        CardSelectHighlightView.layer.masksToBounds = true
        
        CardValueLabel.text = String(value)
        CardValueLabel.textColor = UIColor.white
        CardValueLabel.font = CardValueLabel.font.withSize(CardFontSize)
        CardImageView.alpha = ImageAlpha
        switch type {
        case .agility:
            CardBackgroundView.backgroundColor = CardRed
            CardImageView.image = UIImage(named: "Icon_Agility")
            CardImageView.tintColor = UIColor.black
        case .strength:
            CardBackgroundView.backgroundColor = CardGreen
            CardImageView.image = UIImage(named: "Icon_Strength")
            CardImageView.tintColor = UIColor.black
        case .intellect:
            CardBackgroundView.backgroundColor = CardBlue
            CardImageView.image = UIImage(named: "Icon_Intellect")
            CardImageView.tintColor = UIColor.black
        case .willpower:
            CardBackgroundView.backgroundColor = CardPurple
            CardImageView.image = UIImage(named: "Icon_Willpower")
            CardImageView.tintColor = UIColor.black
        case .doom:
            CardBackgroundView.backgroundColor = UIColor.black
            CardImageView.image = UIImage(named: "Icon_Doom")
            CardImageView.tintColor = UIColor.white
            CardImageView.alpha = DoomImageAlpha
        case .none:
            break
        }
        CardImageView.image = CardImageView.image!.withRenderingMode(.alwaysTemplate)
        
    }
    
    // MARK: - Card UI Functions
    public func highlightCard() {
        CardSelectHighlightView.backgroundColor = UIColor.yellow
    }
    
    public func unhighlightCard() {
        CardSelectHighlightView.backgroundColor = UIColor.clear
    }
}
