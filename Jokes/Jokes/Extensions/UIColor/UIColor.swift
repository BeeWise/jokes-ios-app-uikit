//
//  UIColor.swift
//  Jokes
//
//  Created by Cristian Crasneanu on 14.07.2023.
//

import Foundation
import UIKit

extension UIColor {
    public convenience init(hex: Int) {
        self.init(hex: hex, alpha: 1)
    }

    public convenience init(hex: Int, alpha: CGFloat) {
        self.init(
            red: CGFloat((hex >> 16) & 0xff) / 255,
            green: CGFloat((hex >> 8) & 0xff) / 255,
            blue: CGFloat(hex & 0xff) / 255,
            alpha: alpha)
    }
}
