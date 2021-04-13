//
//  ParagonOptionCollectionViewCell.swift
//  Haymaker
//
//  Created by Mitchell Taitano on 12/3/18.
//  Copyright © 2018 Mitchell Taitano. All rights reserved.
//

import UIKit

class ParagonOptionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ParagonIconImageView: UIImageView!
    @IBOutlet weak var CellBackgroundView: UIView!
    
    func setUpParagonOptionCell(paragon: ParagonOverseer) {
        ParagonIconImageView.image = UIImage(named: "\(paragon.Image)")
        ParagonIconImageView.tintColor = UIColor.black
        ParagonIconImageView.backgroundColor = UIColor.clear
        CellBackgroundView.backgroundColor = UIColor.clear
        CellBackgroundView.layer.cornerRadius = 4.0
        CellBackgroundView.layer.masksToBounds = true
    }
}
