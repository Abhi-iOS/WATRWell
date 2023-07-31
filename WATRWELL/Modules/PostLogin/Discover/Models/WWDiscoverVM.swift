//
//  WWDiscoverVM.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 30/07/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWDiscoverVM {
    private let disposeBag = DisposeBag()
    var dataSource = WWDiscoverDataModel.getDataArray()
}

extension WWDiscoverVM: WWViewModelProtocol {
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
}

