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
        stepContainerStackView.isHidden = viewModel.incomingCase != .enlist
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
        output.popToRoot.drive(onNext: { _ in
            WWRouter.shared.setRootScene()
        }).disposed(by: rx.disposeBag)
    }
}

private extension WWEnterOTPVC {
    func navigateToNextScene() {
        switch viewModel.incomingCase {
        case .access:
            loginUserAndRedirectToHome()
        case .enlist:
            moveToNextStep()
        case .updateNumber:
            viewModel.updateNumber()
        }
    }
    
    func loginUserAndRedirectToHome() {
        if WWUserModel.currentUser.firstName == nil {
            moveToEnlistUser()
        } else {
            WWRouter.shared.setTabbarAsRoot(sourceType: WWUserModel.currentUser.subscriptionTypeValue == nil ? .notSubscribed : .subscribed)
        }
    }
    
    func moveToEnlistUser() {
        if let mobile = WWUserModel.currentUser.phone,
           mobile.isEmpty.not() {
            let step1Scene = WWStep1VC.create(with: WWStep1VM(mobile:  mobile, isNumberVerified: true))
            navigationController?.pushViewController(step1Scene, animated: true)
        }
    }
    
    func moveToNextStep() {
        let scene = WWStep2VC.create(with: WWStep2VM(dataModel: WWEnlistUserModel(with: WWUserModel.currentUser)))
        navigationController?.pushViewController(scene, animated: true)
    }
}

extension WWEnterOTPVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let userEnteredString = textField.text ?? ""
        let newString = (userEnteredString as NSString).replacingCharacters(in: range, with: string) as String
        return (newString.isNumeric || newString == "") && newString.count <= 6
    }
}
