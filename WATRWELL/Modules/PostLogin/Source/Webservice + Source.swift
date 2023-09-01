//
//  Webservice + Source.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 01/09/23.
//

import Foundation

extension WebServices {
    
    static func createSubscription(parameters: JSONDictionary, response : @escaping ((Result<Void,Error>) ->())) {
        commonPostAPI(parameters: parameters, endPoint: .subscriptions) { result in
            switch result {
            case .success(_):
                response(.success(()))
            case .failure(let error):
                response(.failure(error))
            }
        }
    }
    
    static func getSubscriptions(response : @escaping ((Result<Void,Error>) ->())) {
        commonGetAPI(parameters: [:], endPoint: .subscriptions, loader: false) { result in
            switch result {
            case .success(let data):
                if let subscriptionId = (data["data"].arrayValue).first?["subscription_id"].intValue {
                    let planId = (data["data"].arrayValue).first?["plan_id"].intValue
                    WWUserModel.currentUser.subscriptionTypeValue = planId
                    WWUserDefaults.save(value: subscriptionId, forKey: .subscriptionId)
                }
                response(.success(()))
            case .failure(let error):
                response(.failure(error))
            }
        }
    }
    
    static func updateSubscription(with endpoint: WebServices.EndPoint, response : @escaping ((Result<Void,Error>) ->())) {
        commonPutWithRawJSONAPI(parameters: ["subscription_id": WWUserDefaults.value(forKey: .subscriptionId).intValue], endPoint: endpoint) { result in
            switch result {
            case .success(_):
                response(.success(()))
            case .failure(let error):
                response(.failure(error))
            }
        }
    }
}
