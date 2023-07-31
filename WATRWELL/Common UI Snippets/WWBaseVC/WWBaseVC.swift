//
//  WWBaseVC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 25/07/23.
//

import UIKit

class WWBaseVC: UIViewController {
    // Outlets
    
    // Properties
    
    // MARK: - Overrideable Methods
    open func setupViews() {
        
    }
    
}

//MARK: View life cycle method
extension WWBaseVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }
}

//MARK: Private functions
private extension WWBaseVC {
    
}
