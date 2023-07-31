//
//  WWStep1VM.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 30/07/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWStep1VM {
    private let disposeBag = DisposeBag()
    let itemRenderer: [ItemType] = ItemType.allCases
    private(set) var dataModel: WWStep1DataModel = WWStep1DataModel()
    private let moveToNextSceneSubject = PublishSubject<Void>()
    
}

extension WWStep1VM: WWViewModelProtocol {
    enum ItemType: CaseIterable {
        case logo
        case firstName
        case lastName
        case mobile
        case email
        case next
        case exit
        
        var placeHolder: String {
            switch self{
            case .firstName: return "FIRST NAME"
            case .lastName: return "LAST NAME"
            case .mobile: return "MOBILE NUMBER"
            case .email: return "EMAIL"
            default: return ""
            }
        }
    }
    
    struct Input {
        let shouldInitiateOTPVerification: Observable<Void>
    }
    
    struct Output {
        let moveToNextScene: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        input.shouldInitiateOTPVerification.subscribe(onNext: { [weak self] in
            self?.requestOTP()
        }).disposed(by: disposeBag)
        return Output(moveToNextScene: moveToNextSceneSubject.asDriverOnErrorJustComplete())
    }
    
    func updateData(_ text: String, for item: ItemType) {
        switch item {
        case .firstName:
            dataModel.firstName = text
        case .lastName:
            dataModel.lastName = text
        case .mobile:
            dataModel.mobile = text
        case .email:
            dataModel.email = text
        default: break
        }
    }
}

private extension WWStep1VM {
    func requestOTP() {
        guard verifyDataValidity() else { return }
        //TODO: - API call goes here
        moveToNextSceneSubject.onNext(())
    }
    
    private func verifyDataValidity() -> Bool {
        if dataModel.firstName == nil {
            SKToast.show(withMessage: "Enter First Name")
            return false
        } else if let fName = dataModel.firstName, fName.checkInvalidity(.Name) {
            SKToast.show(withMessage: "Enter valid First Name")
            return false
        } else if dataModel.lastName == nil {
            SKToast.show(withMessage: "Enter Last Name")
            return false
        } else if let lName = dataModel.lastName, lName.checkInvalidity(.Name) {
            SKToast.show(withMessage: "Enter valid Last Name")
            return false
        } else if dataModel.mobile == nil {
            SKToast.show(withMessage: "Enter Mobile Number")
            return false
        } else if let mobile = dataModel.mobile, mobile.checkInvalidity(.MobileNumber) {
            SKToast.show(withMessage: "Enter valid Mobile Number")
            return false
        } else if dataModel.email == nil {
            SKToast.show(withMessage: "Enter Email Address")
            return false
        } else if let email = dataModel.email, email.checkInvalidity(.Email) {
            SKToast.show(withMessage: "Enter valid Email Address")
            return false
        }
        return true
    }
}
