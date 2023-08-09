//
//  WWDiscoverInfoTextCVC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 30/07/23.
//

import UIKit

class WWDiscoverInfoTextCVC: WWBaseCVC {

    // Outlets
    @IBOutlet weak var emptyLabelView: WWLabel!
    @IBOutlet weak var titleLabel: WWLabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var descLabel: WWLabel!
    @IBOutlet weak var clickToViewButton: WWVerticalImageTextButton!
    
    // Properties
    var clickTapHandler: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        emptyLabelView.isHidden = true
        logoImageView.image = UIImage(named: "logo-latest 1")?.withRenderingMode(.alwaysTemplate)
        logoImageView.isHidden = true
        clickToViewButton.isHidden = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        emptyLabelView.isHidden = true
        logoImageView.isHidden = true
        clickToViewButton.isHidden = true
    }
    
    @IBAction private func clickToViewTap(_ sender: WWVerticalImageTextButton) {
        clickTapHandler?()
    }
    
    
    func setData(with data: WWDiscoverDataModel) {
        titleLabel.text = data.title
        descLabel.textAlignmentOverride = .center
        if let tint = data.logoTint {
            emptyLabelView.isHidden = false
            logoImageView.image = UIImage(named: "logo-latest 1")?.withRenderingMode(.alwaysTemplate)
            logoImageView.tintColor = tint
            logoImageView.isHidden = false
            descLabel.textAlignmentOverride = .left
        }
        descLabel.attributedText = data.descText
        if let btn = data.buttonLogo {
            clickToViewButton.setImage(btn, for: .normal)
            clickToViewButton.isHidden = false
        }
        
        if clickToViewButton.isHidden && logoImageView.isHidden {
            emptyLabelView.isHidden = false
            logoImageView.isHidden = false
            logoImageView.image = nil
        }
    }
}
