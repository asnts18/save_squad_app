//
//  Utilities.swift
//  SaveSquadApp
//
//  Created by Abegail Santos on 11/6/24.
//

import Foundation
import UIKit

class Utilities{
    static let categories = ["Groceries", "Rent", "Transportation", "Utilities", "Restaurants", "Entertainment", "Other", "Personal"]
    static let frequencies = ["One-time", "Weekly", "Semi-monthly", "Monthly", "Annual"]
    
    static let purple = UIColor(hex: "#7b57fc")
    static let lightPurple = UIColor(hex: "#BDABFD")
    static let lightBlue = UIColor(hex: "#AAC5FD")
    
}


extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
