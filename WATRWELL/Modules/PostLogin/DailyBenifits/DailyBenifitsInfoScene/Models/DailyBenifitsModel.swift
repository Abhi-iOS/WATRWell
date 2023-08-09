//
//  DailyBenifitsModel.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 29/07/23.
//

import Foundation
import UIKit

struct DailyBenifitsModel {
    let title: String
    var showGoNextButton: Bool
    let image: UIImage?
    let subtitle: String?
    
    init(title: String, showGoNextButton: Bool, image: UIImage?, subtitle: String?) {
        self.title = title
        self.showGoNextButton = showGoNextButton
        self.image = image
        self.subtitle = subtitle
    }
}

extension DailyBenifitsModel {
    static func getMasterData() -> [DailyBenifitsModel] {
        return [DailyBenifitsModel(title: "BENEFITS\nOF DAILY ELECTROLYTES", showGoNextButton: true, image: UIImage(named: "elc-db-intro"), subtitle: nil),
                DailyBenifitsModel(title: "BENEFITS\nOF DAILY HYDRATION", showGoNextButton: true, image: UIImage(named: "hyd-db-intro"), subtitle: nil),
                DailyBenifitsModel(title: "BENEFITS\nOF DAILY VITAMIN C", showGoNextButton: true, image: UIImage(named: "vit-db-intro"), subtitle: nil)]
    }
    
    static func getHydrationData() -> [DailyBenifitsModel] {
        return [DailyBenifitsModel(title: "BENEFITS\nOF DAILY HYDRATION", showGoNextButton: false, image: UIImage(named: "13"), subtitle: "cardiovascular health"),
                DailyBenifitsModel(title: "BENEFITS\nOF DAILY HYDRATION", showGoNextButton: false, image: UIImage(named: "6"), subtitle: "DETOXIFYING"),
                DailyBenifitsModel(title: "BENEFITS\nOF DAILY HYDRATION", showGoNextButton: false, image: UIImage(named: "7"), subtitle: "more energy"),
                DailyBenifitsModel(title: "BENEFITS\nOF DAILY HYDRATION", showGoNextButton: false, image: UIImage(named: "digestion"), subtitle: "HEALTHIER DIGESTION"),
                DailyBenifitsModel(title: "BENEFITS\nOF DAILY HYDRATION", showGoNextButton: false, image: UIImage(named: "11"), subtitle: "healthier skin"),
                DailyBenifitsModel(title: "BENEFITS\nOF DAILY HYDRATION", showGoNextButton: false, image: UIImage(named: "15"), subtitle: "promotes weight loss"),
                DailyBenifitsModel(title: "BENEFITS\nOF DAILY HYDRATION", showGoNextButton: false, image: UIImage(named: "14"), subtitle: "MENTAL CLARITY")]
    }
    
    static func getVitaminData() -> [DailyBenifitsModel] {
        return [DailyBenifitsModel(title: "BENEFITS\nOF DAILY VITAMIN C", showGoNextButton: false, image: UIImage(named: "1"), subtitle: "Anti-aging"),
                DailyBenifitsModel(title: "BENEFITS\nOF DAILY VITAMIN C", showGoNextButton: false, image: UIImage(named: "2"), subtitle: "anti-oxidants"),
                DailyBenifitsModel(title: "BENEFITS\nOF DAILY VITAMIN C", showGoNextButton: false, image: UIImage(named: "3"), subtitle: "increases oxygen intake"),
                DailyBenifitsModel(title: "BENEFITS\nOF DAILY VITAMIN C", showGoNextButton: false, image: UIImage(named: "4"), subtitle: "reduce risk of cancer"),
                DailyBenifitsModel(title: "BENEFITS\nOF DAILY VITAMIN C", showGoNextButton: false, image: UIImage(named: "5"), subtitle: "reduces inflamation"),
                DailyBenifitsModel(title: "BENEFITS\nOF DAILY VITAMIN C", showGoNextButton: false, image: UIImage(named: "6"), subtitle: "DETOXIFYING"),
                DailyBenifitsModel(title: "BENEFITS\nOF DAILY VITAMIN C", showGoNextButton: false, image: UIImage(named: "7"), subtitle: "more energy"),
                DailyBenifitsModel(title: "BENEFITS\nOF DAILY VITAMIN C", showGoNextButton: false, image: UIImage(named: "8"), subtitle: "reduces risk of stroke"),
                DailyBenifitsModel(title: "BENEFITS\nOF DAILY VITAMIN C", showGoNextButton: false, image: UIImage(named: "9"), subtitle: "enhances absorbation of iron"),
                DailyBenifitsModel(title: "BENEFITS\nOF DAILY VITAMIN C", showGoNextButton: false, image: UIImage(named: "10"), subtitle: "lowers cholestrol"),
                DailyBenifitsModel(title: "BENEFITS\nOF DAILY VITAMIN C", showGoNextButton: false, image: UIImage(named: "11"), subtitle: "healthier skin"),
                DailyBenifitsModel(title: "BENEFITS\nOF DAILY VITAMIN C", showGoNextButton: false, image: UIImage(named: "12"), subtitle: "helps body produce collagen"),
                DailyBenifitsModel(title: "BENEFITS\nOF DAILY VITAMIN C", showGoNextButton: false, image: UIImage(named: "13"), subtitle: "cardiovascular health")]
    }
    
    static func getElectrolyteData() -> [DailyBenifitsModel] {
        return [DailyBenifitsModel(title: "BENEFITS\nOF DAILY ELECTROLYTES", showGoNextButton: false, image: UIImage(named: "digestion"), subtitle: "HEALTHIER DIGESTION"),
                DailyBenifitsModel(title: "BENEFITS\nOF DAILY ELECTROLYTES", showGoNextButton: false, image: UIImage(named: "14"), subtitle: "MENTAL CLARITY"),
                DailyBenifitsModel(title: "BENEFITS\nOF DAILY ELECTROLYTES", showGoNextButton: false, image: UIImage(named: "13"), subtitle: "cardiovascular health"),
                DailyBenifitsModel(title: "BENEFITS\nOF DAILY ELECTROLYTES",showGoNextButton: false, image: UIImage(named: "5"), subtitle: "reduces inflamation"),
                DailyBenifitsModel(title: "BENEFITS\nOF DAILY ELECTROLYTES", showGoNextButton: false, image: UIImage(named: "7"), subtitle: "more energy")]
    }
}
