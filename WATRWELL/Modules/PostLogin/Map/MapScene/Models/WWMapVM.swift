//
//  WWMapVM.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 28/07/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWMapVM {
    private let disposeBag = DisposeBag()
    private let selectionUpdateSubject = PublishSubject<SelectedOption>()
}

extension WWMapVM: WWViewModelProtocol {
    enum SelectedOption {
        case willo
        case cactus
    }
    struct Input {
        let willoTapped: Observable<Void>
        let cactusTapped: Observable<Void>
    }
    
    struct Output {
        let updateSelection: Driver<SelectedOption>
    }
    
    func transform(input: Input) -> Output {
        input.cactusTapped.subscribe(onNext: { [weak self] in
            guard let self else { return }
            self.selectionUpdateSubject.onNext(.cactus)
        }).disposed(by: disposeBag)
        
        input.willoTapped.subscribe(onNext: { [weak self] in
            guard let self else { return }
            self.selectionUpdateSubject.onNext(.willo)
        }).disposed(by: disposeBag)
        
        return Output(updateSelection: selectionUpdateSubject.asDriverOnErrorJustComplete())
    }
}

