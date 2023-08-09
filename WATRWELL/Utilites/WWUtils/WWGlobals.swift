//
//  WWGlobals.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 25/07/23.
//

import UIKit

let sharedAppDelegate = UIApplication.shared.delegate as! AppDelegate
typealias JSONDictionary = [String : Any]
typealias JSONDictionaryArray = [JSONDictionary]
typealias HTTPHeaders = [String:String]

struct WWGlobals {
    static let placesKey = "AIzaSyDEy5bFzJ6rQWXB73dnp-hANMkgatGEKQE"
    static let mapKey = "AIzaSyCnnlorpdB5QYy2NtvzzAiVkvjAwq0vVyU"
    static let brainTreeAuthorization = "sandbox_f252zhq7_hh4cpc39zq4rgjcg"

}
