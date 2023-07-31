//
//  WWColors.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 25/07/23.
//

import UIKit

extension UIColor {
    convenience init(hexString:String) {
        let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
            
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
    
    var hexString: String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return NSString(format:"#%06x", rgb) as String
    }
}

enum WWColors: String {
    // It's mandatory to add `hex` prefix for adding color with hexCodes.
    // Otherwise declare the color in color asset and use named colors
    case carbon
    case menuBG
    case hexDF5509 // app orange
    case hexFFFFFF // app white
    case hex000000 // app black
    case hexD9D9D9 // light gray
    case hex203D75 // watrBlue
    case hexB3E6B5 // watrGreen
    
    
    private var hexValue: String {
        return rawValue.replacingOccurrences(of: "hex", with: "")
    }
    
    var color : UIColor {
        // fallback to systemIndigo to make it fail safe while developing
        if rawValue.hasPrefix("hex") {
            return UIColor(hexString: self.hexValue)
        } else {
            return UIColor(named: rawValue)!
        }
    }
}
