//
//  WWUpdateNumberStep3VC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 30/08/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWUpdateNumberStep3VC: WWBaseVC {
    
    // Outlets
    @IBOutlet weak var last4TF: WWTextField!
    @IBOutlet weak var nextButton: WWFilledButton!
    @IBOutlet weak var exitButton: WWVerticalImageTextButton!
    
    // Properties
    private var viewModel: WWUpdateNumberStep3VM!
    
    // Overriden functions
    override func setupViews() {
        configure(with: viewModel)
        setupTextField()
    }
}

// MARK: - WWControllerType
extension WWUpdateNumberStep3VC: WWControllerType {
    
    static func create(with viewModel: WWUpdateNumberStep3VM) -> UIViewController {
        let step1Scene = WWUpdateNumberStep3VC.instantiate(fromAppStoryboard: .PreLogin)
        step1Scene.viewModel = viewModel
        return step1Scene
    }
    
    func configure(with viewModel: WWUpdateNumberStep3VM){
        let nextAction = nextButton.rx.tap.do { [weak self] _ in
            self?.view.endEditing(true)
        }
        
        let input = WWUpdateNumberStep3VM.Input(nextDidTap: nextAction,
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

private extension WWUpdateNumberStep3VC {
    func setupTextField() {
        last4TF.delegate = self
        last4TF.placeholder = "Last 4 Digits Of Card".uppercased()
    }
    
    func moveToNextStep() {
        
    }
}

//MARK: - UITextFieldDelegate
extension WWUpdateNumberStep3VC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case last4TF:
            textField.keyboardType = .numberPad
        default:
            textField.keyboardType = .asciiCapable
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case last4TF: viewModel.updateNumberModel.last4 = textField.text
        default: break
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let userEnteredString = textField.text ?? ""
        let newString = (userEnteredString as NSString).replacingCharacters(in: range, with: string) as String
        switch textField {
        case last4TF:
            return (newString.isNumeric || newString == "") && newString.count <= 4
        default:
            return false
        }
    }
}
