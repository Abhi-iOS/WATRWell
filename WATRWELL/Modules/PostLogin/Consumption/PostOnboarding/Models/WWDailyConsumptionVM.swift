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
    private(set) var dataSource: [WWDailyConsumptionType] = []
    private let reloadSubject = PublishSubject<Void>()
    
    init() {
        getDailyConsumption()
    }
}

extension WWDailyConsumptionVM: WWViewModelProtocol {
    struct Input {
        
    }
    
    struct Output {
        var reloadCollection: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        return Output(reloadCollection: reloadSubject.asDriverOnErrorJustComplete())
    }
}

private extension WWDailyConsumptionVM {
    func getDailyConsumption() {
        WebServices.getConsumption { [weak self] response in
            switch response {
            case .success(let data):
                self?.createDataSource(with: data)
            case .failure(_): break
            }
        }
    }
    
    func createDataSource(with data: WWDailyConsumptionDataModel) {
        if let electrolyte = data.electrolytes {
            dataSource.append(electrolyte)
        }
        
        if let immunity = data.immunity {
            dataSource.append(immunity)
        }
        
        if let antiAging = data.antiAging {
            dataSource.append(antiAging)
        }
        
        reloadSubject.onNext(())
    }
}

