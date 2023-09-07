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
    var didSelectHandler: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        sourceTypeButton.isSelected = false
    }
    
    @IBAction private func updateSubscriptionTap(_ sender: UIButton) {
        showUpdatePopup?()
    }
    
    func setData(_ model: WWSubscriptionData) {
        sourceTypeButton.isSelected = model.isSelected
        sourceTypeButton.setImage(model.normalImage, for: .normal)
        sourceTypeButton.setImage(model.highlightedImage, for: .selected)
        titleLabel.text = model.title
    }
    
    @IBAction private func sourceTypeDidTap(_ sender: UIButton) {
        didSelectHandler?()
    }
    
}
