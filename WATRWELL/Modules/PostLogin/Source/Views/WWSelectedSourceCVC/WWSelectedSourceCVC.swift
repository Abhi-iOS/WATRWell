//
//  WWSelectedSourceCVC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 01/08/23.
//

import UIKit

class WWSelectedSourceCVC: WWBaseCVC {

    @IBOutlet private weak var titleLabel: WWLabel!
    @IBOutlet private weak var sourceTypeButton: UIButton!
    @IBOutlet private weak var upgradeDegradeButton: UIButton!
    
    var showUpdatePopup: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction private func updateSubscriptionTap(_ sender: UIButton) {
        showUpdatePopup?()
    }
    
    func setData(_ model: WWSubscriptionData) {
        sourceTypeButton.setImage(model.normalImage, for: .normal)
        sourceTypeButton.setImage(model.highlightedImage, for: .highlighted)
        titleLabel.text = model.title
    }
    

}
