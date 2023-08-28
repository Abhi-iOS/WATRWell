//
//  WWSubscriptionData.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 28/08/23.
//

import UIKit

struct WWSubscriptionData {
    let title: String
    let normalImage: UIImage?
    let highlightedImage: UIImage?
}

extension WWSubscriptionData {
    static func getOnlyElectrolyteData() -> [WWSubscriptionData] {
        return [
            WWSubscriptionData(title: "+ ELECTROLYTES",
                               normalImage: UIImage(named: "elc_subs_empty"),
                               highlightedImage: UIImage(named: "elc_subs_filled"))
        ]
    }
    
    static func getAllData() -> [WWSubscriptionData] {
        return [
            WWSubscriptionData(title: "+ ELECTROLYTES",
                               normalImage: UIImage(named: "elc_subs_empty"),
                               highlightedImage: UIImage(named: "elc_subs_filled")),
            WWSubscriptionData(title: "+ IMMUNITY",
                               normalImage: UIImage(named: "imm_subs_empty"),
                               highlightedImage: UIImage(named: "imm_subs_filled")),
            WWSubscriptionData(title: "+ ANTI-AGING",
                               normalImage: UIImage(named: "aa_subs_empty"),
                               highlightedImage: UIImage(named: "aa_subs_filled"))
        ]
    }
}
