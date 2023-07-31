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
}
