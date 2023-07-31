//
//  WWSelectSourceCVC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 01/08/23.
//

import UIKit

class WWSelectSourceCVC: WWBaseCVC {

    //Outlets
    @IBOutlet weak var immunityStackView: UIStackView!
    @IBOutlet weak var antiAgingStackView: UIStackView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var gearButton: UIButton!
    @IBOutlet weak var disclosureButton: UIButton!
    @IBOutlet weak var paymentSlider: WWPaymentSlider!
    
    //Properties
    var tapHandler: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        disclosureButton.setImage(UIImage(named: "arrowDown"), for: .normal)
        disclosureButton.setImage(UIImage(named: "arrowUp"), for: .selected)
    }
    
    func setData(_ index: Int) {
        switch index {
        case 0:
            immunityStackView.isHidden = false
            antiAgingStackView.isHidden = false
            priceLabel.text = "$30"
        case 1:
            immunityStackView.isHidden = true
            antiAgingStackView.isHidden = true
            priceLabel.text = "$20"
        default: break
        }
    }
    
    @IBAction private func gearDidTap(_ sender: UIButton) {
        tapHandler?()
    }
    
    @IBAction private func disclosureTap(_ sender: UIButton) {
        disclosureButton.isSelected.toggle()
        gearButton.isHidden = disclosureButton.isSelected.not()
    }
    
}
