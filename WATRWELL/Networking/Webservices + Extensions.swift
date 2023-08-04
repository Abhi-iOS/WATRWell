//
//  Webservices + Extensions.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 02/08/23.
//

import Foundation
extension WebServices {
    static var baseUrl: String { "http://13.50.16.34/api/v1/" }
    
    enum EndPoint : String {
        
        case users = "users"
        case validateOtp = "users/verify_otp"
        case resendOtp = "users/resend_otp"
        
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
