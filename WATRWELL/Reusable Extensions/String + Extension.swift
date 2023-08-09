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
        let boldTexts = ["50,000 USERS", "100%"]
        let attributedString = NSMutableAttributedString(string: self,
                                                         attributes: [.font: WWFonts.europaLight.withSize(17)])
        value.forEach { textInfo in
            let range = (self as NSString).range(of: textInfo.0.uppercased())
            let attr: [NSAttributedString.Key: Any] = [.foregroundColor: textInfo.1.color]
            attributedString.addAttributes(attr, range: range)
        }
        return attributedString

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
    case MobileNumber = "^[0-9]{4,15}$"
    case Name = "^[a-zA-Z ]{3,}"
    case AccountNumber = "^[0-9]{9,18}"
    case CardNumber = "^[0-9]{16}"
    case Number = "^[0-9]{0,15}$"
}
