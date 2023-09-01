//
//  WWUpdateNumberStep3VM.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 30/08/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWUpdateNumberStep3VM {
    private let disposeBag = DisposeBag()
    private let nextTapSuccess = PublishSubject<Void>()
    var updateNumberModel: WWUpdateNumberModel
    
    init(updateNumberModel: WWUpdateNumberModel) {
        self.updateNumberModel = updateNumberModel
    }
}

extension WWUpdateNumberStep3VM: WWViewModelProtocol {
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

private extension WWUpdateNumberStep3VM {
    func validateInput() {
        if updateNumberModel.last4 == nil {
            SKToast.show(withMessage: "Enter Last 4 Digits of Card")
            return
        } else if (updateNumberModel.last4 ?? "").count < 4 {
            SKToast.show(withMessage: "Enter Last 4 Digits of Card")
            return
        }
        validateUser()
    }
    
    func validateUser() {
        WebServices.validateUser(parameters: updateNumberModel.params) { [weak self] result in
            switch result {
            case .success(_): self?.nextTapSuccess.onNext(())
            case .failure(_): break
            }
        }
    }
}
