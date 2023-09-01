//
//  WWSourceVM.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 31/07/23.
//

import Foundation
import RxSwift
import RxCocoa

enum SubscriptionType: Int {
    case onlyElectrolytes = 2
    case everything = 3
    case none = -1
    
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
    
    var planId: Int {
        return rawValue
    }

}

final class WWSourceVM {
    private let disposeBag = DisposeBag()
    let viewType: IncomingCase
    var subscriptionType: SubscriptionType?
    private let reloadOnSubscriptionComplete = PublishSubject<Void>()
    private let resetTabbarSubject = PublishSubject<Void>()

    init(viewType: IncomingCase) {
        self.viewType = viewType
        getSubscription()
    }
}

extension WWSourceVM: WWViewModelProtocol {
    enum IncomingCase {
        case subscribed
        case notSubscribed
        case modifySubscription
    }
    
    struct Input {
        let createSubscription: Observable<Void>
    }
    
    struct Output {
        let reloadOnSubscription: Driver<Void>
        let resetTabbar: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        input.createSubscription.subscribe(onNext: { [weak self] _ in
            self?.createSubscription()
        }).disposed(by: disposeBag)
        
        return Output(reloadOnSubscription: reloadOnSubscriptionComplete.asDriverOnErrorJustComplete(),
                      resetTabbar: resetTabbarSubject.asDriverOnErrorJustComplete())
    }
}

extension WWSourceVM {
    private func getSubscription() {
        guard viewType != .modifySubscription else { return }
        WebServices.getSubscriptions { [weak self] response in
            switch response {
            case .success(_):
                self?.reloadOnSubscriptionComplete.onNext(())
            case .failure(_): break
            }
        }
    }
    
    private func createSubscription() {
        guard let subscriptionType else { return }
        let params: JSONDictionary = ["plan_id": subscriptionType.planId]
        WebServices.createSubscription(parameters: params) { [weak self] response in
            switch response {
            case .success(_):
                WWUserModel.currentUser.subscriptionTypeValue = subscriptionType.planId
                self?.resetTabbarSubject.onNext(())
            case .failure(_): break
            }
        }
    }
    
    func updateSubscription(with type: SubscriptionType) {
        let endpoint: WebServices.EndPoint = type == .everything ? .upgrade : .downGrade
        let params: JSONDictionary = ["subscription_id" : WWUserDefaults.value(forKey: .subscriptionId).intValue,
                                      "plan_id" : type.planId]
        WebServices.updateSubscription(parameters: params, endpoint: endpoint) { [weak self] response in
            guard let self else { return }
            switch response {
            case .success(_):
                WWUserModel.currentUser.subscriptionTypeValue = type.planId
                if self.viewType == .modifySubscription {
                    self.resetTabbarSubject.onNext(())
                } else {
                    self.reloadOnSubscriptionComplete.onNext(())
                }
            case .failure(_): break
            }
        }
    }
}
