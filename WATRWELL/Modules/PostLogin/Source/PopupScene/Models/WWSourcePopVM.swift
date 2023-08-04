//
//  WWSourcePopVM.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 04/08/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWSourcePopVM {
    enum IncomingCase {
        case all
        case electrolyte
    }
    
    private let disposeBag = DisposeBag()
    
    private let incomingCase: IncomingCase
    
    var dataModel: [WWSourcePopupDataModel] {
        switch incomingCase {
        case .all:
            return WWSourcePopupDataModel.allWatrSourceArr
        case .electrolyte:
            return WWSourcePopupDataModel.electrolyteWatrSourceArr
        }
    }
    
    init(incomingCase: IncomingCase) {
        self.incomingCase = incomingCase
    }
    
}

extension WWSourcePopVM: WWViewModelProtocol {
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
}

