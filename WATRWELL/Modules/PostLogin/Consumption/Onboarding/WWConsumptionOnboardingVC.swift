//
//  WWConsumptionOnboardingVC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 20/08/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWConsumptionOnboardingVC: WWBaseVC {
    
    // Outlets
    @IBOutlet weak var navContainerView: UIView!
    @IBOutlet weak var dateTF: WWTextField!
    @IBOutlet weak var monthTF: WWTextField!
    @IBOutlet weak var yearTF: WWTextField!
    
    @IBOutlet weak var weightSlider: UISlider!
    @IBOutlet weak var weightLabel: WWLabel!
    @IBOutlet weak var saveButton: WWFilledButton!
    
    // Properties
    private var viewModel: WWConsumptionOnboardingVM!
    private var navBar: WWNavBarView = .fromNib()
    
    private let pickerView = WWPickerView()
    private let toolBar = UIToolbar()

    // Overriden functions
    override func setupViews() {
        configure(with: viewModel)
        setNavBar()
        setupTextField()
        weightSlider.setThumbImage(UIImage(named: "paymentSliderThumb"), for: .normal)
    }
}

// MARK: - WWControllerType
extension WWConsumptionOnboardingVC: WWControllerType {
    
    static func create(with viewModel: WWConsumptionOnboardingVM) -> UIViewController {
        let consumptionOnbrdScene = WWConsumptionOnboardingVC.instantiate(fromAppStoryboard: .Misc)
        consumptionOnbrdScene.viewModel = viewModel
        return consumptionOnbrdScene
    }
    
    func configure(with viewModel: WWConsumptionOnboardingVM){
        let saveDidTap = saveButton.rx.tap.do { [weak self] _ in
            self?.view.endEditing(true)
        }
            
        let input = WWConsumptionOnboardingVM.Input(weightUpdate: weightSlider.rx.value.asObservable(),
                                                    completeTap: saveDidTap)
        
        let output = viewModel.transform(input: input)
        
        output.weightLabelText.bind(to: weightLabel.rx.text).disposed(by: rx.disposeBag)
        output.goToNext.drive(onNext: { [weak self] _ in
            self?.goToPostOnboardingScene()
        }).disposed(by: rx.disposeBag)
    }
}

// MARK: - ViewController life cycle methods
extension WWConsumptionOnboardingVC {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        navBar.frame = navContainerView.bounds
    }
}

private extension WWConsumptionOnboardingVC {
    func setNavBar(){
        navContainerView.addSubview(navBar)
        view.layoutIfNeeded()
        navBar.shareDidTap = { [weak self] in
            self?.showMenu()
        }
    }
    
    func goToPostOnboardingScene() {
        let scene = WWDailyConsumptionVC.create(with: WWDailyConsumptionVM())
        navigationController?.pushViewController(scene, animated: true)
    }
    
    func showMenu() {
        let menuScene = WWMenuVC.create(with: WWMenuVM())
        tabBarController?.present(menuScene, animated: true)
    }
    
    func setupTextField() {
        dateTF.delegate = self
        monthTF.delegate = self
        yearTF.delegate = self
        
        setupPicker()
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
        toolBar.tintColor = WWColors.hex000000.color
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        
        let doneStream = doneButton.rx.tap.do(onNext: {[weak self] _ in
            guard let self else { return }
            switch self.viewModel.pickerType {
            case .day: self.dateTF.text = self.viewModel.selectedDay
            case .month: self.monthTF.text = self.viewModel.selectedMonth
            case .year: self.yearTF.text = self.viewModel.selectedYear
            }
        })
        
        let cancelStream = cancelButton.rx.tap.asObservable()
        
        Observable.merge(doneStream, cancelStream).asDriverOnErrorJustComplete().drive(onNext: {[weak self] _ in
            self?.view.endEditing(true)
        }).disposed(by: rx.disposeBag)
    }

}

extension WWConsumptionOnboardingVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case dateTF:
            viewModel.pickerType = .day
        case monthTF:
            viewModel.pickerType = .month
        case yearTF:
            viewModel.pickerType = .year
        default:
            return false
        }
        pickerView.reloadAllComponents()
        textField.inputView = pickerView
        textField.inputAccessoryView = toolBar
        return true
    }
}

extension WWConsumptionOnboardingVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        viewModel.dataSource.endIndex
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        viewModel.dataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.updatePickerData(viewModel.dataSource[row])
    }
}
