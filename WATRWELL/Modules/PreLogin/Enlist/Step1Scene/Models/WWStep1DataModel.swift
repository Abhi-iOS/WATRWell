//
//  WWStep1DataModel.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 30/07/23.
//

import Foundation

struct WWEnlistUserModel {
    enum CardType: String {
        case credit
        case debit
    }
    var id: Int?
    var firstName: String?
    var lastName: String?
    var mobile: String?
    var email: String?
    var cardType: CardType?
    var nameOnCard: String?
    var cardNumber: String?
    var expiry: String?
    var saStreet1: String?
    var saStreet2: String?
    var saCity: String?
    var saState: String?
    var saZip: String?
    var baStreet1: String?
    var baStreet2: String?
    var baCity: String?
    var baState: String?
    var baZip: String?
    var weight: Int = 0
    
    init(with user: WWUserModel) {
        id = user.id
        firstName = user.firstName
        lastName = user.lastName
        email = user.email
        mobile = user.phone
    }
    
    init() {}
    
    var parameters: JSONDictionary {
        var dict: JSONDictionary = [:]
        dict["users[first_name]"] = firstName
        dict["users[last_name]"] = lastName
        dict["users[email]"] = email
        dict["shipping_address[street1]"] = saStreet1
        dict["shipping_address[street2]"] = saStreet2
        dict["shipping_address[city]"] = saCity
        dict["shipping_address[state]"] = saState
        dict["shipping_address[zip_code]"] = saZip
        dict["billing_address[street1]"] = baStreet1
        dict["billing_address[street2]"] = baStreet2
        dict["billing_address[city]"] = baCity
        dict["billing_address[state]"] = baState
        dict["billing_address[zip_code]"] = baZip
        dict["users[weight]"] = weight
        
        return dict
    }
}
