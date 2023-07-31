//
//  WWMapVC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 25/07/23.
//

import Foundation
import RxSwift
import RxCocoa
import GoogleMaps

final class WWMapVC: WWBaseVC {
    
    // Outlets
    @IBOutlet weak var navView: UIView!
    @IBOutlet weak var titleLabel: WWLabel!
    @IBOutlet weak var willoButton: WWFilledButton!
    @IBOutlet weak var cactusButton: WWFilledButton!
    @IBOutlet weak var mapView: GMSMapView!
    
    // Properties
    private var viewModel: WWMapVM!
    private var navBarView: WWNavBarView = .fromNib()
    
    // Overriden functions
    override func setupViews() {
        setNavView()
        willoButton.setBlackFillButton()
        cactusButton.setWhiteFillButton()
        configure(with: viewModel)
    }
}

// MARK: - WWControllerType
extension WWMapVC: WWControllerType {

    static func create(with viewModel: WWMapVM) -> UIViewController {
        let mapScene = WWMapVC.instantiate(fromAppStoryboard: .Map)
        mapScene.viewModel = viewModel
        return mapScene
    }

    func configure(with viewModel: WWMapVM){
        let input = WWMapVM.Input(willoTapped: willoButton.rx.tap.asObservable(),
                                  cactusTapped: cactusButton.rx.tap.asObservable())
        
        let output = viewModel.transform(input: input)
        
        output.updateSelection.drive(onNext: { [weak self] option in
            guard let self else { return }
            self.updateMapOptionSelection(with: option)
        }).disposed(by: rx.disposeBag)
    }
}

// MARK: - ViewController life cycle methods
extension WWMapVC {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        navBarView.frame = navView.bounds
    }
}

private extension WWMapVC {
    func setNavView() {
        navView.addSubview(navBarView)
        view.layoutIfNeeded()
        navBarView.shareDidTap = { [weak self] in
            self?.showMenuOnTabBar()
        }
    }
    func updateMapOptionSelection(with option: WWMapVM.SelectedOption) {
        switch option {
        case .cactus:
            cactusButton.setBlackFillButton()
            willoButton.setWhiteFillButton()

        case .willo:
            willoButton.setBlackFillButton()
            cactusButton.setWhiteFillButton()
        }
        //TODO: - Map updates goes here
        showWatrSourceDetail()
    }
    
    func showMenuOnTabBar() {
        let menuScene = WWMenuVC.create(with: WWMenuVM())
        tabBarController?.present(menuScene, animated: true)
    }
    
    func showWatrSourceDetail(){
        let watrSourceScene = WWWatrSourceInfoVC.create(with: WWWatrSourceInfoVM())
        tabBarController?.present(watrSourceScene, animated: true)
    }
}

