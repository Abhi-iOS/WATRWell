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
    @IBOutlet weak var sliderLabel: UILabel!
    @IBOutlet weak var sliderStackView: UIStackView!
    @IBOutlet weak var paymentSlider: WWPaymentSlider!
    @IBOutlet weak var cancelButton: WWFilledButton!
    
    //Properties
    var tapHandler: (() -> ())?
    var cancelHandler: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        disclosureButton.setImage(UIImage(named: "arrowDown"), for: .normal)
        disclosureButton.setImage(UIImage(named: "arrowUp"), for: .selected)
    }
    
    func setData(_ index: Int, viewType: WWSourceVM.IncomingCase) {
        switch viewType {
        case .modifySubscription:
            setData(for: index)
        default:
            cancelButton.isHidden = true
            switch index {
            case 0:
                immunityStackView.isHidden = false
                antiAgingStackView.isHidden = false
                priceLabel.text = "$30\nMONTHLY"
            case 1:
                immunityStackView.isHidden = true
                antiAgingStackView.isHidden = true
                priceLabel.text = "$20"
            default: break
            }
        }
    }
    
    private func setData(for index: Int) {
        switch index {
        case 0:
            immunityStackView.isHidden = WWUserModel.currentUser.subscriptionType == .onlyElectrolytes
            antiAgingStackView.isHidden = WWUserModel.currentUser.subscriptionType == .onlyElectrolytes
            priceLabel.text = WWUserModel.currentUser.subscriptionType == .onlyElectrolytes ? "$20\nMONTHLY" : "$30\nMONTHLY"
            cancelButton.isHidden = false
            sliderStackView.isHidden = true
        case 1:
            immunityStackView.isHidden = WWUserModel.currentUser.subscriptionType != .onlyElectrolytes
            antiAgingStackView.isHidden = WWUserModel.currentUser.subscriptionType != .onlyElectrolytes
            priceLabel.text = WWUserModel.currentUser.subscriptionType != .onlyElectrolytes ? "$20\nMONTHLY" : "$30\nMONTHLY"
            cancelButton.isHidden = true
            sliderStackView.isHidden = false
        default: break
        }
        sliderLabel.text = WWUserModel.currentUser.subscriptionType == .onlyElectrolytes ? "Slide to upgrade".uppercased() : "Slide to downgrade".uppercased()

    }
    
    @IBAction private func gearDidTap(_ sender: UIButton) {
        tapHandler?()
    }
    
    @IBAction private func disclosureTap(_ sender: UIButton) {
        disclosureButton.isSelected.toggle()
        gearButton.isHidden = disclosureButton.isSelected.not()
    }
    
    @IBAction private func cancelDidTap(_ sender: WWFilledButton) {
        cancelHandler?()
    }
}
