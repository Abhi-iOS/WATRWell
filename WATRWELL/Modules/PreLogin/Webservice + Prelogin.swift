//
//  Webservice + Prelogin.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 02/08/23.
//

import Foundation

extension WebServices {
    
    static func loginUser(parameters: JSONDictionary, response : @escaping ((Result<String,Error>) ->())) {
        commonPostAPI(parameters: parameters, endPoint: .users) { result in
            switch result {
            case .success(let data):
                response(.success(data["data"]["id"].stringValue))
            case .failure(let error):
                response(.failure(error))
            }
        }
    }
    
    static func validateUserOTP(parameters: JSONDictionary, response : @escaping ((Result<Void,Error>) ->())) {
        commonPostAPI(parameters: parameters, endPoint: .validateOtp) { result in
            switch result {
            case .success(let data):
                let userData = try! data["data"]["user"].rawData()
                let userModel = try! JSONDecoder().decode(WWUserModel.self, from: userData)
                let userAddresses = try! data["data"]["addresses"].rawData()
                let userAddressModel = try! JSONDecoder().decode([WWUserAddressModel].self, from: userAddresses)
                let userPaymentInfo = try! data["data"]["payment_informations"].rawData()
                let userPaymentInfoModel = try! JSONDecoder().decode([WWPaymentModel].self, from: userPaymentInfo)
                WWUserModel.currentUser = userModel
                WWUserAddressDataSource.currentAddresses.addresses = userAddressModel
                WWUserPaymentDataSource.userPaymentInfo.paymentInfo = userPaymentInfoModel
                if userModel.firstName != nil {
                    WWUserDefaults.save(value: true, forKey: .isLoggedIn)
                }
                WWUserDefaults.save(value: data["auth"].stringValue, forKey: .userAuth)
                response(.success(()))
            case .failure(let error):
                response(.failure(error))
            }
        }
    }
    
    static func resendOTP(parameters: JSONDictionary, response : @escaping ((Result<Void,Error>) ->())) {
        commonGetAPI(parameters: parameters, endPoint: .resendOtp) { result in
            switch result {
            case .success(_):
                response(.success(()))
            case .failure(let error):
                response(.failure(error))
            }
        }
    }
    
    static func enlistUserData(parameters: JSONDictionary, userId: Int, response: @escaping ((Result<Void,Error>) ->())) {
        commonPatchAPI(parameters: parameters, endPoint: .users, toAppend: "\(userId)") { result in
            switch result {
            case .success(_):
                response(.success(()))
            case .failure(let error):
                response(.failure(error))
            }
        }
    }
    
    static func validateUser(parameters: JSONDictionary, response : @escaping ((Result<String,Error>) ->())) {
        commonPostAPI(parameters: parameters, endPoint: .validateUser) { result in
            switch result {
            case .success(let data):
                response(.success(data["data"]["id"].stringValue))
            case .failure(let error):
                response(.failure(error))
            }
        }
    }
}
