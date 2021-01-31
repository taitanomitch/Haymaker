//
//  Utility.swift
//  Haymaker
//
//  Created by Mitchell Taitano on 11/18/18.
//  Copyright © 2018 Mitchell Taitano. All rights reserved.
//

import Foundation
import UIKit

class ColorUtilities {
    
    public static var GreenStrength: UIColor = ColorUtilities.hexUIColor(hex: "1DA15D")
    public static var BlueIntellect: UIColor = ColorUtilities.hexUIColor(hex: "255BBC")
    public static var RedAgility: UIColor = ColorUtilities.hexUIColor(hex: "DD2726")
    public static var PurpleWillpower: UIColor = ColorUtilities.hexUIColor(hex: "8F31D8")
    public static var BlackDoom: UIColor = UIColor.black

    static func hexUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
