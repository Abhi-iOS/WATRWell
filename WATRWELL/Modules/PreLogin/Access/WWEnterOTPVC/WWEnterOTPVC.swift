//
//  WWEnterOTPVC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 25/07/23.
//

import UIKit
import RxSwift
import RxCocoa

final class WWEnterOTPVC: WWBaseVC {
    
    // Outlets
    @IBOutlet weak var titleLabel: WWLabel!
    @IBOutlet weak var otpTextField: WWTextField!
    @IBOutlet weak var resendLabel: WWLabel!
    @IBOutlet weak var resendButton: WWFilledButton!
    @IBOutlet weak var exitButton: WWVerticalImageTextButton!
    @IBOutlet weak var stepContainerStackView: UIStackView!
    
    // Properties
    private(set) var viewModel: WWEnterOTPVM!
    
    // Overriden functions
    override func setupViews() {
        super.setupViews()
        stepContainerStackView.isHidden = viewModel.incomingCase == .access
        otpTextField.delegate = self
        otpTextField.keyboardType = .numberPad
        configure(with: viewModel)
    }
}

// MARK: - WWControllerType
extension WWEnterOTPVC: WWControllerType {
    
    static func create(with viewModel: WWEnterOTPVM) -> UIViewController {
        let enterPhoneScene = WWEnterOTPVC.instantiate(fromAppStoryboard: .PreLogin)
        enterPhoneScene.viewModel = viewModel
        return enterPhoneScene
    }
    
    func configure(with viewModel: WWEnterOTPVM){
        let input = WWEnterOTPVM.Input(otpTextInput: otpTextField.textFieldText,
                                       resendDidTap: resendButton.rx.tap.asObservable(),
                                       exitDidTap: exitButton.rx.tap.asObservable())
        
        let output = viewModel.transform(input: input)
        
        output.editMobileNumber.drive(onNext: { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }).disposed(by: rx.disposeBag)
        
        output.otpVerificationSuccess.drive(onNext: { [weak self] in
            self?.navigateToNextScene()
        }).disposed(by: rx.disposeBag)
        
        output.hideResendButton.bind(to: resendButton.rx.isHidden).disposed(by: rx.disposeBag)
        output.updatedTimerValue.bind(to: resendLabel.rx.text).disposed(by: rx.disposeBag)
    }
}

private extension WWEnterOTPVC {
    func navigateToNextScene() {
        switch viewModel.incomingCase {
        case .access:
            loginUserAndRedirectToHome()
        case .enlist:
            moveToNextStep()
        }
    }
    
    func loginUserAndRedirectToHome() {
        WWRouter.shared.setTabbarAsRoot(sourceType: .notSubscribed)
    }
    
    func moveToNextStep() {
        let scene = WWStep2VC.create(with: WWStep2VM())
        navigationController?.pushViewController(scene, animated: true)
    }
}

extension WWEnterOTPVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let userEnteredString = textField.text ?? ""
        let newString = (userEnteredString as NSString).replacingCharacters(in: range, with: string) as String
        return newString.isNumeric && newString.count <= 6
    }
}
