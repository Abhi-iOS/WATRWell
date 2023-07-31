//
//  WWLabel.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 25/07/23.
//

import UIKit

final class WWLabel: UILabel {
    
    var textAlignmentOverride: NSTextAlignment = .center {
        didSet {
            self.textAlignment = textAlignmentOverride
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        self.textAlignment = textAlignmentOverride
    }
}
