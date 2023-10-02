//
//  WWDiscoverDataModel.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 30/07/23.
//

import Foundation
import UIKit

struct WWDiscoverDataModel {
    var title: String?
    var descText: NSAttributedString?
    var logoTint: UIColor?
    var buttonLogo: UIImage?
    
    static let coloredStrInfo = [("+ ELECTROLYTES", WWColors.hex203D75), ("+IMMUNITY", WWColors.hexDF5509), ("+ANTI-AGING", WWColors.hexB3E6B5)]
}



extension WWDiscoverDataModel {
    static func getDataArray() -> [WWDiscoverDataModel] {
        return [WWDiscoverDataModel(title: "WILLŌ",
                                    descText: "Meet WILLŌ.\nWILLŌ was born to advance the mission of WATR by providing a higher quality daily drinking water supply to communities. WILLŌ is designed specifically to maintain the appeal of community parks and natural public areas.   Being powered by solar energy, She is self sufficient. SHe interacts with the WATRWELL app in dispensing 5x purified drinking water enhanced with either electrolytes (+ ELECTROLYTES), VITAMIN C (+IMMUNITY), or Collagen + resveratrol (+ANTI-AGING).".uppercased().applyColor(to: coloredStrInfo,
                                                                                                                                                                                                                                                                                 font: WWFonts.europaLight.withSize(12),
                                                                                                                                                                                                                                                                                 applyParaStyle: true)?
            .boldString(value: "WILLŌ"),
                                    logoTint: nil,
                                    buttonLogo: UIImage(named: "discover_willo")),
                WWDiscoverDataModel(title: "CACTUS",
                                    descText: "MEET CACTUS.\nCACTUS was born to advance the mission of WATR by providing higher quality daily drinking water supply to communities. CACTUS is uniquely designed to fit within more urban areas, yet can also advance the aesthetic of natural public areas.\n\nBeing powered by solar energy, he is self sufficient. He interacts with the WATRWELL  app in dispensing 5x purified drinking water enhanced with either electrolytes(+ ELECTROLYTES), VITAMIN C (+IMMUNITY), or Collagen + resveratrol (+ANTI-AGING).".uppercased().applyColor(to: coloredStrInfo,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           font: WWFonts.europaLight.withSize(12),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           applyParaStyle: true)?
                    .boldString(value: "CACTUS"),
                                    logoTint: nil,
                                    buttonLogo: UIImage(named: "discover_cactus")),
                WWDiscoverDataModel(title: "+ELECTROLYTES",
                                    descText: electrolyteAttrString(),
                                    logoTint: WWColors.hex203D75.color,
                                    buttonLogo: nil),
                WWDiscoverDataModel(title: "+IMMUNITY",
                                    descText: immunityAttrString(),
                                    logoTint: WWColors.hexDF5509.color,
                                    buttonLogo: nil),
                WWDiscoverDataModel(title: "+ANTI-AGING",
                                    descText: antiagingAttrString(),
                                    logoTint: WWColors.hexB3E6B5.color,
                                    buttonLogo: nil),
                WWDiscoverDataModel(title: "SUSTAINABILITY",
                                    descText: sustainAttrString(),
                                    logoTint: nil,
                                    buttonLogo: nil)
        ]
    }
    
    
    private static func electrolyteAttrString() -> NSAttributedString? {
        let string =
"""
Servings dispensed from WILLŌ or CACTUS, are measured in 20oz intervals.
Each 20oz serving of + ELECTROLYTES  contains the following:

5x Purified Water with a 7.7+ ph
33mg Magnesium
11mg Sodium (Pink Himalayan Salt)
2mg Calcium
57mg Potassium
""".uppercased().replacingOccurrences(of: "OZ", with: "oz").replacingOccurrences(of: "PH", with: "ph").replacingOccurrences(of: "MG", with: "mg").replacingOccurrences(of: "5X", with: "5x")
        let boldTexts = ["+ ELECTROLYTES", "WILLŌ OR CACTUS", "20oz", "5x PURIFIED", "7.7+ ph", "33mg", "11mg", "2mg", "57mg"]
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1
        paragraphStyle.lineHeightMultiple = 1.5
        let attributedString = NSMutableAttributedString(string: string,
                                                         attributes: [.font: WWFonts.europaLight.withSize(13),
                                                                      .paragraphStyle: paragraphStyle])
        let boldFontAttribute: [NSAttributedString.Key: Any] = [.font: WWFonts.europaRegular.withSize(13)]
        boldTexts.forEach { boldString in
            let range = (string as NSString).range(of: boldString)
            attributedString.addAttributes(boldFontAttribute, range: range)
        }
        return attributedString
    }
    
