//
//  WWFilledButtonTVC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 30/07/23.
//

import UIKit

class WWFilledButtonTVC: WWBaseTVC {

    // Outlets
    @IBOutlet weak var filledButton: WWFilledButton!
    
    // Properties
    var buttonTapHandler: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateTitle(_ title: String) {
        filledButton.setTitle(title, for: .normal)
    }
    
    @IBAction private func didTapButton(_ sender: WWFilledButton) {
        buttonTapHandler?()
    }
    
}
