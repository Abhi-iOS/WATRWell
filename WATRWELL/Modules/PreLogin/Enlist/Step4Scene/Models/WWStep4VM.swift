//
//  WWStep4VM.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 31/07/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWStep4VM {
    private let disposeBag = DisposeBag()
    private let weightUpdateSubject = PublishSubject<String>()
    private let goNextSubject = PublishSubject<Void>()
    private var weight: Int = 0
}

extension WWStep4VM: WWViewModelProtocol {
    struct Input {
        let weightUpdate: Observable<Float>
        let completeTap: Observable<Void>
    }
    
    struct Output {
        let weightLabelText: Observable<String>
        let goToNext: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        input.weightUpdate.subscribe(onNext: { [weak self] weight in
            guard let self else { return }
            self.weight = Int(ceilf(weight))
            self.weightUpdateSubject.onNext("\(self.weight) LBS")
        }).disposed(by: disposeBag)
        
        input.completeTap.subscribe(onNext: { [weak self] in
            guard let self else { return }
        }).disposed(by: disposeBag)
        
        return Output(weightLabelText: weightUpdateSubject.asObservable(),
                      goToNext: goNextSubject.asDriverOnErrorJustComplete())
    }
}

private extension WWStep4VM {
    func updateData() {
        //TODO: - API call goes here
        goNextSubject.onNext(())
    }
}

