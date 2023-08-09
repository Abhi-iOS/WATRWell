//
//  WWSourcePopupCVC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 04/08/23.
//

import UIKit

class WWSourcePopupCVC: WWBaseCVC {
    
    @IBOutlet weak var blueLogo: UIImageView!
    @IBOutlet weak var orangeLogo: UIImageView!
    @IBOutlet weak var greenLogo: UIImageView!
    @IBOutlet weak var titleLabel: WWLabel!
    
    @IBOutlet weak var descLabel: WWLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        blueLogo.isHidden = true
        orangeLogo.isHidden = true
        greenLogo.isHidden = true
    }
    
    func setupData(with data: WWSourcePopupDataModel) {
        switch data.showIconType {
        case .all:
            blueLogo.isHidden = false
            orangeLogo.isHidden = false
            greenLogo.isHidden = false

        case .immunity:
            orangeLogo.isHidden = false

        case .electrolyte:
            blueLogo.isHidden = false

        case .antiAging:
            greenLogo.isHidden = false

        }
        titleLabel.attributedText = data.titleText
        titleLabel.isHidden = data.titleText == nil
        descLabel.attributedText = data.descriptionText
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        blueLogo.isHidden = true
        orangeLogo.isHidden = true
        greenLogo.isHidden = true
        titleLabel.isHidden = true
    }
}
