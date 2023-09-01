//
//  WWUpdateNumberStep2VC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 30/08/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWUpdateNumberStep2VC: WWBaseVC {
    
    // Outlets
    @IBOutlet weak var street1TF: WWTextField!
    @IBOutlet weak var street2TF: WWTextField!
    @IBOutlet weak var cityTF: WWTextField!
    @IBOutlet weak var stateTF: WWTextField!
    @IBOutlet weak var zipCodeTF: WWTextField!
    @IBOutlet weak var nextButton: WWFilledButton!
    @IBOutlet weak var exitButton: WWVerticalImageTextButton!
    
    // Properties
    private var viewModel: WWUpdateNumberStep2VM!
    
    // Overriden functions
    override func setupViews() {
        configure(with: viewModel)
        setupTextField()
    }
}

// MARK: - WWControllerType
extension WWUpdateNumberStep2VC: WWControllerType {
    
    static func create(with viewModel: WWUpdateNumberStep2VM) -> UIViewController {
        let step1Scene = WWUpdateNumberStep2VC.instantiate(fromAppStoryboard: .PreLogin)
        step1Scene.viewModel = viewModel
        return step1Scene
    }
    
    func configure(with viewModel: WWUpdateNumberStep2VM){
        let nextAction = nextButton.rx.tap.do { [weak self] _ in
            self?.view.endEditing(true)
        }
        
        let input = WWUpdateNumberStep2VM.Input(nextDidTap: nextAction,
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

private extension WWUpdateNumberStep2VC {
    func setupTextField() {
        street1TF.delegate = self
        street1TF.placeholder = "Street Address".uppercased()
        
        street2TF.delegate = self
        street2TF.placeholder = "Unit # or Apt. #".uppercased()
        
        cityTF.delegate = self
        cityTF.placeholder = "City".uppercased()

        stateTF.delegate = self
        stateTF.placeholder = "State".uppercased()

        zipCodeTF.delegate = self
        zipCodeTF.placeholder = "Zip code".uppercased()
    }
    
    func moveToNextStep() {
        let step2Scene = WWUpdateNumberStep3VC.create(with: WWUpdateNumberStep3VM(updateNumberModel: viewModel.updateNumberModel))
        navigationController?.pushViewController(step2Scene, animated: true)
    }
}

//MARK: - UITextFieldDelegate
extension WWUpdateNumberStep2VC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case zipCodeTF:
            textField.keyboardType = .numberPad
        default:
            textField.keyboardType = .asciiCapable
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case street1TF: viewModel.updateNumberModel.street1 = textField.text
        case street2TF: viewModel.updateNumberModel.street2 = textField.text
        case cityTF: viewModel.updateNumberModel.city = textField.text
        case stateTF: viewModel.updateNumberModel.state = textField.text
        case zipCodeTF: viewModel.updateNumberModel.zipCode = textField.text
        default: break
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let userEnteredString = textField.text ?? ""
        let newString = (userEnteredString as NSString).replacingCharacters(in: range, with: string) as String
        switch textField {
        case zipCodeTF:
            return (newString.isNumeric || newString == "") && newString.count <= 8
        default:
            return newString.count <= 30
        }
    }
}
