//
//  WWDiscoverPopupVC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 20/08/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWDiscoverPopupVC: WWBaseVC {
    
    // Outlets
    @IBOutlet weak var popupImage: UIImageView!
    @IBOutlet weak var popupCloseButton: UIButton!
    
    // Properties
    var image: UIImage?
    // Overriden functions
    override func setupViews() {
        popupImage.image = self.image
    }
    
    @IBAction private func closePopupTap(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

// MARK: - WWControllerType
extension WWDiscoverPopupVC {
    static func create(with image: UIImage?) -> UIViewController {
        let discoverPopup = WWDiscoverPopupVC.instantiate(fromAppStoryboard: .Discover)
        discoverPopup.modalPresentationStyle = .overFullScreen
        discoverPopup.modalTransitionStyle = .crossDissolve
        discoverPopup.image = image
        return discoverPopup
    }
}
