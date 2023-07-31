//
//  WWNavBarView.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 30/07/23.
//

import UIKit

class WWNavBarView: UIView {
    
    // Outlets
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var shareButton: UIButton!
    @IBOutlet private weak var backButton: WWVerticalImageTextButton!
    
    // Properties
    var shareDidTap: (() -> ())?
    var backDidTap: (() -> ())?
    
    private let logoImage: UIImage? = {
        let image = UIImage(named: "logo-latest 1")?.withRenderingMode(.alwaysTemplate)
        return image
    }()

    // Setup functions
    override func awakeFromNib() {
        super.awakeFromNib()
        shouldHideBackButton()
        setLogoTint(WWColors.hexDF5509.color)
        logoImageView.image = logoImage
        backButton.showUnderline = false
    }
    
    @IBAction func shareButtonTap(_ sender: UIButton) {
        shareDidTap?()
    }
    
    @IBAction func backDidTap(_ sender: WWVerticalImageTextButton) {
        backDidTap?()
    }
    
    func shouldHideBackButton(_ status: Bool = true) {
        backButton.isHidden = status
    }
    
    func setLogoTint(_ color: UIColor) {
        logoImageView.tintColor = color
    }
    
}
