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
        return [DailyBenifitsModel(title: "BENEFITS\nOF DAILY HYDRATION", showGoNextButton: false, image: UIImage(named: "cardio"), subtitle: "CARDIOVASCULAR HEALTH"),
                DailyBenifitsModel(title: "BENEFITS\nOF DAILY HYDRATION", showGoNextButton: false, image: UIImage(named: "cardio"), subtitle: "CARDIOVASCULAR HEALTH"),
                DailyBenifitsModel(title: "BENEFITS\nOF DAILY HYDRATION", showGoNextButton: false, image: UIImage(named: "cardio"), subtitle: "CARDIOVASCULAR HEALTH"),
                DailyBenifitsModel(title: "BENEFITS\nOF DAILY HYDRATION", showGoNextButton: false, image: UIImage(named: "cardio"), subtitle: "CARDIOVASCULAR HEALTH"),
                DailyBenifitsModel(title: "BENEFITS\nOF DAILY HYDRATION", showGoNextButton: false, image: UIImage(named: "cardio"), subtitle: "CARDIOVASCULAR HEALTH"),
                DailyBenifitsModel(title: "BENEFITS\nOF DAILY HYDRATION", showGoNextButton: false, image: UIImage(named: "cardio"), subtitle: "CARDIOVASCULAR HEALTH"),
                DailyBenifitsModel(title: "BENEFITS\nOF DAILY HYDRATION", showGoNextButton: false, image: UIImage(named: "cardio"), subtitle: "CARDIOVASCULAR HEALTH")]
    }
    
    static func getVitaminData() -> [DailyBenifitsModel] {
        return [DailyBenifitsModel(title: "BENEFITS\nOF DAILY VITAMIN C", showGoNextButton: false, image: UIImage(named: "detox"), subtitle: "DETOXIFYING"),
                DailyBenifitsModel(title: "BENEFITS\nOF DAILY VITAMIN C", showGoNextButton: false, image: UIImage(named: "detox"), subtitle: "DETOXIFYING"),
                DailyBenifitsModel(title: "BENEFITS\nOF DAILY VITAMIN C", showGoNextButton: false, image: UIImage(named: "detox"), subtitle: "DETOXIFYING"),
                DailyBenifitsModel(title: "BENEFITS\nOF DAILY VITAMIN C", showGoNextButton: false, image: UIImage(named: "detox"), subtitle: "DETOXIFYING"),
                DailyBenifitsModel(title: "BENEFITS\nOF DAILY VITAMIN C", showGoNextButton: false, image: UIImage(named: "detox"), subtitle: "DETOXIFYING"),
                DailyBenifitsModel(title: "BENEFITS\nOF DAILY VITAMIN C", showGoNextButton: false, image: UIImage(named: "detox"), subtitle: "DETOXIFYING"),
                DailyBenifitsModel(title: "BENEFITS\nOF DAILY VITAMIN C", showGoNextButton: false, image: UIImage(named: "detox"), subtitle: "DETOXIFYING")]
    }
    
    static func getElectrolyteData() -> [DailyBenifitsModel] {
        return [DailyBenifitsModel(title: "BENEFITS\nOF DAILY ELECTROLYTES", showGoNextButton: false, image: UIImage(named: "more-energy"), subtitle: "MORE ENERGY"),
                DailyBenifitsModel(title: "BENEFITS\nOF DAILY ELECTROLYTES", showGoNextButton: false, image: UIImage(named: "more-energy"), subtitle: "MORE ENERGY"),
                DailyBenifitsModel(title: "BENEFITS\nOF DAILY ELECTROLYTES", showGoNextButton: false, image: UIImage(named: "more-energy"), subtitle: "MORE ENERGY"),
                DailyBenifitsModel(title: "BENEFITS\nOF DAILY ELECTROLYTES", showGoNextButton: false, image: UIImage(named: "more-energy"), subtitle: "MORE ENERGY"),
                DailyBenifitsModel(title: "BENEFITS\nOF DAILY ELECTROLYTES", showGoNextButton: false, image: UIImage(named: "more-energy"), subtitle: "MORE ENERGY"),
                DailyBenifitsModel(title: "BENEFITS\nOF DAILY ELECTROLYTES", showGoNextButton: false, image: UIImage(named: "more-energy"), subtitle: "MORE ENERGY"),
                DailyBenifitsModel(title: "BENEFITS\nOF DAILY ELECTROLYTES", showGoNextButton: false, image: UIImage(named: "more-energy"), subtitle: "MORE ENERGY"),
                DailyBenifitsModel(title: "BENEFITS\nOF DAILY ELECTROLYTES", showGoNextButton: false, image: UIImage(named: "more-energy"), subtitle: "MORE ENERGY"),
                DailyBenifitsModel(title: "BENEFITS\nOF DAILY ELECTROLYTES", showGoNextButton: false, image: UIImage(named: "more-energy"), subtitle: "MORE ENERGY"),
                DailyBenifitsModel(title: "BENEFITS\nOF DAILY ELECTROLYTES", showGoNextButton: false, image: UIImage(named: "more-energy"), subtitle: "MORE ENERGY")]
    }
}
