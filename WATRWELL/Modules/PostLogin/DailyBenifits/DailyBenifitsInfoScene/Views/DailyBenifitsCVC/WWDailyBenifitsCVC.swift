//
//  WWDailyBenifitsCVC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 29/07/23.
//

import UIKit

class WWDailyBenifitsCVC: WWBaseCVC {

    // Outlets
    @IBOutlet weak var titleLabel: WWLabel!
    @IBOutlet weak var goNextButton: WWVerticalImageTextButton!
    @IBOutlet weak var illusImageView: UIImageView!
    @IBOutlet weak var descLabel: WWLabel!
    
    var goNexthandler: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        goNextButton.showUnderline = false
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        goNextButton.isHidden = true
        illusImageView.image = nil
        descLabel.text = nil
    }
    
    func setData(with model: DailyBenifitsModel) {
        titleLabel.text = model.title
        goNextButton.isHidden = model.showGoNextButton.not()
        illusImageView.image = model.image
        descLabel.text = model.subtitle
        
        descLabel.isHidden = model.subtitle == nil
    }
    
    @IBAction func goNextTap(_ sender: WWVerticalImageTextButton) {
        goNexthandler?()
    }
    
}
