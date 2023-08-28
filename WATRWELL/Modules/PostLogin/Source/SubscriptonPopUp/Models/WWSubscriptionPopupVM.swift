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
    
}

extension WWSubscriptionPopupVM: WWViewModelProtocol {
    struct Input {
    }
    
    struct Output {
    }
    
    func transform(input: Input) -> Output {
        return Output()
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

