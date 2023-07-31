//
//  WWTextField.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 25/07/23.
//

import Foundation
import UIKit
import RxSwift
import RxOptional

@IBDesignable
class WWTextField: UITextField {

    // MARK: - Inspectable Properties
    @IBInspectable var placeholderColor: UIColor = .lightGray {
        didSet {
            updateTextFormatting()
        }
    }
    
    @IBInspectable var customTextColor: UIColor = .black {
        didSet {
            updateTextFormatting()
        }
    }

    @IBInspectable var bottomLineColor: UIColor = .black {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable var underlineHeight: CGFloat = 0.5 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var textInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0) {
          didSet {
              setNeedsDisplay()
          }
      }

    @IBInspectable var centeredText: Bool = true {
        didSet {
            updateTextFormatting()
        }
    }
        
    var isNumericField: Bool = false
    var disableCopyPasteCapability: Bool = false
    
    var textFieldText: Observable<String> {
        return rx.text.asObservable().filterNil()
    }
    
    var textDidChanage : Observable<String>{
        return rx.controlEvent(.editingChanged).map {[weak self] _ -> String in
            self?.text ?? ""
        }
    }


    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        borderStyle = .none
        font = WWFonts.europaRegular.withSize(14)
        updateTextFormatting()
    }
    
    private func updateTextFormatting() {
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [.foregroundColor: placeholderColor,
                                                                                           .font: WWFonts.europaRegular.withSize(14)])
        textColor = customTextColor
        textAlignment = centeredText ? .center : .natural
        tintColor = textColor
    }

    // MARK: - Drawing

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        // Draw the bottom line
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: frame.height - underlineHeight, width: frame.width, height: underlineHeight)
        bottomLine.backgroundColor = bottomLineColor.cgColor
        layer.addSublayer(bottomLine)
    }
    
    //MARK: - Layout
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return adjustedRect(forBounds: bounds)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return adjustedRect(forBounds: bounds)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return adjustedRect(forBounds: bounds)
    }
    
    private func adjustedRect(forBounds bounds: CGRect) -> CGRect {
        let insetRect = bounds.inset(by: textInsets)
        return super.textRect(forBounds: insetRect)
    }
    
    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) || action == #selector(paste(_:)) && disableCopyPasteCapability {
            return false
        }
        return true
    }
}
