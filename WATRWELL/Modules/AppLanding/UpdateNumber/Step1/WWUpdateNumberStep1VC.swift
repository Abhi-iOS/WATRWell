//
//  WWUpdateNumberStep1VC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 30/08/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWUpdateNumberStep1VC: WWBaseVC {
    
    // Outlets
    @IBOutlet weak var firstNameTF: WWTextField!
    @IBOutlet weak var lastNameTF: WWTextField!
    @IBOutlet weak var emailTF: WWTextField!
    @IBOutlet weak var nextButton: WWFilledButton!
    @IBOutlet weak var exitButton: WWVerticalImageTextButton!
    
    // Properties
    private var viewModel: WWUpdateNumberStep1VM!
    
    // Overriden functions
    override func setupViews() {
        configure(with: viewModel)
        setupTextField()
    }
}

// MARK: - WWControllerType
extension WWUpdateNumberStep1VC: WWControllerType {
    
    static func create(with viewModel: WWUpdateNumberStep1VM) -> UIViewController {
        let step1Scene = WWUpdateNumberStep1VC.instantiate(fromAppStoryboard: .PreLogin)
        step1Scene.viewModel = viewModel
        return step1Scene
    }
    
    func configure(with viewModel: WWUpdateNumberStep1VM){
        let nextAction = nextButton.rx.tap.do { [weak self] _ in
            self?.view.endEditing(true)
        }
        
        let input = WWUpdateNumberStep1VM.Input(nextDidTap: nextAction,
                                                exitDidTap: exitButton.rx.tap.asObservable())
        
        let output = viewModel.transform(input: input)
        
        output.popBack.drive(onNext: { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }).disposed(by: rx.disposeBag)
        
        output.moveToNext.drive(onNext: { [weak self] in
            self?.moveToNextStep()
        }).disposed(by: rx.disposeBag)
    }
}

private extension WWUpdateNumberStep1VC {
    func setupTextField() {
        firstNameTF.delegate = self
        firstNameTF.placeholder = "First Name".uppercased()
        
        lastNameTF.delegate = self
        lastNameTF.placeholder = "Last Name".uppercased()

        emailTF.delegate = self
        emailTF.placeholder = "Email".uppercased()
    }
    
    func moveToNextStep() {
        let step2Scene = WWUpdateNumberStep2VC.create(with: WWUpdateNumberStep2VM(updateNumberModel: viewModel.updateNumberModel))
        navigationController?.pushViewController(step2Scene, animated: true)
    }
}

//MARK: - UITextFieldDelegate
extension WWUpdateNumberStep1VC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case firstNameTF, lastNameTF:
            textField.keyboardType = .asciiCapable
            textField.autocapitalizationType = .words
        case emailTF:
            textField.keyboardType = .emailAddress
        default:
            return false
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case firstNameTF: viewModel.updateNumberModel.firstName = textField.text
        case lastNameTF: viewModel.updateNumberModel.lastName = textField.text
        case emailTF: viewModel.updateNumberModel.email = textField.text
        default: break
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let userEnteredString = textField.text ?? ""
        let newString = (userEnteredString as NSString).replacingCharacters(in: range, with: string) as String
        switch textField {
        case firstNameTF, lastNameTF:
            return newString.count <= 25
        case emailTF:
            return newString.contains(" ").not()
        default:
            return false
        }
    }
}
