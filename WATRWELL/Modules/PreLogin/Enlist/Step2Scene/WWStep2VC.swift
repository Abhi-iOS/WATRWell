//
//  WWStep2VC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 30/07/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWStep2VC: WWBaseVC {
    
    // Outlets
    @IBOutlet weak var selectCardButton: UIButton!
    @IBOutlet weak var dropdownView: CustomDropdownView!
    @IBOutlet weak var inputStackView: UIStackView!
    @IBOutlet weak var nameTextfield: WWTextField!
    @IBOutlet weak var cardNuTextfield: WWTextField!
    @IBOutlet weak var cvvTextfield: WWTextField!
    @IBOutlet weak var expiryTextfield: WWTextField!
    
    @IBOutlet weak var nextButton: WWFilledButton!
    @IBOutlet weak var exitButton: WWVerticalImageTextButton!
    
    // Properties
    private(set) var viewModel: WWStep2VM!
    let pickerView = UIPickerView()
    let toolBar = UIToolbar()
    let selectedExpirySubject = PublishSubject<String>()
    var formattedExpiry: String = ""
    var month: String = ""
    var year: String = ""
    
    // Overriden functions
    override func setupViews() {
        configure(with: viewModel)
        selectCardButton.configuration?.imagePadding = 8
        setupDropDown()
        setupTextFields()
        setupPicker()
    }
}

// MARK: - WWControllerType
extension WWStep2VC: WWControllerType {
    
    static func create(with viewModel: WWStep2VM) -> UIViewController {
        let step2Scene = WWStep2VC.instantiate(fromAppStoryboard: .PreLogin)
        step2Scene.viewModel = viewModel
        return step2Scene
    }
    
    func configure(with viewModel: WWStep2VM){
        let nextStream = nextButton.rx.tap.do { [weak self] _ in
            self?.view.endEditing(true)
        }
        let input = WWStep2VM.Input(nextTap: nextStream,
                                    exitTap: exitButton.rx.tap.asObservable())
        
        let output = viewModel.transform(input: input)
        
        output.moveToNext.drive(onNext: { [weak self] in
            self?.view.endEditing(true)
            self?.moveToNextStep()
        }).disposed(by: rx.disposeBag)
        
        output.moveToRoot.drive(onNext: { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }).disposed(by: rx.disposeBag)
        
        selectCardButton.rx.tap.asDriver().drive(onNext: { [weak self] in
            self?.dropdownView.isHidden.toggle()
        }).disposed(by: rx.disposeBag)
    }
}

// MARK: - ViewController life cycle methods
extension WWStep2VC {
    
}

private extension WWStep2VC {
    func setupDropDown() {
        dropdownView.setOptions(["CREDIT CARD", "DEBIT CARD"])
        dropdownView.didSelectOption = { [weak self] option in
            self?.dropdownView.isHidden = true
            self?.selectCardButton.setTitle("\(option) ▼", for: .normal)
            self?.inputStackView.isHidden = false
        }
    }
    
    func setupTextFields() {
        nameTextfield.delegate = self
        nameTextfield.textAlignment = .natural
        nameTextfield.placeholder = "NAME ON CARD"
        
        cardNuTextfield.delegate = self
        cardNuTextfield.textAlignment = .natural
        cardNuTextfield.placeholder = "CARD#"

        cvvTextfield.delegate = self
        cvvTextfield.textAlignment = .natural
        cvvTextfield.disableCopyPasteCapability = true
        cvvTextfield.placeholder = "CVV"
        
        expiryTextfield.delegate = self
        expiryTextfield.textAlignment = .natural
        expiryTextfield.disableCopyPasteCapability = true
        expiryTextfield.placeholder = "EXPIRATION DATE(MM/YY)"
    }
    
    func setupPicker() {
        pickerView.delegate = self
        pickerView.dataSource = self
        setupToolbar()
    }
    
    func setupToolbar() {
        let doneButton = UIBarButtonItem(title: "DONE", style: .plain, target: nil, action: nil)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "CANCEL", style: .plain, target: nil, action: nil)
        
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.barTintColor = WWColors.hexDF5509.color
        toolBar.tintColor = WWColors.hexFFFFFF.color
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        
        let doneStream = doneButton.rx.tap.do(onNext: {[weak self] _ in
            guard let self else { return }
            self.expiryTextfield.text = self.formattedExpiry
            self.viewModel.updateData(self.formattedExpiry, fieldType: .expiry)
        })
        
        let cancelStream = cancelButton.rx.tap.asObservable()
        
        Observable.merge(doneStream, cancelStream).asDriverOnErrorJustComplete().drive(onNext: {[weak self] _ in
            self?.view.endEditing(true)
        }).disposed(by: rx.disposeBag)
    }
    
    func moveToNextStep() {
        let step3Scene = WWStep3VC.create(with: WWStep3VM(dataModel: viewModel.dataModel))
        navigationController?.pushViewController(step3Scene, animated: true)
    }
}
