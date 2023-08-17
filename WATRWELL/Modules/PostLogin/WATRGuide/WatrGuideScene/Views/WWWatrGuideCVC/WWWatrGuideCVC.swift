//
//  WWWatrGuideCVC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 30/07/23.
//

import UIKit

class WWWatrGuideCVC: WWBaseCVC {

    //Outlets
    @IBOutlet weak var titleLabel: WWLabel!
    @IBOutlet weak var bottleIcon: UIImageView!
    @IBOutlet weak var subtitleLabel: WWLabel!
    @IBOutlet weak var ifYouAreLabel: WWLabel!
    @IBOutlet weak var leftTitle1Label: WWLabel!
    @IBOutlet weak var rightTitle1Label: WWLabel!
    @IBOutlet weak var leftTitle2Label: WWLabel!
    @IBOutlet weak var rightTitle2Label: WWLabel!
    @IBOutlet weak var leftTitle3Label: WWLabel!
    @IBOutlet weak var rightTitle3Label: WWLabel!
    @IBOutlet weak var viewDescButton: UIButton!
    
    //Properties
    var viewDiscHandler: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    @IBAction func viewDescTap(_ sender: UIButton) {
        viewDiscHandler?()
    }
    
    func setData(with data: WWWatrGuideDataModel, index: Int) {
        titleLabel.attributedText = data.title
        switch index {
        case 0:
            bottleIcon.borderColor = WWColors.hex203D75.color
            ifYouAreLabel.textColor = WWColors.hex203D75.color
        case 1:
            bottleIcon.borderColor = WWColors.hexDF5509.color
            ifYouAreLabel.textColor = WWColors.hexDF5509.color
        case 2:
            bottleIcon.borderColor = WWColors.hexB3E6B5.color
            ifYouAreLabel.textColor = WWColors.hexB3E6B5.color
        default: break
        }
        leftTitle1Label.text = data.leftTitle1.uppercased()
        leftTitle2Label.text = data.leftTitle2.uppercased()
        leftTitle3Label.text = data.leftTitle3.uppercased()

        rightTitle1Label.attributedText = data.rightValue1
        rightTitle2Label.attributedText = data.rightValue2
        rightTitle3Label.attributedText = data.rightValue3
    }
}
