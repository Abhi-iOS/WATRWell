//
//  WWStep2VC + Textfield.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 30/07/23.
//

import UIKit

extension WWStep2VC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextfield:
            textField.keyboardType = .asciiCapable
            textField.autocapitalizationType = .words
        case cardNuTextfield, cvvTextfield:
            textField.keyboardType = .numberPad
        case expiryTextfield:
            textField.inputView = pickerView
            textField.inputAccessoryView = toolBar
        default:
            return false
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case nameTextfield:
            viewModel.updateData(textField.text, fieldType: .name)
        case cardNuTextfield:
            viewModel.updateData(textField.text, fieldType: .card)
        case cvvTextfield:
            viewModel.updateData(textField.text, fieldType: .cvv)
        default: return
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let userEnteredString = textField.text ?? ""
        let newString = (userEnteredString as NSString).replacingCharacters(in: range, with: string) as String
        switch textField {
        case nameTextfield:
            return newString.count <= 25
        case cardNuTextfield:
            return (newString.isNumeric || newString == "") && newString.count <= 16
        case cvvTextfield:
            return (newString.isNumeric || newString == "") && newString.count <= 3
        default:
            return true
        }
    }
}

extension WWStep2VC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0: return viewModel.monthsArray.endIndex
        case 1: return viewModel.yearsArray.endIndex
        default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0: return viewModel.monthsArray[row]
        case 1: return "\(viewModel.yearsArray[row])"
        default: return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0: month = viewModel.monthsArray[row]
        case 1: year = "\(viewModel.yearsArray[row]%100)"
        default: break
        }
        formattedExpiry = month + "/" + year
    }
}
