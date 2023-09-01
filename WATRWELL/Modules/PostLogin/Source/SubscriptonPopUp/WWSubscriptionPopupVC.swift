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
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: WWLabel!
    @IBOutlet weak var paymentSlider: WWPaymentSlider!
    @IBOutlet weak var closeButton: WWVerticalImageTextButton!
    
    // Properties
    private var viewModel: WWSubscriptionPopupVM!
    
    // Overriden functions
    override func setupViews() {
        setInfo()
        configure(with: viewModel)
        containerView.cornerRadius = 20
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
        
        let input = WWSubscriptionPopupVM.Input()
        let output = viewModel.transform(input: input)
        
        output.dismissPopup.drive(onNext: { [weak self] in
            self?.dismissAndSetRoot()
        }).disposed(by: rx.disposeBag)
    }
}

private extension WWSubscriptionPopupVC {
    func updateSubscription() {
        switch WWUserModel.currentUser.subscriptionType {
        case .everything: viewModel.updateSubscription(with: .onlyElectrolytes)
        case .onlyElectrolytes: viewModel.updateSubscription(with: .everything)
        default: break
        }
    }
    
    func setInfo() {
        titleLabel.attributedText = viewModel.getInfoText()
    }
    
    func dismissAndSetRoot() {
        dismiss(animated: true) {
            WWRouter.shared.setTabbarAsRoot(sourceType: .subscribed)
        }
    }
}

