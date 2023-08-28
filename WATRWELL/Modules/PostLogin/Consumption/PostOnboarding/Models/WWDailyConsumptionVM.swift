//
//  WWDailyConsumptionVM.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 20/08/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWDailyConsumptionVM {
    private let disposeBag = DisposeBag()
    let dataSource = WWDailyConsumptionDataModel.getDataModels()
}

extension WWDailyConsumptionVM: WWViewModelProtocol {
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
}

