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
    var descriptionText: String
}

extension WWSourcePopupDataModel {
    static var allWatrSourceArr: [WWSourcePopupDataModel] {
        return [WWSourcePopupDataModel(showIconType: .all,
                                       descriptionText: """
                                       WITH THIS SOURCE YOU ARE GRANTED UNLIMITED ACCESS TO BOTH WILLO AND CACTUS, FOR  THE 5x PURIFIED +ELECTROLYTE FORMULA, + IMMUNITY FORMULA, AND +ANTI-AGING FORMULA.
                                       
                                       SWIPE LEFT TO SEE WHAT EACH 20oz SERVING CONTAINS.
                                       """),
                WWSourcePopupDataModel(showIconType: .electrolyte,
                                               descriptionText: """
                                               + ELECTROLYTES
                                               
                                               Servings dispensed from WILLO or CACTUS, are measured in 20oz intervals.
                                                Each 20oz serving of +ELECTROLYTES  contains the following:  5x Purified Water with a 7.7+ ph 33mg Magnesium  11mg Sodium (Pink Himalayan Salt) 2mg Calcium  57mg Potassium
                                               """),
                WWSourcePopupDataModel(showIconType: .immunity,
                                               descriptionText: """
                                               + IMMUNITY
                                               
                                               Servings dispensed from WILLO or CACTUS, are measured in 20oz intervals.
                                               
                                               Each 20oz serving of + IMMUNITY contains the following:  5x Purified Water with a 7.7+ ph 33mg Magnesium  11mg Sodium (Pink Himalayan Salt) 2mg Calcium  57mg Potassium  33mg of VITAMIN C
                                               """),
                WWSourcePopupDataModel(showIconType: .antiAging,
                                               descriptionText: """
                                               + ANTI-AGING
                                               
                                               Servings dispensed from WILLO or CACTUS, are measured in 20oz intervals.
                                               
                                               So, each 20oz serving of + ANTI-AGING  contains the following:  5x Purified Water with a 7.7+ ph 33mg Magnesium  11mg Sodium (Pink Himalayan Salt) 2mg Calcium  57mg Potassium   10g of  Collagen  500mg of Resveratrol
                                               """)
        ]
    }
    
    static var electrolyteWatrSourceArr: [WWSourcePopupDataModel] {
        return [WWSourcePopupDataModel(showIconType: .electrolyte,
                                       descriptionText: """
                                       WITH THIS SOURCE YOU ARE GRANTED UNLIMITED ACCESS TO BOTH WILLO AND CACTUS, FOR ONLY THE 5x PURE WATER + ELECTROLYTE FORMULA.

                                        SWIPE LEFT TO SEE WHAT EACH 20oz SERVING CONTAINS.
                                       """),
                WWSourcePopupDataModel(showIconType: .electrolyte,
                                       descriptionText: """
                                       + ELECTROLYTES
                                       
                                       Servings dispensed from WILLO or CACTUS, are measured in 20oz intervals.
                                        Each 20oz serving of +ELECTROLYTES  contains the following:  5x Purified Water with a 7.7+ ph 33mg Magnesium  11mg Sodium (Pink Himalayan Salt) 2mg Calcium  57mg Potassium
                                       """)
        ]
    }
}
