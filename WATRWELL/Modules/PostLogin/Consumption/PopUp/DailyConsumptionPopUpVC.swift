//
//  DailyConsumptionPopUpVC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 20/08/23.
//

import Foundation
import RxSwift
import RxCocoa

final class DailyConsumptionPopUpVC: WWBaseVC {
    
    // Outlets
    
    // Properties
    
    // Overriden functions
    override func setupViews() {
    }
    
    
    @IBAction func didTapClose(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension DailyConsumptionPopUpVC {
    
    static func create() -> UIViewController {
        let dailyConsumptionScene = DailyConsumptionPopUpVC.instantiate(fromAppStoryboard: .Misc)
        dailyConsumptionScene.modalPresentationStyle = .overFullScreen
        dailyConsumptionScene.modalTransitionStyle = .crossDissolve
        return dailyConsumptionScene
    }
}

