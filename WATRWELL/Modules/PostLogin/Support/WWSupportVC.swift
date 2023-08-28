//
//  WWSupportVC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 20/08/23.
//

import RxSwift
import RxCocoa

final class WWSupportVC: WWBaseVC {
    
    // Outlets
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var navBarView: UIView!
    
    // Properties
    private var navBar: WWNavBarView = .fromNib()
    
    // Overriden functions
    override func setupViews() {
        setupPhoneButton()
        setNavBar()
    }
    
    
    @IBAction private func didTapPhone(_ sender: UIButton) {
        let sms = "sms:+1-(305)-456-9978&body=Hello WATRWELL team, Please address my concern for:\n"
        let strURL = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        UIApplication.shared.open(URL(string: strURL)!, options: [:], completionHandler: nil)
    }
    
}

// MARK: - ViewController life cycle methods
extension WWSupportVC {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        navBar.frame = navBarView.bounds
    }
}

private extension WWSupportVC {
    func setNavBar(){
        navBarView.addSubview(navBar)
        view.layoutIfNeeded()
        navBar.shareDidTap = { [weak self] in
            self?.showMenu()
        }
    }
    
    func setupPhoneButton() {
        phoneButton.configuration?.imagePadding = 8
    }
    
    
    func showMenu() {
        let menuScene = WWMenuVC.create(with: WWMenuVM())
        tabBarController?.present(menuScene, animated: true)
    }
    
}

