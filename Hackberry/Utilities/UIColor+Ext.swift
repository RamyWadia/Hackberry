//
//  UIColor+Ext.swift
//  Hackberry
//
//  Created by Ramy Atalla on 2020-11-28.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static let hackberryOrangePink = UIColor.rgb(red: 231, green: 123, blue: 103)
    static let hackberryPurble = UIColor.rgb(red: 65, green: 49, blue: 134)
}
