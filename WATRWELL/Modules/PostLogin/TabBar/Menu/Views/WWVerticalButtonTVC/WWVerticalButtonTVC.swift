//
//  WWVerticalButtonTVC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 29/07/23.
//

import UIKit

class WWVerticalButtonTVC: WWBaseTVC {

    // Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var verticalButton: WWVerticalImageTextButton!
    
    // Properties
    var tapHandler: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.backgroundColor = .clear
        verticalButton.normalTitleColor = WWColors.hexFFFFFF.color
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setData(_ text: String?, _ image: UIImage?) {
        verticalButton.setImage(image, for: .normal)
        verticalButton.setTitle(text, for: .normal)
    }
    
    @IBAction func buttonDidTap(_ sender: WWVerticalImageTextButton) {
        tapHandler?()
    }
}
