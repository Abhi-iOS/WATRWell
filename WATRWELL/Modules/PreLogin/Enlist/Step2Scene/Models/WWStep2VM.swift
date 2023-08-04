//
//  WWStep2VM.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 30/07/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWStep2VM {
    private let disposeBag = DisposeBag()
    private(set) var dataModel: WWEnlistUserModel
    
    let monthsArray: [String] = {
        var monthsArray: [String] = []
        for month in 1...12 {
            let formattedMonth = String(format: "%02d", month)
            monthsArray.append(formattedMonth)
        }
        return monthsArray
    }()
    let yearsArray: [Int] = {
        var yearsArray: [Int] = []
        var startYear = Calendar(identifier: .gregorian).dateComponents([.year], from: Date()).year ?? 0
        var endYear = startYear + 11
        for year in startYear...endYear {
            yearsArray.append(year)
        }
        return yearsArray
    }()
    private let shouldMoveToNextSubject = PublishSubject<Void>()
    
    init(dataModel: WWEnlistUserModel) {
        self.dataModel = dataModel
    }
}

extension WWStep2VM: WWViewModelProtocol {
    enum FieldType {
        case name
        case card
        case expiry
    }
    
    struct Input {
        let nextTap: Observable<Void>
        let exitTap: Observable<Void>
    }
    
    struct Output {
        let moveToNext: Driver<Void>
        let moveToRoot: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        input.nextTap.subscribe(onNext: { [weak self] in
            self?.moveToNextStep()
        }).disposed(by: disposeBag)
        return Output(moveToNext: shouldMoveToNextSubject.asDriverOnErrorJustComplete(),
                      moveToRoot: input.exitTap.asDriverOnErrorJustComplete())
    }
    
    func updateData(_ text: String?, fieldType: FieldType) {
        switch fieldType {
        case .name:
            dataModel.nameOnCard = text
        case .card:
            dataModel.cardNumber = text
        case .expiry:
            dataModel.expiry = text
        }
    }
}

private extension WWStep2VM {
    func moveToNextStep() {
        guard verifyDataValidity() else { return }
        shouldMoveToNextSubject.onNext(())
    }
    
    private func verifyDataValidity() -> Bool {
        if dataModel.nameOnCard == nil {
            SKToast.show(withMessage: "Enter Name on Card")
            return false
        } else if let name = dataModel.nameOnCard, name.checkInvalidity(.Name) {
            SKToast.show(withMessage: "Enter valid Name on Card")
            return false
        } else if dataModel.cardNumber == nil {
            SKToast.show(withMessage: "Enter Card Number")
            return false
        } else if let cardNumber = dataModel.cardNumber, cardNumber.checkInvalidity(.CardNumber) {
            SKToast.show(withMessage: "Enter valid Card Number")
            return false
        } else if dataModel.expiry == nil {
            SKToast.show(withMessage: "Enter Card Expiration Date")
            return false
        } else if let expiry = dataModel.expiry, expiry.isEmpty {
            SKToast.show(withMessage: "Enter valid Card Expiration Date")
            return false
        }
        return true
    }
}

