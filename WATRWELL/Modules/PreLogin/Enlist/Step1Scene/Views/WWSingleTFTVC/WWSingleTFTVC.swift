//
//  WWSingleTFTVC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 30/07/23.
//

import UIKit

class WWSingleTFTVC: WWBaseTVC {

    //Outlets
    @IBOutlet weak var inputTextField: WWTextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setData(with text: String?, placeholder: String?) {
        inputTextField.placeholder = placeholder
        inputTextField.text = text
    }
    
}
