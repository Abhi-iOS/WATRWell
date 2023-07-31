//
//  WWStep1VC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 30/07/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWStep1VC: WWBaseVC {
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // Properties
    private(set) var viewModel: WWStep1VM!
    let initiateVerifyOTPSubject = PublishSubject<Void>()
    
    // Overriden functions
    override func setupViews() {
        configure(with: viewModel)
        setupTableView()
    }
}

// MARK: - WWControllerType
extension WWStep1VC: WWControllerType {
    
    static func create(with viewModel: WWStep1VM) -> UIViewController {
        let step1Scene = WWStep1VC.instantiate(fromAppStoryboard: .PreLogin)
        step1Scene.viewModel = viewModel
        return step1Scene
    }
    
    func configure(with viewModel: WWStep1VM){
        let input = WWStep1VM.Input(shouldInitiateOTPVerification: initiateVerifyOTPSubject.asObservable())
        
        let outpt = viewModel.transform(input: input)
        
        outpt.moveToNextScene.drive(onNext: { [weak self] in
            self?.goToOTPVerification()
        }).disposed(by: rx.disposeBag)
    }
}

// MARK: - ViewController life cycle methods
extension WWStep1VC {
    
}

private extension WWStep1VC {
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(with: WWLogoTVC.self)
        tableView.registerCell(with: WWSingleTFTVC.self)
        tableView.registerCell(with: WWFilledButtonTVC.self)
        tableView.registerCell(with: WWVerticalButtonTVC.self)
    }
    
    func goToOTPVerification() {
        let verifyOtpScene = WWEnterOTPVC.create(with: WWEnterOTPVM(incomingCase: .enlist))
        navigationController?.pushViewController(verifyOtpScene, animated: true)
    }
}

