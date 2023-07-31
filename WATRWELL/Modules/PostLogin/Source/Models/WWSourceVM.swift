//
//  WWSourceVM.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 31/07/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWSourceVM {
    private let disposeBag = DisposeBag()
    let viewType: IncomingCase
    
    init(viewType: IncomingCase) {
        self.viewType = viewType
    }
}

extension WWSourceVM: WWViewModelProtocol {
    enum IncomingCase {
        case subscribed
        case notSubscribed
    }
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
}

