//
//  WWWatrSourceInfoVM.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 29/07/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWWatrSourceInfoVM {
    private let disposeBag = DisposeBag()
    private(set) var outletDetail: WWOutletData
    private(set) var outletWatrSource: [WWOutletWatrSource]
    
    init(outletDetail: WWOutletData, outletWatrSource: [WWOutletWatrSource]) {
        self.outletDetail = outletDetail
        self.outletWatrSource = outletWatrSource
    }
}

extension WWWatrSourceInfoVM: WWViewModelProtocol {
    struct Input {
        let closeDidTap: Observable<Void>
    }
    
    struct Output {
        let closePopup: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        return Output(closePopup: input.closeDidTap.asDriverOnErrorJustComplete())
    }
}
