//
//  WWPaymentSlider.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 29/07/23.
//

import Foundation
import UIKit

class CustomSlider: UISlider {
    
    @IBInspectable
    var thumbImage: UIImage? {
        didSet {
            setThumbImage(thumbImage, for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Set the slider's minimum and maximum values
        minimumValue = 0
        maximumValue = 1
        
        // Disable continuous update mode
        isContinuous = false
        
        // Add a target for value change events
        addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }
    
    // Custom method to update the slider value with animation
    private func updateSliderValue(_ value: Float) {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 0.5,
                       options: [.curveEaseInOut, .beginFromCurrentState],
                       animations: {
                           self.setValue(value, animated: true)
                       },
                       completion: nil)
    }
    
    // Triggered when the slider value changes
    @objc private func sliderValueChanged() {
        print(value)
        let roundedValue: Float = (value >= 0.65) ? 1.0 : 0.0
        updateSliderValue(roundedValue)
    }
}
