//
//  WWLandingVM.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 25/07/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWLandingVM {
    private let disposeBag = DisposeBag()
    private let shouldNavigateSubject = PublishSubject<TransitionTo>()
}

extension WWLandingVM: WWViewModelProtocol {
    enum TransitionTo {
        case access
        case enlist
        case updateNumber
    }
    
    struct Input {
        let accessDidTap: Observable<Void>
        let enlistDidTap: Observable<Void>
        let updateDidTap: Observable<Void>
    }
    
    struct Output {
        let navigateTo: Driver<TransitionTo>
    }
    
    func transform(input: Input) -> Output {
        input.accessDidTap.subscribe(onNext: { [weak self] _ in
            guard let self else { return }
            self.shouldNavigateSubject.onNext(.access)
        }).disposed(by: disposeBag)
        
        input.enlistDidTap.subscribe(onNext: { [weak self] _ in
            guard let self else { return }
            self.shouldNavigateSubject.onNext(.enlist)
        }).disposed(by: disposeBag)
        
        input.updateDidTap.subscribe(onNext: { [weak self] _ in
            guard let self else { return }
            self.shouldNavigateSubject.onNext(.updateNumber)
        }).disposed(by: disposeBag)

        return Output(navigateTo: shouldNavigateSubject.asDriverOnErrorJustComplete())
    }
}
