//
//  WWSubscriptionPopupVM.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 29/08/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWSubscriptionPopupVM {
    private let disposeBag = DisposeBag()
    private let dismissSubject = PublishSubject<Void>()
}

extension WWSubscriptionPopupVM: WWViewModelProtocol {
    struct Input {
    }
    
    struct Output {
        let dismissPopup: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        return Output(dismissPopup: dismissSubject.asDriverOnErrorJustComplete())
    }
    
    private func getUpgradeString() -> String {
        return "\(WWUserModel.currentUser.firstName ?? ""), WOULD YOU LIKE TO UPGRADE YOUR WATRWELL SUBSCRIPTION TO INCLUDE\n+ IMMUNITY AND + ANTI-AGING ?".uppercased()
    }
    
    private func getDowngradeString() -> String {
        return "\(WWUserModel.currentUser.firstName ?? ""), WOULD YOU LIKE TO DOWNGRADE YOUR WATRWELL SUBSCRIPTION TO JUST + ELECTROLYTES ?".uppercased()
    }
    
    func getInfoText() -> NSAttributedString {
        let string = WWUserModel.currentUser.subscriptionType == .everything ? getDowngradeString() : getUpgradeString()
        let boldTexts = ["\((WWUserModel.currentUser.firstName ?? "").uppercased())", "WATRWELL", "+ IMMUNITY", "+ ANTI-AGING", "+ ELECTROLYTES"]
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1
        paragraphStyle.lineHeightMultiple = 1.5
        paragraphStyle.alignment = .center
        let attributedString = NSMutableAttributedString(string: string,
                                                         attributes: [.font: WWFonts.europaLight.withSize(13),
                                                                      .paragraphStyle: paragraphStyle])
        let boldFontAttribute: [NSAttributedString.Key: Any] = [.font: WWFonts.europaRegular.withSize(13)]
        boldTexts.forEach { boldString in
            let range = (string as NSString).range(of: boldString)
            attributedString.addAttributes(boldFontAttribute, range: range)
        }
        return attributedString
    }
}

extension WWSubscriptionPopupVM {
    func updateSubscription(with type: SubscriptionType) {
        let endpoint: WebServices.EndPoint = type == .everything ? .upgrade : .downGrade
        WebServices.updateSubscription(with: endpoint) { [weak self] response in
            switch response {
            case .success(_):
                WWUserModel.currentUser.subscriptionTypeValue = type.planId
                self?.dismissSubject.onNext(())
            case .failure(_): break
            }
        }
    }
}
