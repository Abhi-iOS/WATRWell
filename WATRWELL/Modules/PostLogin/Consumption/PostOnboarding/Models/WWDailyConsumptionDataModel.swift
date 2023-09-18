//
//  WWDailyConsumptionDataModel.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 20/08/23.
//

import UIKit

protocol WWDailyConsumptionType {
    var title: NSAttributedString? { get }
    var image: UIImage? { get }
    var desc1Text: NSAttributedString? { get }
    var desc2Text: NSAttributedString? { get }
}

struct WWDailyConsumptionDataModel: Decodable {
    var immunity: Immunity?
    var electrolytes: Electrolytes?
    var antiAging: AntiAging?
    
    enum CodingKeys: String, CodingKey {
        case immunity = "immunity"
        case electrolytes = "electrolytes"
        case antiAging = "anti_aging"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        immunity = try? container.decodeIfPresent(Immunity.self, forKey: .immunity)
        electrolytes = try? container.decodeIfPresent(Electrolytes.self, forKey: .electrolytes)
        antiAging = try? container.decodeIfPresent(AntiAging.self, forKey: .antiAging)
    }
}

struct Electrolytes: Decodable, WWDailyConsumptionType {
    var title: NSAttributedString? {
        "Your Daily Hydration".uppercased().applyColor(to: [("Hydration".uppercased(), .hex203D75)],
                                                                                          font: WWFonts.europaRegular.withSize(17))
    }
    
    var image: UIImage? {
        UIImage(named: "body_blue")
    }
    
    var desc1Text: NSAttributedString? {
        getAttrStringConumption(title: nil, consumption: electrolytes ?? "")
    }
    
    var desc2Text: NSAttributedString? { nil}
    
    let electrolytes: String?

}

struct Immunity: Decodable, WWDailyConsumptionType {
    var title: NSAttributedString? {
        "Your Daily Immunity".uppercased().applyColor(to: [("Immunity".uppercased(), .hexDF5509)],
                                                                                         font: WWFonts.europaRegular.withSize(17))
    }
    
    var image: UIImage? {
        UIImage(named: "body_orange")
    }
    
    var desc1Text: NSAttributedString? {
        getAttrStringConumption(title: "Vitamin C: ".uppercased(), consumption: vitaminC ?? "")
    }
    
    var desc2Text: NSAttributedString? { nil }
    
    let vitaminC: String?
    
    enum CodingKeys: String, CodingKey {
        case vitaminC = "vitamin_c"
    }
}

struct AntiAging: Decodable, WWDailyConsumptionType {
    var title: NSAttributedString? {
        "Your Daily ANTI-AGING".uppercased().applyColor(to: [("ANTI-AGING", .hexB3E6B5)],
                                                                                           font: WWFonts.europaRegular.withSize(17))
    }
    
    var image: UIImage? {
        UIImage(named: "body_green")
    }
    
    var desc1Text: NSAttributedString? {
        getAttrStringConumption(title: "collagen: ".uppercased(), consumption: collagen ?? "")
    }
    
    var desc2Text: NSAttributedString? {
        getAttrStringConumption(title: "resveratrol: ".uppercased(), consumption: resveratrol ?? "")
    }
    
    let resveratrol: String?
    let collagen: String?
}

func getAttrStringConumption(title: String?, consumption: String) -> NSAttributedString? {
    let string = (title ?? "").uppercased() + consumption
    let attributedString = NSMutableAttributedString(string: string,
                                                     attributes: [.font: WWFonts.europaLight.withSize(13)])
    let boldFontAttribute: [NSAttributedString.Key: Any] = [.font: WWFonts.europaRegular.withSize(13)]
        let range = (string as NSString).range(of: consumption)
        attributedString.addAttributes(boldFontAttribute, range: range)
    return attributedString
}
