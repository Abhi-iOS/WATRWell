//
//  WWSourceVM.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 31/07/23.
//

import Foundation
import RxSwift
import RxCocoa

enum SubscriptionType: String {
    case onlyElectrolytes
    case everything
    case none
    
    var dataSource: [WWSubscriptionData] {
        switch self {
        case .onlyElectrolytes:
            return WWSubscriptionData.getOnlyElectrolyteData()
        case .everything:
            return WWSubscriptionData.getAllData()
        case .none:
            return []
        }
    }

}

final class WWSourceVM {
    private let disposeBag = DisposeBag()
    let viewType: IncomingCase
    var subscriptionType: SubscriptionType?

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

