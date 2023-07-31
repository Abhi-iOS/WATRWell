//
//  DailyBenifitsMasterVM.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 29/07/23.
//

import Foundation
import RxSwift
import RxCocoa

final class DailyBenifitsMasterVM {
    private let disposeBag = DisposeBag()
    private let hideBackButtonSubject = PublishSubject<Bool>()
    let sceneType: SceneType
    private var category: BenifitsMasterCategory?
    
    var dataSource: [DailyBenifitsModel]{
        switch sceneType {
        case .master:
            return DailyBenifitsModel.getMasterData()
        case .child:
            if let category {
                switch category {
                case .hydration:
                    return DailyBenifitsModel.getHydrationData()
                case .electrolytes:
                    return DailyBenifitsModel.getElectrolyteData()
                case .vitaminC:
                    return DailyBenifitsModel.getVitaminData()
                }
            } else {
                return []
            }
        }
    }
    
    init(sceneType: SceneType, category: BenifitsMasterCategory?) {
        self.sceneType = sceneType
        self.category = category
    }
}

extension DailyBenifitsMasterVM: WWViewModelProtocol {
    
    enum SceneType {
        case master // to show the main page content
        case child // to display the detailed content
    }
    
    enum BenifitsMasterCategory: Int {
        case electrolytes = 0
        case hydration
        case vitaminC
    }
    
    struct Input {
    }
    
    struct Output {
    }
    
    func transform(input: Input) -> Output {
        
        return Output()
    }
}

