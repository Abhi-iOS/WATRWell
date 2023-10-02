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
        
    var planId: Int {
        return rawValue
    }

}

final class WWSourceVM {
    private let disposeBag = DisposeBag()
    private(set) var viewType: IncomingCase
    var subscriptionType: SubscriptionType? {
        didSet {
            dataSource = setDataSource()
        }
    }
    private let reloadOnSubscriptionComplete = PublishSubject<Void>()
    private let presentPopUpSubject = PublishSubject<Void>()
    private let resetTabbarSubject = PublishSubject<Void>()
    var dataSource: [WWSubscriptionData] = []

    init(viewType: IncomingCase) {
        self.viewType = viewType
        getSubscription()
    }
    
    func setDataSource() -> [WWSubscriptionData] {
        switch subscriptionType {
        case .onlyElectrolytes:
            return WWSubscriptionData.getOnlyElectrolyteData()
        case .everything:
            return WWSubscriptionData.getAllData()
        default:
            return []
        }
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
        let showPopup: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        input.createSubscription.subscribe(onNext: { [weak self] _ in
            self?.createSubscription()
        }).disposed(by: disposeBag)
        
        return Output(reloadOnSubscription: reloadOnSubscriptionComplete.asDriverOnErrorJustComplete(),
                      resetTabbar: resetTabbarSubject.asDriverOnErrorJustComplete(),
                      showPopup: presentPopUpSubject.asDriverOnErrorJustComplete())
    }
}

extension WWSourceVM {
    private func getSubscription() {
        guard viewType != .modifySubscription else { return }
        WebServices.getSubscriptions { [weak self] response in
            switch response {
            case .success(_):
                if let planId = WWUserModel.currentUser.subscriptionTypeValue {
                    self?.viewType = .subscribed
                    self?.subscriptionType = SubscriptionType(rawValue: planId) ?? SubscriptionType.none
                } else {
                    if WWUserDefaults.value(forKey: .didShowPrePopup).boolValue.not() {
                        self?.presentPopUpSubject.onNext(())
                        WWUserDefaults.save(value: true, forKey: .didShowPrePopup)
                    }
                }
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
        subscriptionType = type
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
