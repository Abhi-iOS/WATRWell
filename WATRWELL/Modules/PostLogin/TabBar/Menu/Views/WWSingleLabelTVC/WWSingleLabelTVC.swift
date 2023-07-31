//
//  WWSingleLabelTVC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 28/07/23.
//

import UIKit

class WWSingleLabelTVC: WWBaseTVC {

    // Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: WWLabel!
    
    // Properties
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.textColor = WWColors.hexFFFFFF.color
        containerView.backgroundColor = .clear
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setData(_ text: String?) {
        titleLabel.text = text
    }
}
