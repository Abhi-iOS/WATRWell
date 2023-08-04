//
//  WWStep3VM.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 31/07/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWStep3VM {
    private let disposeBag = DisposeBag()
    var dataModel: WWEnlistUserModel
    private let moveToNextSubject = PublishSubject<Void>()
    
    init(dataModel: WWEnlistUserModel) {
        self.dataModel = dataModel
    }
}

extension WWStep3VM: WWViewModelProtocol {
    struct Input {
        let nextTap: Observable<Void>
    }
    
    struct Output {
        let moveToNextStep: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        input.nextTap.subscribe(onNext: { [weak self] in
            self?.moveToNextStep()
        }).disposed(by: disposeBag)
        
        return Output(moveToNextStep: moveToNextSubject.asDriverOnErrorJustComplete())
    }
}

private extension WWStep3VM {
    func moveToNextStep() {
        guard verifyDataValidity() else { return }
        moveToNextSubject.onNext(())
    }
    
    private func verifyDataValidity() -> Bool {
        if dataModel.saStreet1 == nil {
            SKToast.show(withMessage: "Enter Street 1 on Shipping Address")
            return false
        } else if dataModel.saStreet2 == nil {
            SKToast.show(withMessage: "Enter Street 2 on Shipping Address")
            return false
        }  else if dataModel.saCity == nil {
            SKToast.show(withMessage: "Enter City on Shipping Address")
            return false
        } else if dataModel.saState == nil {
            SKToast.show(withMessage: "Enter State on Shipping Address")
            return false
        } else if dataModel.saZip == nil {
            SKToast.show(withMessage: "Enter Zip Code on Shipping Address")
            return false
        } else if dataModel.baStreet1 == nil {
            SKToast.show(withMessage: "Enter Street 1 on Billing Address")
            return false
        } else if dataModel.baStreet2 == nil {
            SKToast.show(withMessage: "Enter Street 2 on Billing Address")
            return false
        }  else if dataModel.baCity == nil {
            SKToast.show(withMessage: "Enter City on Billing Address")
            return false
        } else if dataModel.baState == nil {
            SKToast.show(withMessage: "Enter State on Billing Address")
            return false
        } else if dataModel.baZip == nil {
            SKToast.show(withMessage: "Enter Zip Code on Billing Address")
            return false
        }
        return true
    }
}
