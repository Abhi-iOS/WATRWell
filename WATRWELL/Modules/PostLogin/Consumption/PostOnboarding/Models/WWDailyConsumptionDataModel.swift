//
//  WWDailyConsumptionDataModel.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 20/08/23.
//

import UIKit

struct WWDailyConsumptionDataModel {
    let title: NSAttributedString?
    let image: UIImage?
    let desc1Text: NSAttributedString?
    let desc2Text: NSAttributedString?
}

extension WWDailyConsumptionDataModel {
    static func getDataModels() -> [WWDailyConsumptionDataModel] {
        return [
            WWDailyConsumptionDataModel(title: "Your Daily Hydration".uppercased().applyColor(to: [("Hydration".uppercased(), .hex203D75)],
                                                                                              font: WWFonts.europaRegular.withSize(17)),
                                        image: UIImage(named: "body_blue"),
                                        desc1Text: getAttrStringConumption(title: nil, consumption: "0 oz"),
                                        desc2Text: nil),
            WWDailyConsumptionDataModel(title: "Your Daily Immunity".uppercased().applyColor(to: [("Immunity".uppercased(), .hexDF5509)],
                                                                                             font: WWFonts.europaRegular.withSize(17)),
                                        image: UIImage(named: "body_orange"),
                                        desc1Text: getAttrStringConumption(title: "Vitamin C: ".uppercased(), consumption: "0 mg"),
                                        desc2Text: nil),
            WWDailyConsumptionDataModel(title: "Your Daily ANTI-AGING".uppercased().applyColor(to: [("ANTI-AGING", .hexB3E6B5)],
                                                                                               font: WWFonts.europaRegular.withSize(17)),
                                        image: UIImage(named: "body_green"),
                                        desc1Text: getAttrStringConumption(title: "collagen: ".uppercased(), consumption: "0 mg"),
                                        desc2Text: getAttrStringConumption(title: "resveratrol: ".uppercased(), consumption: "0 mg"))
        ]
    }
    
    private static func getAttrStringConumption(title: String?, consumption: String) -> NSAttributedString? {
        let string = (title ?? "").uppercased() + consumption
        let attributedString = NSMutableAttributedString(string: string,
                                                         attributes: [.font: WWFonts.europaLight.withSize(13)])
        let boldFontAttribute: [NSAttributedString.Key: Any] = [.font: WWFonts.europaRegular.withSize(13)]
            let range = (string as NSString).range(of: consumption)
            attributedString.addAttributes(boldFontAttribute, range: range)
        return attributedString
    }
}