    private static func immunityAttrString() -> NSAttributedString? {
        let string =
"""
Servings dispensed from WILLŌ or CACTUS, are measured in 20oz intervals.
Each 20oz serving of + IMMUNITY contains the following:

5x Purified Water with a 7.7+ ph
33mg Magnesium
11mg Sodium (Pink Himalayan Salt)
2mg Calcium
57mg Potassium
33mg of VITAMIN C
""".uppercased().replacingOccurrences(of: "OZ", with: "oz").replacingOccurrences(of: "PH", with: "ph").replacingOccurrences(of: "MG", with: "mg").replacingOccurrences(of: "5X", with: "5x")
        let boldTexts = ["+ IMMUNITY", "WILLŌ OR CACTUS", "20oz", "5x PURIFIED", "7.7+ ph", "33mg", "11mg", "2mg", "57mg"]
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1
        paragraphStyle.lineHeightMultiple = 1.5
        let attributedString = NSMutableAttributedString(string: string,
                                                         attributes: [.font: WWFonts.europaLight.withSize(13),
                                                                      .paragraphStyle: paragraphStyle])
        let boldFontAttribute: [NSAttributedString.Key: Any] = [.font: WWFonts.europaRegular.withSize(13)]
        boldTexts.forEach { boldString in
            let range = (string as NSString).range(of: boldString)
            attributedString.addAttributes(boldFontAttribute, range: range)
        }
        return attributedString
    }
    
    private static func antiagingAttrString() -> NSAttributedString? {
        let string =
"""
Servings dispensed from WILLŌ or CACTUS, are measured in 20oz intervals.
So, each 20oz serving of + ANTI-AGING  contains the following: 

5x Purified Water with a 7.7+ ph
33mg Magnesium
11mg Sodium (Pink Himalayan Salt)
2mg Calcium
57mg Potassium
10g of  Collagen
500mg of Resveratrol
""".uppercased().replacingOccurrences(of: "OZ", with: "oz").replacingOccurrences(of: "PH", with: "ph").replacingOccurrences(of: "MG", with: "mg").replacingOccurrences(of: "5X", with: "5x").replacingOccurrences(of: "10G", with: "10g")
        let boldTexts = ["+ ANTI-AGING", "WILLŌ OR CACTUS", "20oz", "5x PURIFIED", "7.7+ ph", "33mg", "11mg", "2mg", "57mg", "10g", "500mg"]
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1
        paragraphStyle.lineHeightMultiple = 1.5
        let attributedString = NSMutableAttributedString(string: string,
                                                         attributes: [.font: WWFonts.europaLight.withSize(13),
                                                                      .paragraphStyle: paragraphStyle])
        let boldFontAttribute: [NSAttributedString.Key: Any] = [.font: WWFonts.europaRegular.withSize(13)]
        boldTexts.forEach { boldString in
            let range = (string as NSString).range(of: boldString)
            attributedString.addAttributes(boldFontAttribute, range: range)
        }
        return attributedString
    }
    
    private static func sustainAttrString() -> NSAttributedString? {
        let string =
"""
ONCE WE REACH 50,000 USERS WE WILL BUILD OUT THE SUSTAINABILITY IMPACT PROFILE.

WE WILL SUPPORT COMMUNITIES IN BECOMING 100% SUSTAINABLE IN THIS CATEGORY.
""".uppercased()
        let boldTexts = ["50,000 USERS", "100%"]
        let attributedString = NSMutableAttributedString(string: string,
                                                         attributes: [.font: WWFonts.europaLight.withSize(13)])
        let boldFontAttribute: [NSAttributedString.Key: Any] = [.font: WWFonts.europaRegular.withSize(13)]
        boldTexts.forEach { boldString in
            let range = (string as NSString).range(of: boldString.uppercased())
            attributedString.addAttributes(boldFontAttribute, range: range)
        }
        return attributedString
    }
}
