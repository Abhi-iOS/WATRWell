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
