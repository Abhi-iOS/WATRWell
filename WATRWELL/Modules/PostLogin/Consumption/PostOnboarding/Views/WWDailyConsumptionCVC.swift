//
//  WWDailyConsumptionCVC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 20/08/23.
//

import UIKit

class WWDailyConsumptionCVC: WWBaseCVC {

    @IBOutlet weak var titleLabel: WWLabel!
    @IBOutlet weak var bodyImageView: UIImageView!
    @IBOutlet weak var descLabel1: WWLabel!
    @IBOutlet weak var descLabel2: WWLabel!
    @IBOutlet weak var infoButton: UIButton!
    
    var infoButtonTap: (() -> ())?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(_ data: WWDailyConsumptionDataModel) {
        titleLabel.attributedText = data.title
        bodyImageView.image = data.image
        descLabel1.attributedText = data.desc1Text
        descLabel2.attributedText = data.desc2Text
        
        descLabel2.isHidden = data.desc2Text == nil
    }
    
    @IBAction private func didTapInfoButton(_ sender: Any) {
        infoButtonTap?()
    }
}
