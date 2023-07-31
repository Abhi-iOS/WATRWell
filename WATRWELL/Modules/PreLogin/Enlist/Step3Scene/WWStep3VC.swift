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
        
        billingAddButton.rx.tap.asDriver().drive(onNext: { [weak self] in
            self?.setSameBillingAddress()
        }).disposed(by: rx.disposeBag)
        
        nextButton.rx.tap.asDriver().drive(onNext: { [weak self] in
            self?.view.endEditing(true)
            self?.goToNextStep()
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
        let welcomeScene = WWWelcomeVC.instantiate(fromAppStoryboard: .PreLogin)
        navigationController?.pushViewController(welcomeScene, animated: true)
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
        } else {
            baStreet1TF.text = nil
            baStreet2TF.text = nil
            baCityTF.text = nil
            baStateTF.text = nil
            baZipCodeTF.text = nil
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
        
//        saStreet1TF.delegate = self
//        saStreet2TF.delegate = self
//        saCityTF.delegate = self
//        saStateTF.delegate = self
//        saZipCodeTF.delegate = self
//        baStreet1TF.delegate = self
//        baStreet2TF.delegate = self
//        baCityTF.delegate = self
//        baStateTF.delegate = self
//        baZipCodeTF.delegate = self
    }
}

