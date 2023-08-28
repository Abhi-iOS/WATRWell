//
//  WWSubscriptionPopupVC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 29/08/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWSubscriptionPopupVC: WWBaseVC {
    
    // Outlets
    @IBOutlet weak var titleLabel: WWLabel!
    @IBOutlet weak var paymentSlider: WWPaymentSlider!
    @IBOutlet weak var closeButton: WWVerticalImageTextButton!
    
    // Properties
    private var viewModel: WWSubscriptionPopupVM!
    
    // Overriden functions
    override func setupViews() {
        setInfo()
        configure(with: viewModel)
    }
}

// MARK: - WWControllerType
extension WWSubscriptionPopupVC: WWControllerType {
    
    static func create(with viewModel: WWSubscriptionPopupVM) -> UIViewController {
        let scene = WWSubscriptionPopupVC.instantiate(fromAppStoryboard: .Source)
        scene.modalTransitionStyle = .crossDissolve
        scene.modalPresentationStyle = .overFullScreen
        scene.viewModel = viewModel
        return scene
    }
    
    func configure(with viewModel: WWSubscriptionPopupVM){
        closeButton.rx.tap.asDriver().drive(onNext: { [weak self] in
            self?.dismiss(animated: true)
        }).disposed(by: rx.disposeBag)
        
        paymentSlider.completion = { [weak self] in
            self?.updateSubscription()
        }
    }
}

private extension WWSubscriptionPopupVC {
    func updateSubscription() {
        switch WWUserModel.currentUser.subscriptionType {
        case .everything: WWUserModel.currentUser.subscriptionTypeString = SubscriptionType.onlyElectrolytes.rawValue
        case .onlyElectrolytes: WWUserModel.currentUser.subscriptionTypeString = SubscriptionType.everything.rawValue
        default: break
        }
        dismiss(animated: true) {
            WWRouter.shared.setTabbarAsRoot(sourceType: .subscribed)
        }
    }
    
    func setInfo() {
        titleLabel.attributedText = viewModel.getInfoText()
    }
}

