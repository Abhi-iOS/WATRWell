//
//  WWFonts.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 30/07/23.
//

import UIKit

enum WWFonts : String {
    case europaBold = "Europa-Bold"
    case europaLight = "Europa-Light"
    case europaRegular = "Europa-Regular"

}

extension WWFonts {
    func withSize(_ fontSize: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
    
    func withDefaultSize() -> UIFont {
        return UIFont(name: self.rawValue, size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)
    }
}
