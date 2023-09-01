//
//  WWCancelSubscriptionPopupVC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 01/09/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWCancelSubscriptionPopupVC: WWBaseVC {
    
    // Outlets
    @IBOutlet weak var dontCancelButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var exitButton: WWVerticalImageTextButton!
    
    // Properties
    
    // Overriden functions
    override func setupViews() {
        setupTapHandlers()
    }
}


private extension WWCancelSubscriptionPopupVC {
    func setupTapHandlers() {
        let dismissStream = Observable.merge(exitButton.rx.tap.asObservable(), dontCancelButton.rx.tap.asObservable())
        
        dismissStream.asDriverOnErrorJustComplete().drive(onNext: { [weak self] in
            self?.dismiss(animated: true)
        }).disposed(by: rx.disposeBag)
        
        cancelButton.rx.tap.asDriverOnErrorJustComplete().drive(onNext: { [weak self] in
            self?.cancelSubscription()
        }).disposed(by: rx.disposeBag)
    }
    
    func cancelSubscription() {
        let params: JSONDictionary = ["subscription_id" : WWUserDefaults.value(forKey: .subscriptionId).intValue]
        WebServices.updateSubscription(parameters: params, endpoint: .canelSubscription) { [weak self] response in
            switch response {
            case .success(_):
                WWUserModel.currentUser.subscriptionTypeValue = nil
                WWUserDefaults.removeValue(forKey: .subscriptionId)
                self?.switchBackToTabbar()
            case .failure(_): break
            }
        }
    }
    
    func switchBackToTabbar() {
        dismiss(animated: true) {
            WWRouter.shared.setTabbarAsRoot(initialItem: .source, sourceType: .notSubscribed)
        }
    }
}

