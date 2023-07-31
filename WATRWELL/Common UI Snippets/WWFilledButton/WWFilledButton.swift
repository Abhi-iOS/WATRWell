//
//  WWFilledButton.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 25/07/23.
//

import UIKit

@IBDesignable
class WWFilledButton: UIButton {

    enum CornerStyle: String {
        case none, round, normal
    }
    // MARK: - Inspectable Properties
    @IBInspectable var bgColor: UIColor = WWColors.hex000000.color {
        didSet {
            updateBackground()
        }
    }
    
    @IBInspectable var customTintColor: UIColor = WWColors.hexFFFFFF.color {
        didSet {
            updateBackground()
        }
    }
    
    @IBInspectable var cornerStyle: String = CornerStyle.normal.rawValue {
        didSet {
            updateCornerStyle()
        }
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    private func setupButton() {
        titleLabel?.font = WWFonts.europaRegular.withSize(16)
        updateBackground()
        updateCornerStyle()
    }
    
    // MARK: - Update Button Appearance
    private func updateBackground() {
        backgroundColor = bgColor
        tintColor = customTintColor
    }
    
    func setWhiteFillButton() {
        bgColor = WWColors.hexFFFFFF.color
        customTintColor = WWColors.hex000000.color
    }
    
    func setBlackFillButton() {
        bgColor = WWColors.hex000000.color
        customTintColor = WWColors.hexFFFFFF.color
    }
    
    private func updateCornerStyle() {
        guard let style = CornerStyle(rawValue: cornerStyle) else {
            return
        }
        
        switch style {
        case .none:
            layer.cornerRadius = 0
        case .round:
            layer.cornerRadius = bounds.height / 2.0
        case .normal:
            layer.borderColor = WWColors.hex000000.color.cgColor
            layer.borderWidth = 0.5
            layer.cornerRadius = 12
        }
    }
    
    // MARK: - Interface Builder Live Rendering
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupButton()
    }
}
