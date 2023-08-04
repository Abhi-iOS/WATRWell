//
//  WWStep3VC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 31/07/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWStep3VC: WWBaseVC {
    
    // Outlets
    @IBOutlet weak var saStreet1TF: WWTextField!
    @IBOutlet weak var saStreet2TF: WWTextField!
    @IBOutlet weak var saCityTF: WWTextField!
    @IBOutlet weak var saStateTF: WWTextField!
    @IBOutlet weak var saZipCodeTF: WWTextField!
    @IBOutlet weak var billingAddButton: UIButton!
    @IBOutlet weak var baStreet1TF: WWTextField!
    @IBOutlet weak var baStreet2TF: WWTextField!
    @IBOutlet weak var baCityTF: WWTextField!
    @IBOutlet weak var baStateTF: WWTextField!
    @IBOutlet weak var baZipCodeTF: WWTextField!
    @IBOutlet weak var nextButton: WWFilledButton!
    @IBOutlet weak var exitButton: WWVerticalImageTextButton!
    
    
    // Properties
    private var viewModel: WWStep3VM!
    
    // Overriden functions
    override func setupViews() {
        configure(with: viewModel)
        setupButton()
        setupTfs()
    }
}

// MARK: - WWControllerType
extension WWStep3VC: WWControllerType {
    
    static func create(with viewModel: WWStep3VM) -> UIViewController {
        let step3Scene = WWStep3VC.instantiate(fromAppStoryboard: .PreLogin)
        step3Scene.viewModel = viewModel
        return step3Scene
    }
    
    func configure(with viewModel: WWStep3VM){
        let nextStream = nextButton.rx.tap.do { [weak self] _ in
            self?.view.endEditing(true)
        }
        let input = WWStep3VM.Input(nextTap: nextStream)
        
        let output = viewModel.transform(input: input)
        
        output.moveToNextStep.drive(onNext: { [weak self] in
            self?.goToNextStep()
        }).disposed(by: rx.disposeBag)
        
        billingAddButton.rx.tap.asDriver().drive(onNext: { [weak self] in
            self?.setSameBillingAddress()
        }).disposed(by: rx.disposeBag)
                
        exitButton.rx.tap.asDriver().drive(onNext: { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }).disposed(by: rx.disposeBag)
    }
}

// MARK: - ViewController life cycle methods
extension WWStep3VC {
    
}

private extension WWStep3VC {
    func setupButton() {
        billingAddButton.setImage(UIImage(named: "ellips_empty"), for: .normal)
        billingAddButton.setImage(UIImage(named: "ellips_filled"), for: .selected)
        guard let title = billingAddButton?.titleLabel?.text else { return }
        let attributes: [NSAttributedString.Key: Any] = [.font: WWFonts.europaRegular.withSize(12)]
        let attributedText = NSAttributedString(string: title, attributes: attributes)
        billingAddButton.setAttributedTitle(attributedText, for: .normal)
    }
    
    func goToNextStep() {
        let step4Scene = WWStep4VC.create(with: WWStep4VM(dataModel: viewModel.dataModel))
        navigationController?.pushViewController(step4Scene, animated: true)
    }
    
    func setSameBillingAddress() {
        billingAddButton.isSelected.toggle()
        
        baStreet1TF.isEnabled = billingAddButton.isSelected.not()
        baStreet2TF.isEnabled = billingAddButton.isSelected.not()
        baCityTF.isEnabled = billingAddButton.isSelected.not()
        baStateTF.isEnabled = billingAddButton.isSelected.not()
        baZipCodeTF.isEnabled = billingAddButton.isSelected.not()
    
        if billingAddButton.isSelected {
            baStreet1TF.text = saStreet1TF.text
            baStreet2TF.text = saStreet2TF.text
            baCityTF.text = saCityTF.text
            baStateTF.text = saStateTF.text
            baZipCodeTF.text = saZipCodeTF.text
            viewModel.dataModel.baStreet1 = baStreet1TF.text
            viewModel.dataModel.baStreet2 = baStreet2TF.text
            viewModel.dataModel.baCity = baCityTF.text
            viewModel.dataModel.baState = baStateTF.text
            viewModel.dataModel.baZip = baZipCodeTF.text
        } else {
            baStreet1TF.text = nil
            baStreet2TF.text = nil
            baCityTF.text = nil
            baStateTF.text = nil
            baZipCodeTF.text = nil
            viewModel.dataModel.baStreet1 = nil
            viewModel.dataModel.baStreet2 = nil
            viewModel.dataModel.baCity = nil
            viewModel.dataModel.baState = nil
            viewModel.dataModel.baZip = nil
        }
    }
    
    func setupTfs() {
        saStreet1TF.autocapitalizationType = .words
        saStreet2TF.autocapitalizationType = .words
        saCityTF.autocapitalizationType = .words
        saStateTF.autocapitalizationType = .words
        saZipCodeTF.autocapitalizationType = .words
        baStreet1TF.autocapitalizationType = .words
        baStreet2TF.autocapitalizationType = .words
        baCityTF.autocapitalizationType = .words
        baStateTF.autocapitalizationType = .words
        baZipCodeTF.autocapitalizationType = .words
        
        saStreet1TF.delegate = self
        saStreet2TF.delegate = self
        saCityTF.delegate = self
        saStateTF.delegate = self
        saZipCodeTF.delegate = self
        baStreet1TF.delegate = self
        baStreet2TF.delegate = self
        baCityTF.delegate = self
        baStateTF.delegate = self
        baZipCodeTF.delegate = self
    }
}

extension WWStep3VC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case saZipCodeTF, baZipCodeTF :
            textField.keyboardType = .numberPad
        default:
            textField.keyboardType = .asciiCapable
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case saStreet1TF: viewModel.dataModel.saStreet1 = textField.text
        case saStreet2TF: viewModel.dataModel.saStreet2 = textField.text
        case saCityTF: viewModel.dataModel.saCity = textField.text
        case saStateTF: viewModel.dataModel.saState = textField.text
        case saZipCodeTF: viewModel.dataModel.saZip = textField.text
        case baStreet1TF: viewModel.dataModel.baStreet1 = textField.text
        case baStreet2TF: viewModel.dataModel.baStreet2 = textField.text
        case baCityTF: viewModel.dataModel.baCity = textField.text
        case baStateTF: viewModel.dataModel.baState = textField.text
        case baZipCodeTF: viewModel.dataModel.baZip = textField.text
        default: break
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let userEnteredString = textField.text ?? ""
        let newString = (userEnteredString as NSString).replacingCharacters(in: range, with: string) as String
        switch textField {
        case saZipCodeTF, baZipCodeTF:
            return (newString.isNumeric || newString == "") && newString.count <= 8
        default:
            return newString.count <= 30
        }
    }
}

