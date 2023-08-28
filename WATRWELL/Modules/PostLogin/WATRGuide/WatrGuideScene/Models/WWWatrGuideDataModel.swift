//
//  WWWatrGuideDataModel.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 09/08/23.
//

import Foundation

struct WWWatrGuideDataModel {
    let title: NSAttributedString?
    let leftTitle1: String
    let leftTitle2: String
    let leftTitle3: String
    let rightValue1: NSAttributedString?
    let rightValue2: NSAttributedString?
    let rightValue3: NSAttributedString?
}

extension WWWatrGuideDataModel {
    static func getDataSource() -> [WWWatrGuideDataModel] {
        return [WWWatrGuideDataModel(title: "Achieve Daily Hydration".uppercased().applyColor(to: [("Hydration", WWColors.hex203D75)],
                                                                                              font: WWFonts.europaRegular.withSize(17)),
                                     leftTitle1: "\tBelow 200 Lbs:",
                                     leftTitle2: "\t200 to 300 Lbs:",
                                     leftTitle3: "\tAbove 300 Lbs:",
                                     rightValue1: getRightValue(with: "4", colorType: .hex203D75),
                                     rightValue2: getRightValue(with: "6", colorType: .hex203D75),
                                     rightValue3: getRightValue(with: "8", colorType: .hex203D75)),
                WWWatrGuideDataModel(title: "Achieve Daily Immunity".uppercased().applyColor(to: [("Immunity", WWColors.hexDF5509)],
                                                                                             font: WWFonts.europaRegular.withSize(17)),
                                         leftTitle1: "Anyone below age 18:",
                                         leftTitle2: "Women:",
                                         leftTitle3: "Men:",
                                        rightValue1: getRightValue(with: "2", colorType: .hexDF5509),
                                        rightValue2: getRightValue(with: "3", colorType: .hexDF5509),
                                        rightValue3: getRightValue(with: "4", colorType: .hexDF5509)),
                WWWatrGuideDataModel(title: "Achieve Daily Anti-Aging".uppercased().applyColor(to: [("Anti-Aging", WWColors.hexB3E6B5)],
                                                                                               font: WWFonts.europaRegular.withSize(17)),
                                     leftTitle1: "Anyone below age 18:",
                                     leftTitle2: "Women:",
                                     leftTitle3: "Men:",
                                    rightValue1: getRightValue(with: "1", colorType: .hexB3E6B5),
                                    rightValue2: getRightValue(with: "2", colorType: .hexB3E6B5),
                                    rightValue3: getRightValue(with: "2", colorType: .hexB3E6B5))
        ]
    }
    
    private static func getRightValue(with oz: String, colorType: WWColors) -> NSAttributedString? {
        let string = "DRINK \(oz)"
        let attributedString = NSMutableAttributedString(string: string,
                                                         attributes: [.font: WWFonts.europaBold.withSize(13),
                                                            .foregroundColor: colorType.color])
        
        let range = (string as NSString).range(of: oz.uppercased())
        let attr: [NSAttributedString.Key: Any] = [.foregroundColor: WWColors.hex000000.color,
                                                   .font: WWFonts.europaBold.withSize(20)]
        attributedString.addAttributes(attr, range: range)
        return attributedString
        
    }

}
