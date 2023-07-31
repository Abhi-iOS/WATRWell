//
//  WWWatrGuidePopUpVC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 30/07/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWWatrGuidePopUpVC: WWBaseVC {
    
    // Outlets
    @IBOutlet weak var descLabel: WWLabel!
    @IBOutlet weak var closeButton: WWVerticalImageTextButton!
    
    // Properties
    private var viewModel: WWWatrGuidePopUpVM!
    
    // Overriden functions
    override func setupViews() {
        configure(with: viewModel)
    }
}

// MARK: - WWControllerType
extension WWWatrGuidePopUpVC: WWControllerType {
    
    static func create(with viewModel: WWWatrGuidePopUpVM) -> UIViewController {
        let watrGuidePopUpScene = WWWatrGuidePopUpVC.instantiate(fromAppStoryboard: .Misc)
        watrGuidePopUpScene.modalTransitionStyle = .crossDissolve
        watrGuidePopUpScene.modalPresentationStyle = .overFullScreen
        watrGuidePopUpScene.viewModel = viewModel
        return watrGuidePopUpScene
    }
    
    func configure(with viewModel: WWWatrGuidePopUpVM){
        
        closeButton.rx.tap.asDriver().drive(onNext: { [weak self] in
            self?.dismiss(animated: true)
        }).disposed(by: rx.disposeBag)
    }
}

// MARK: - ViewController life cycle methods
extension WWWatrGuidePopUpVC {
    
}

private extension WWWatrGuidePopUpVC {
    
}

