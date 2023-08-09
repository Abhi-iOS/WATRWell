//
//  WWSourcePopupDataModel.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 04/08/23.
//

import Foundation

struct WWSourcePopupDataModel {
    enum VisibleIconType {
        case all
        case electrolyte
        case immunity
        case antiAging
    }
    
    var showIconType: VisibleIconType
    var titleText: NSAttributedString?
    var descriptionText: NSAttributedString?
}

extension WWSourcePopupDataModel {
    static var allWatrSourceArr: [WWSourcePopupDataModel] {
        return [WWSourcePopupDataModel(showIconType: .all,
                                       titleText: nil,
                                       descriptionText: allWatrAttrString()),
                WWSourcePopupDataModel(showIconType: .electrolyte,
                                       titleText: attributedTitleText("ELECTROLYTE"),
                                       descriptionText: electroLyteAttrString()),
                WWSourcePopupDataModel(showIconType: .immunity,
                                       titleText: attributedTitleText("IMMUNITY"),
                                       descriptionText: immunityAttrString()),
                WWSourcePopupDataModel(showIconType: .antiAging,
                                       titleText: attributedTitleText("ANTI-AGING"),
                                       descriptionText: antiagingAttrString())
        ]
    }
    
    static var electrolyteWatrSourceArr: [WWSourcePopupDataModel] {
        return [WWSourcePopupDataModel(showIconType: .electrolyte,
                                       descriptionText: onlyElectrolyteAttrString()),
                WWSourcePopupDataModel(showIconType: .electrolyte,
                                       titleText: attributedTitleText("ELECTROLYTE"),
                                       descriptionText: electroLyteAttrString())
        ]
    }
    
    
    private static func allWatrAttrString() -> NSAttributedString? {
        let string =
"""
WITH THIS SOURCE YOU ARE GRANTED UNLIMITED ACCESS TO BOTH WILLO AND CACTUS, FOR  THE 5x PURIFIED +ELECTROLYTE FORMULA, + IMMUNITY FORMULA, AND +ANTI-AGING FORMULA.
                                       
SWIPE LEFT TO SEE WHAT EACH 20oz SERVING CONTAINS.
"""
        let boldTexts = ["UNLIMITED ACCESS", "SWIPE LEFT TO SEE WHAT EACH 20oz SERVING CONTAINS."]
        let attributedString = NSMutableAttributedString(string: string,
                                                         attributes: [.font: WWFonts.europaLight.withSize(13)])
        let boldFontAttribute: [NSAttributedString.Key: Any] = [.font: WWFonts.europaRegular.withSize(13)]
        boldTexts.forEach { boldString in
            let range = (string as NSString).range(of: boldString)
            attributedString.addAttributes(boldFontAttribute, range: range)
        }
        return attributedString
    }
    
    private static func attributedTitleText(_ title: String) -> NSAttributedString? {
        let string =
"""
+ \(title)
                                               
Servings dispensed from WILLO or CACTUS, are measured in 20oz intervals.
""".uppercased()
        let boldTexts = [title, "WILLO or CACTUS", "20oz"]
        let attributedString = NSMutableAttributedString(string: string,
                                                         attributes: [.font: WWFonts.europaLight.withSize(13)])
        let boldFontAttribute: [NSAttributedString.Key: Any] = [.font: WWFonts.europaRegular.withSize(13)]
        boldTexts.forEach { boldString in
            let range = (string as NSString).range(of: boldString.uppercased())
            attributedString.addAttributes(boldFontAttribute, range: range)
        }
        return attributedString
        
    }
    
    private static func electroLyteAttrString() -> NSAttributedString? {
        let string =
"""
Each 20oz serving of +ELECTROLYTES  contains the following:

5x Purified Water with a 7.7+ ph

33mg Magnesium

11mg Sodium (Pink Himalayan Salt)

2mg Calcium

57mg Potassium
""".uppercased()
        let boldTexts = ["+ ELECTROLYTES", "WILLO or CACTUS", "20oz", "5x Purified", "7.7+ ph", "33mg", "11mg", "2mg", "57mg"]
        let attributedString = NSMutableAttributedString(string: string,
                                                         attributes: [.font: WWFonts.europaLight.withSize(13)])
        let boldFontAttribute: [NSAttributedString.Key: Any] = [.font: WWFonts.europaRegular.withSize(13)]
        boldTexts.forEach { boldString in
            let range = (string as NSString).range(of: boldString.uppercased())
            attributedString.addAttributes(boldFontAttribute, range: range)
        }
        return attributedString
    }
    
    private static func immunityAttrString() -> NSAttributedString? {
        let string =
"""
Each 20oz serving of + IMMUNITY contains the following:

5x Purified Water with a 7.7+ ph

33mg Magnesium

11mg Sodium (Pink Himalayan Salt)

2mg Calcium

57mg Potassium

33mg of VITAMIN C
""".uppercased()
        let boldTexts = ["+ IMMUNITY", "WILLO or CACTUS", "20oz", "5x Purified", "7.7+ ph", "33mg", "11mg", "2mg", "57mg"]
        let attributedString = NSMutableAttributedString(string: string,
                                                         attributes: [.font: WWFonts.europaLight.withSize(13)])
        let boldFontAttribute: [NSAttributedString.Key: Any] = [.font: WWFonts.europaRegular.withSize(13)]
        boldTexts.forEach { boldString in
            let range = (string as NSString).range(of: boldString.uppercased())
            attributedString.addAttributes(boldFontAttribute, range: range)
        }
        return attributedString
    }
    
    private static func antiagingAttrString() -> NSAttributedString? {
        let string =
"""
So, each 20oz serving of + ANTI-AGING  contains the following: 

5x Purified Water with a 7.7+ ph

33mg Magnesium

11mg Sodium (Pink Himalayan Salt)

2mg Calcium

57mg Potassium

10g of  Collagen

500mg of Resveratrol
""".uppercased()
        let boldTexts = ["+ ANTI-AGING", "WILLO or CACTUS", "20oz", "5x Purified", "7.7+ ph", "33mg", "11mg", "2mg", "57mg", "10g", "500mg"]
        let attributedString = NSMutableAttributedString(string: string,
                                                         attributes: [.font: WWFonts.europaLight.withSize(13)])
        let boldFontAttribute: [NSAttributedString.Key: Any] = [.font: WWFonts.europaRegular.withSize(13)]
        boldTexts.forEach { boldString in
            let range = (string as NSString).range(of: boldString.uppercased())
            attributedString.addAttributes(boldFontAttribute, range: range)
        }
        return attributedString
    }
    
    private static func onlyElectrolyteAttrString() -> NSAttributedString? {
        let string =
"""
WITH THIS SOURCE YOU ARE GRANTED UNLIMITED ACCESS TO BOTH WILLO AND CACTUS, FOR ONLY THE 5x PURE WATER + ELECTROLYTE FORMULA.
                                       
SWIPE LEFT TO SEE WHAT EACH 20oz SERVING CONTAINS.
"""
        let boldTexts = ["UNLIMITED ACCESS", "SWIPE LEFT TO SEE WHAT EACH 20oz SERVING CONTAINS."]
        let attributedString = NSMutableAttributedString(string: string,
                                                         attributes: [.font: WWFonts.europaLight.withSize(13)])
        let boldFontAttribute: [NSAttributedString.Key: Any] = [.font: WWFonts.europaRegular.withSize(13)]
        boldTexts.forEach { boldString in
            let range = (string as NSString).range(of: boldString)
            attributedString.addAttributes(boldFontAttribute, range: range)
        }
        return attributedString
    }
}
