//
//  WWEnterPhoneVC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 25/07/23.
//

import UIKit

final class WWEnterPhoneVC: WWBaseVC {
    
    // Outlets
    @IBOutlet weak var titleLabel: WWLabel!
    @IBOutlet weak var phoneNumberTextField: WWTextField!
    @IBOutlet weak var subtitleLabel: WWLabel!
    @IBOutlet weak var accessButton: WWFilledButton!
    @IBOutlet weak var exitButton: WWVerticalImageTextButton!
    
    // Properties
    private(set) var viewModel: WWEnterPhoneVM!
    
    // Overriden functions
    override func setupViews() {
        super.setupViews()
        phoneNumberTextField.delegate = self
        phoneNumberTextField.keyboardType = .numberPad
        configure(with: viewModel)
    }
}

// MARK: - WWControllerType
extension WWEnterPhoneVC: WWControllerType {
    
    static func create(with viewModel: WWEnterPhoneVM) -> UIViewController {
        let enterPhoneScene = WWEnterPhoneVC.instantiate(fromAppStoryboard: .PreLogin)
        enterPhoneScene.viewModel = viewModel
        return enterPhoneScene
    }
    
    func configure(with viewModel: WWEnterPhoneVM){
        let input = WWEnterPhoneVM.Input(userMobileNumber: phoneNumberTextField.textFieldText,
                                         didTapAccess: accessButton.rx.tap.asObservable(),
                                         didTapExit: exitButton.rx.tap.asObservable())
        
        let output = viewModel.transform(input: input)
        
        output.accessGranted.drive(onNext: { [weak self] id in
            self?.navigateToOTPConfirmation(with: id)
        }).disposed(by: rx.disposeBag)
        
        output.popScreen.drive(onNext: { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }).disposed(by: rx.disposeBag)
    }
}

private extension WWEnterPhoneVC {
    func navigateToOTPConfirmation(with id: String) {
        let scene = WWEnterOTPVC.create(with: WWEnterOTPVM(id: id, incomingCase: .access))
        navigationController?.pushViewController(scene, animated: true)
    }
}

extension WWEnterPhoneVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let userEnteredString = textField.text ?? ""
        let newString = (userEnteredString as NSString).replacingCharacters(in: range, with: string) as String
        if newString.count <= 14 {
            let formattedNumber = newString.formatPhoneNumber()
            textField.text = formattedNumber
            return true
        }
        return false
    }
}
