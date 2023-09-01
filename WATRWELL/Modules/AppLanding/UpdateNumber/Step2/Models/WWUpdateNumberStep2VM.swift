//
//  WWUpdateNumberStep2VM.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 30/08/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWUpdateNumberStep2VM {
    private let disposeBag = DisposeBag()
    private let nextTapSuccess = PublishSubject<Void>()
    var updateNumberModel: WWUpdateNumberModel
    
    init(updateNumberModel: WWUpdateNumberModel) {
        self.updateNumberModel = updateNumberModel
    }
}

extension WWUpdateNumberStep2VM: WWViewModelProtocol {
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

private extension WWUpdateNumberStep2VM {
    func validateInput() {
        if updateNumberModel.street1 == nil {
            SKToast.show(withMessage: "Enter Street Address")
            return
        } else if updateNumberModel.street2 == nil {
            SKToast.show(withMessage: "Enter Unit or Appartment")
            return
        }  else if updateNumberModel.city == nil {
            SKToast.show(withMessage: "Enter City")
            return
        } else if updateNumberModel.state == nil {
            SKToast.show(withMessage: "Enter State")
            return
        } else if updateNumberModel.zipCode == nil {
            SKToast.show(withMessage: "Enter Zip Code")
            return
        }
        nextTapSuccess.onNext(())
    }
}
