//
//  Webservices + Extensions.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 02/08/23.
//

import Foundation
extension WebServices {
    static var baseUrl: String { "http://174.138.127.119/api/v1/" }
    
    enum EndPoint : String {
        
        case users = "users"
        case validateOtp = "users/verify_otp"
        case resendOtp = "users/resend_otp"
        case validateUser = "users/validate"
        case outlets = "outlets"
        case subscriptions = "subscriptions"
        case upgrade = "subscriptions/upgrade"
        case downGrade = "subscriptions/downgrade"
        case canelSubscription = "subscriptions/cancel_subscription"
        
        // MARK: - API url path
        var path : String {
            return baseUrl + rawValue
        }
        
        // MARK: - Static content url path
        var staticContentPath : String{
            return baseUrl + rawValue
        }
    }
}
