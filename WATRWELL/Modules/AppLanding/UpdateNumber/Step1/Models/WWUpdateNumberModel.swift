//
//  WWUpdateNumberModel.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 30/08/23.
//

import Foundation

struct WWUpdateNumberModel {
    var firstName: String?
    var lastName: String?
    var email: String?
    var street1: String?
    var street2: String?
    var city: String?
    var state: String?
    var zipCode: String?
    var last4: String?
    var newPhone: String?
    
    var params: JSONDictionary {
        return ["first_name": firstName ?? "",
                "last_name": lastName ?? "",
                "email": email ?? "",
                "street1": street1 ?? "",
                "street2": street2 ?? "",
                "city": city ?? "",
                "state": state ?? "",
                "zip_code": zipCode ?? "",
                "last_4_digit": last4 ?? ""]
    }
}
