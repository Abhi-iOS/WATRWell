//
//  WWWelcomeVC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 30/07/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWWelcomeVC: WWBaseVC {
    
    // Outlets
    
    // Properties
    private var timer = Timer()

    // Overriden functions
    override func setupViews() {
        setupTimer()
    }
}


// MARK: - ViewController life cycle methods
extension WWWelcomeVC {
    
}

private extension WWWelcomeVC {
    func setupTimer() {
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(goToTabbar), userInfo: nil, repeats: false)
    }
    
    @objc func goToTabbar() {
        timer.invalidate()
        WWRouter.shared.setTabbarAsRoot(sourceType: .notSubscribed)
    }
}

