//
//  String + Extension.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 25/07/23.
//

import Foundation

extension String {
    
    private var hasLetters: Bool {
        return rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
    }
    
    private var hasNumbers: Bool {
        return rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
    }
    
    public var isAlphabetic: Bool {
        return hasLetters && !hasNumbers
    }
    
    public var isAlphaNumeric : Bool{
        return isAlphabetic || isNumeric
    }
    
    public var isNumeric: Bool {
        return !(isEmpty) && allSatisfy { $0.isNumber }
    }
    
    func checkValidity(_ validityExression : ValidityExression) -> Bool {
        let regEx = validityExression.rawValue
        let test = NSPredicate(format:"SELF MATCHES %@", regEx)
        return test.evaluate(with: self)
    }
    
    func checkInvalidity(_ validityExression : ValidityExression) -> Bool {
        return !self.checkValidity(validityExression)
    }
}


//MARK: - ValidityExression for Strings
enum ValidityExression : String {
    case Email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    case MobileNumber = "^[0-9]{4,15}$"
    case Name = "^[a-zA-Z ]{3,}"
    case AccountNumber = "^[0-9]{9,18}"
    case CardNumber = "^[0-9]{16}"
    case Number = "^[0-9]{0,15}$"
}
