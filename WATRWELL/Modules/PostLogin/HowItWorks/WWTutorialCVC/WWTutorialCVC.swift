//
//  WWTutorialCVC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 07/09/23.
//

import UIKit

class WWTutorialCVC: WWBaseCVC {

    @IBOutlet weak var tutorialImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        tutorialImageView.image = nil
    }
    
    func setData(with image: UIImage?) {
        tutorialImageView.image = image
    }

}
