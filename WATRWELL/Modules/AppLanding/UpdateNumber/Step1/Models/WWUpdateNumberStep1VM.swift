//
//  WWUpdateNumberStep1VM.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 30/08/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWUpdateNumberStep1VM {
    private let disposeBag = DisposeBag()
    private let nextTapSuccess = PublishSubject<Void>()
    var updateNumberModel = WWUpdateNumberModel()
}

extension WWUpdateNumberStep1VM: WWViewModelProtocol {
    struct Input {
        let nextDidTap: Observable<Void>
        let exitDidTap: Observable<Void>
    }
    
    struct Output {
        let popBack: Driver<Void>
        let moveToNext: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        input.nextDidTap.subscribe(onNext: { [weak self] in
            self?.validateInput()
        }).disposed(by: disposeBag)
        
        return Output(popBack: input.exitDidTap.asDriverOnErrorJustComplete(),
                      moveToNext: nextTapSuccess.asDriverOnErrorJustComplete())
    }
}

private extension WWUpdateNumberStep1VM {
    func validateInput() {
        if updateNumberModel.firstName == nil {
            SKToast.show(withMessage: "Enter First Name")
            return
        } else if let fName = updateNumberModel.firstName, fName.checkInvalidity(.Name) {
            SKToast.show(withMessage: "Enter valid First Name")
            return
        } else if updateNumberModel.lastName == nil {
            SKToast.show(withMessage: "Enter Last Name")
            return
        } else if let lName = updateNumberModel.lastName, lName.checkInvalidity(.Name) {
            SKToast.show(withMessage: "Enter valid Last Name")
            return
        } else if updateNumberModel.email == nil {
            SKToast.show(withMessage: "Enter Email Address")
            return
        } else if let email = updateNumberModel.email, email.checkInvalidity(.Email) {
            SKToast.show(withMessage: "Enter valid Email Address")
            return
        }
        nextTapSuccess.onNext(())
    }
}
