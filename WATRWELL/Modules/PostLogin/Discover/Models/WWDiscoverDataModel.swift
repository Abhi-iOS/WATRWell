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
    var descText: String?
    var logoTint: UIColor?
    var buttonLogo: UIImage?
}

extension WWDiscoverDataModel {
    static func getDataArray() -> [WWDiscoverDataModel] {
        return [WWDiscoverDataModel(title: "WILLŌ",
                                    descText: "Meet WILLO. WILLO was born to advance the mission of WATR by providing a higher quality daily drinking water supply to communities. WILLO is designed specifically to maintain the appeal of community parks and natural public areas.   Being powered by solar energy, She is self sufficient. SHe interacts with the WATRWELL app in dispensing 5x purified drinking water enhanced with either electrolytes (+ ELECTROLYTES), VITAMIN C (+IMMUNITY), or Collagen + resveratrol (+ANTI-AGING).",
                                    logoTint: nil,
                                    buttonLogo: UIImage(named: "discover_willo")),
                WWDiscoverDataModel(title: "CACTUS",
                                    descText: "MEET CACTUS. CACTUS was born to advance the mission of WATR by providing higher quality daily drinking water supply to communities. CACTUS is uniquely designed to fit within more urban areas, yet can also advance the aesthetic of natural public areas, and is expressly designed to be easily identifiable, and easily interacted with. Its design is iconic in advancing moderity, and inspiration to local and global communities. Being powered by solar energy,\n\nBeing powered by solar energy, he is self sufficient. He interacts with the WATRWELL  app in dispensing 5x purified drinking water enhanced with either electrolytes(+ ELECTROLYTES), VITAMIN C (+IMMUNITY), or Collagen + resveratrol (+ANTI-AGING).",
                                    logoTint: nil,
                                    buttonLogo: UIImage(named: "discover_willo")),
                WWDiscoverDataModel(title: "+ELECTROLYTES",
                                    descText: "Servings dispensed from WILLO or CACTUS, are measured in 20oz intervals.\n\nEach 20oz serving of +ELECTROLYTES contains the following:   5x Purified Water with a 7.7+ ph 33mg Magnesium  11mg Sodium (Pink Himalayan Salt) 2mg Calcium  57mg Potassium",
                                    logoTint: WWColors.hex203D75.color,
                                    buttonLogo: nil),
                WWDiscoverDataModel(title: "+IMMUNITY",
                                    descText: "Servings dispensed from WILLO or CACTUS, are measured in 20oz intervals.\n\nEach 20oz serving of +ELECTROLYTES contains the following:   5x Purified Water with a 7.7+ ph 33mg Magnesium  11mg Sodium (Pink Himalayan Salt) 2mg Calcium  57mg Potassium",
                                    logoTint: WWColors.hexDF5509.color,
                                    buttonLogo: nil),
                WWDiscoverDataModel(title: "+ANTI-AGING",
                                    descText: "Servings dispensed from WILLO or CACTUS, are measured in 20oz intervals.\n\nEach 20oz serving of +ELECTROLYTES contains the following:   5x Purified Water with a 7.7+ ph 33mg Magnesium  11mg Sodium (Pink Himalayan Salt) 2mg Calcium  57mg Potassium",
                                    logoTint: WWColors.hexB3E6B5.color,
                                    buttonLogo: nil),
                WWDiscoverDataModel(title: "SUSTAINABILITY",
                                    descText: "ONCE WE REACH 50,000 USERS WE WILL BUILD OUT THE SUSTAINABILITY IMPACT PROFILE.   WE WILL SUPPORT COMMUNITIES IN BECOMING 100% SUSTAINABLE IN THIS CATEGORY.",
                                    logoTint: nil,
                                    buttonLogo: nil)
        ]
    }
}
