//
//  WWStep4VC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 31/07/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWStep4VC: WWBaseVC {
    
    // Outlets
    @IBOutlet weak var weightLabel: WWLabel!
    @IBOutlet weak var weightSlider: UISlider!
    @IBOutlet weak var completeButton: WWFilledButton!
    @IBOutlet weak var alphaShiftImageView: UIImageView!
    
    // Properties
    private var viewModel: WWStep4VM!
    
    // Overriden functions
    override func setupViews() {
        configure(with: viewModel)
        setupSlider()
    }
}

// MARK: - WWControllerType
extension WWStep4VC: WWControllerType {
    
    static func create(with viewModel: WWStep4VM) -> UIViewController {
        let step4Scene = WWStep4VC.instantiate(fromAppStoryboard: .PreLogin)
        step4Scene.viewModel = viewModel
        return step4Scene
    }
    
    func configure(with viewModel: WWStep4VM){
        let weightSliderStream = weightSlider.rx.value.do { [weak self] value in
            self?.alphaShiftImageView.alpha = CGFloat(value/500)
        }
        
        let input = WWStep4VM.Input(weightUpdate: weightSliderStream,
                                    completeTap: completeButton.rx.tap.asObservable())
        
        let output = viewModel.transform(input: input)
        output.weightLabelText.bind(to: weightLabel.rx.text).disposed(by: rx.disposeBag)
        output.goToNext.drive(onNext: { [weak self] in
            self?.moveToWelcomeScene()
        }).disposed(by: rx.disposeBag)
    }
}

private extension WWStep4VC {
    func setupSlider() {
        weightSlider.setThumbImage(UIImage(named: "paymentSliderThumb"), for: .normal)
    }
    
    func moveToWelcomeScene() {
        let welcomeScene = WWWelcomeVC.instantiate(fromAppStoryboard: .PreLogin)
        navigationController?.pushViewController(welcomeScene, animated: true)
    }
}

