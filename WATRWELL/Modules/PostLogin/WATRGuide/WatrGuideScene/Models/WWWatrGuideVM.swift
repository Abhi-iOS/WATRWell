//
//  WWWatrGuideVM.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 30/07/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWWatrGuideVM {
    private let disposeBag = DisposeBag()
    let dataSource: [WWWatrGuideDataModel] = WWWatrGuideDataModel.getDataSource()
}

extension WWWatrGuideVM: WWViewModelProtocol {
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
}

