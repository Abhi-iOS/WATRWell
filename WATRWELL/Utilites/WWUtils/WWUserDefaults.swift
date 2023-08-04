//
//  WWUserDefaults.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 03/08/23.
//

import UIKit

enum WWUserDefaults {
    
    static func value(forKey key: Key,
                      file : String = #file,
                      line : Int = #line,
                      function : String = #function) -> JSON {
        
        guard let value = UserDefaults.standard.object(forKey: key.rawValue) else {
            print("No Value Found in UserDefaults\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
            return JSON.null
        }
        
        return JSON(value)
    }
    
    static func value<T>(forKey key: Key,
                         fallBackValue : T,
                         file : String = #file,
                         line : Int = #line,
                         function : String = #function) -> JSON {
        
        guard let value = UserDefaults.standard.object(forKey: key.rawValue) else {
            
            print("No Value Found in UserDefaults\nFile : \(file) \nFunction : \(function)")
            return JSON(fallBackValue)
        }
        
        return JSON(value)
    }
    
    static func save(value : Any, forKey key : Key) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    static func removeValue(forKey key : Key) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    static func register(defaults: JSONDictionary){
        UserDefaults.standard.register(defaults: defaults)
    }
    
    static func removeAllValues() {
        UIApplication.shared.applicationIconBadgeNumber = 0
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        let appDomain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: appDomain)
        UserDefaults.standard.synchronize()
        save(value: false, forKey: .isLoggedIn)
    }
}

//MARK: Keys
extension WWUserDefaults {
    
    enum Key : String {
        case isLoggedIn
        case userAuth
        case userData
    }
}
