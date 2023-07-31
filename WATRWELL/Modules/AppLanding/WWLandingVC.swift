//
//  WWLandingVC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 25/07/23.
//

import UIKit
import RxCocoa
import RxSwift

final class WWLandingVC: WWBaseVC {
    
    // Outlets
    @IBOutlet weak var accessButton: WWFilledButton!
    @IBOutlet weak var enlistButton: WWFilledButton!
    
    // Properties
    private(set) var viewModel: WWLandingVM!
    
    // Overriden functions
        override func setupViews() {
        super.setupViews()
        configure(with: viewModel)
    }
}

// MARK: - WWControllerType
extension WWLandingVC: WWControllerType {

    static func create(with viewModel: WWLandingVM) -> UIViewController {
        let landingScene = WWLandingVC.instantiate(fromAppStoryboard: .AppLanding)
        landingScene.viewModel = viewModel
        return landingScene
    }

    func configure(with viewModel: WWLandingVM){
        let input = WWLandingVM.Input(accessDidTap: accessButton.rx.tap.asObservable(),
                                      enlistDidTap: enlistButton.rx.tap.asObservable())
        
        let output = viewModel.transform(input: input)
        
        output.navigateTo.drive(onNext: { [weak self] nextState in
            self?.navigateTo(nextState)
        }).disposed(by: rx.disposeBag)
    }
}

// MARK: - ViewController life cycle methods
extension WWLandingVC {
    
}

private extension WWLandingVC {
    func navigateTo(_ type: WWLandingVM.TransitionTo) {
        switch type {
        case .access:
            let scene = WWEnterPhoneVC.create(with: WWEnterPhoneVM())
            navigationController?.pushViewController(scene, animated: true)
        case .enlist:
            let scene = WWStep1VC.create(with: WWStep1VM())
            navigationController?.pushViewController(scene, animated: true)
        }
    }
}
