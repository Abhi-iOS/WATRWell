//
//  WWLogoTVC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 28/07/23.
//

import UIKit

class WWLogoTVC: WWBaseTVC {

    // Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: WWLabel!
    @IBOutlet weak var subtitleLabel: WWLabel!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint! // deactivate to let image take original asset size
    
    // Properties
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.backgroundColor = .clear
        titleLabel.isHidden = true
        subtitleLabel.isHidden = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.isHidden = true
        subtitleLabel.isHidden = true
    }
    
    func setData(_ image: UIImage?) {
        logoImageView.image = image
    }
    
    func setDataForAccountCreation(logo: UIImage?, title: String?, subtitle: String?) {
        if let title {
            titleLabel.isHidden = false
            titleLabel.text = title
        }
        
        if let subtitle {
            subtitleLabel.isHidden = false
            subtitleLabel.text = subtitle
        }
        
        if let logo {
            heightConstraint.isActive = false
            logoImageView.image = logo
        }
    }
}
