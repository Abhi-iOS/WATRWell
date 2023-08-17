//
//  WWWatrGuidePopUpVM.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 30/07/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWWatrGuidePopUpVM {
    private let disposeBag = DisposeBag()
    let imageName: String
    init(imageName: String) {
        self.imageName = imageName
    }
}

extension WWWatrGuidePopUpVM: WWViewModelProtocol {
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
}

