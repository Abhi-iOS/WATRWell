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
    
    func stringFromHtml() -> NSAttributedString? {
        let htmlData = NSString(string: self).data(using: String.Encoding.unicode.rawValue)
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType:
                        NSAttributedString.DocumentType.html]
        let attributedString = try? NSMutableAttributedString(data: htmlData ?? Data(),
                                                                  options: options,
                                                                  documentAttributes: nil)
        return attributedString
    }
    
    func applyColor(to value: [(String, WWColors)]) -> NSAttributedString? {
        let attributedString = NSMutableAttributedString(string: self,
                                                         attributes: [.font: WWFonts.europaLight.withSize(17)])
        value.forEach { textInfo in
            let range = (self as NSString).range(of: textInfo.0.uppercased())
            let attr: [NSAttributedString.Key: Any] = [.foregroundColor: textInfo.1.color]
            attributedString.addAttributes(attr, range: range)
        }
        return attributedString

    }
    
    func getDistanceString() -> NSAttributedString {
        let distanceString = "Distance from you: ".uppercased() + self
        let attributedString = NSMutableAttributedString(string: distanceString,
                                                         attributes: [.font: WWFonts.europaRegular.withSize(15)])
        let range = (distanceString as NSString).range(of: self)
        let attr: [NSAttributedString.Key: Any] = [.font: WWFonts.europaLight.withSize(15)]
        attributedString.addAttributes(attr, range: range)
        return attributedString
    }
    
    func formatPhoneNumber() -> String {
        let mask = "(XXX) XXX - XXXX"
        let numbers = self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex // numbers iterator
        
        // iterate over the mask characters until the iterator of numbers ends
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                // mask requires a number in this place, so take the next one
                result.append(numbers[index])
                
                // move numbers iterator to the next index
                index = numbers.index(after: index)
                
            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }
}

extension NSAttributedString {
    func boldString(value: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(attributedString: self)
        var searchRange = NSRange(location: 0, length: self.string.utf16.count)
        while let range = self.string.range(of: value, options: .caseInsensitive, range: Range(searchRange, in: self.string)) {
            let nsRange = NSRange(range, in: self.string)
            let attributes: [NSAttributedString.Key: Any] = [
                .font: WWFonts.europaRegular.withSize(17)
            ]
            attributedString.addAttributes(attributes, range: nsRange)
            
            searchRange.location = nsRange.location + nsRange.length
            searchRange.length = self.string.utf16.count - searchRange.location
        }
        return attributedString
    }
}


//MARK: - ValidityExression for Strings
enum ValidityExression : String {
    case Email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    case MobileNumber = "^[0-9() -]{4,20}$"
    case Name = "^[a-zA-Z ]{3,}"
    case AccountNumber = "^[0-9]{9,18}"
    case CardNumber = "^[0-9]{16}"
    case Number = "^[0-9]{0,15}$"
}
