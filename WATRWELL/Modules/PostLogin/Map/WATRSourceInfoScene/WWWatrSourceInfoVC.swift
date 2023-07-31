//
//  WWWatrSourceInfoVC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 29/07/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWWatrSourceInfoVC: WWBaseVC {
    
    // Outlets
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var locLogoImageView: UIImageView!
    @IBOutlet weak var locTitleLabel: WWLabel!
    @IBOutlet weak var locSubtitleLabel: WWLabel!
    @IBOutlet weak var locStreetAddLabel: WWLabel!
    @IBOutlet weak var watrSrcTypeLabel: WWLabel!
    
    @IBOutlet weak var electrolyteStackView: UIStackView! {
        didSet{
            elcDetailButton.isHidden = electrolyteStackView.isHidden
        }
    }
    @IBOutlet weak var elcImageView: UIImageView!
    @IBOutlet weak var elcPercentLabel: WWLabel!
    @IBOutlet weak var elcNameLabel: WWLabel!
    @IBOutlet weak var elcDetailButton: UIButton!
    
    
    @IBOutlet weak var immunityStackView: UIStackView! {
        didSet{
            immDetailButton.isHidden = immunityStackView.isHidden
        }
    }
    @IBOutlet weak var immImageView: UIImageView!
    @IBOutlet weak var immPercentLabel: WWLabel!
    @IBOutlet weak var immNameLabel: WWLabel!
    @IBOutlet weak var immDetailButton: UIButton!
    
    
    @IBOutlet weak var antiAgingStackView: UIStackView! {
        didSet{
            aaDetailButton.isHidden = antiAgingStackView.isHidden
        }
    }
    @IBOutlet weak var aaImageView: UIImageView!
    @IBOutlet weak var aaPercentLabel: WWLabel!
    @IBOutlet weak var aaNameLabel: WWLabel!
    @IBOutlet weak var aaDetailButton: UIButton!
    
    
    @IBOutlet weak var stayStrongLabel: WWLabel!
    @IBOutlet weak var pageIndicator: UIPageControl!
    @IBOutlet weak var closeButton: UIButton!
    
    
    // Properties
    private var viewModel: WWWatrSourceInfoVM!
    // Overriden functions
    override func setupViews() {
        configure(with: viewModel)
    }
}

// MARK: - WWControllerType
extension WWWatrSourceInfoVC: WWControllerType {
    
    static func create(with viewModel: WWWatrSourceInfoVM) -> UIViewController {
        let watrSourceInfoScene = WWWatrSourceInfoVC.instantiate(fromAppStoryboard: .Map)
        watrSourceInfoScene.modalPresentationStyle = .overFullScreen
        watrSourceInfoScene.modalTransitionStyle = .crossDissolve
        watrSourceInfoScene.viewModel = viewModel
        return watrSourceInfoScene
    }
    
    func configure(with viewModel: WWWatrSourceInfoVM){
        let input = WWWatrSourceInfoVM.Input(closeDidTap: closeButton.rx.tap.asObservable())
        let output = viewModel.transform(input: input)
        
        output.closePopup.drive(onNext: { [weak self] in
            self?.dismiss(animated: true)
        }).disposed(by: rx.disposeBag)
    }
}

// MARK: - ViewController life cycle methods
extension WWWatrSourceInfoVC {
    
}

private extension WWWatrSourceInfoVC {
    
}

