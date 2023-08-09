//
//  WWStep1VC + TableView.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 30/07/23.
//

import UIKit

extension WWStep1VC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemRenderer.endIndex
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemType = viewModel.itemRenderer[indexPath.item]
        
        switch itemType {
        case .logo:
            let cell = tableView.dequeueCell(with: WWLogoTVC.self, indexPath: indexPath)
            cell.setDataForAccountCreation(logo: UIImage(named: "logo-latest 1"), title: "STEP 1 OF 4:", subtitle: "COMPLETE YOUR PERSONAL INFROMATION")
            return cell
            
        case .next:
            let cell = tableView.dequeueCell(with: WWFilledButtonTVC.self, indexPath: indexPath)
            cell.updateTitle("NEXT")
            cell.buttonTapHandler = { [weak self] in
                self?.initiateVerifyOTP()
            }
            return cell
            
        case .exit:
            let cell = tableView.dequeueCell(with: WWVerticalButtonTVC.self, indexPath: indexPath)
            cell.verticalButton.normalTitleColor = WWColors.hex000000.color
            cell.setData("EXIT", UIImage(named: "Cancel"))
            cell.tapHandler = { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            return cell
            
        case .firstName:
            let cell = tableView.dequeueCell(with: WWSingleTFTVC.self, indexPath: indexPath)
            cell.inputTextField.delegate = self
            cell.setData(with: viewModel.dataModel.firstName, placeholder: itemType.placeHolder)
            return cell
            
        case .lastName:
            let cell = tableView.dequeueCell(with: WWSingleTFTVC.self, indexPath: indexPath)
            cell.inputTextField.delegate = self
            cell.setData(with: viewModel.dataModel.lastName, placeholder: itemType.placeHolder)
            return cell
            
        case .mobile:
            let cell = tableView.dequeueCell(with: WWSingleTFTVC.self, indexPath: indexPath)
            cell.inputTextField.delegate = self
            cell.inputTextField.isEnabled = viewModel.isNumberVerified.not()
            cell.setData(with: viewModel.dataModel.mobile, placeholder: itemType.placeHolder)
            return cell
            
        case .email:
            let cell = tableView.dequeueCell(with: WWSingleTFTVC.self, indexPath: indexPath)
            cell.inputTextField.delegate = self
            cell.setData(with: viewModel.dataModel.email, placeholder: itemType.placeHolder)
            return cell
        }
    }
}

private extension WWStep1VC {
    func initiateVerifyOTP() {
        view.endEditing(true)
        initiateVerifyOTPSubject.onNext(())
    }
}

extension WWStep1VC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        guard let index = textField.tableViewIndexPath(tableView)?.row else { return false }
        let itemType = viewModel.itemRenderer[index]
        switch itemType {
        case .firstName, .lastName:
            textField.keyboardType = .asciiCapable
            textField.autocapitalizationType = .words
        case .mobile:
            textField.keyboardType = .numberPad
        case .email:
            textField.keyboardType = .emailAddress
        default:
            return false
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let index = textField.tableViewIndexPath(tableView)?.row else { return }
        let itemType = viewModel.itemRenderer[index]
        viewModel.updateData(textField.text ?? "", for: itemType)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let index = textField.tableViewIndexPath(tableView)?.row else { return false }
        let itemType = viewModel.itemRenderer[index]
        let userEnteredString = textField.text ?? ""
        let newString = (userEnteredString as NSString).replacingCharacters(in: range, with: string) as String
        switch itemType {
        case .firstName, .lastName:
            return newString.count <= 25
        case .mobile:
            if newString.count <= 14 {
                let formattedNumber = newString.formatPhoneNumber()
                textField.text = formattedNumber
                return true
            }
            return false
        case .email:
            return newString.contains(" ").not()
        default:
            return false
        }
    }
}
