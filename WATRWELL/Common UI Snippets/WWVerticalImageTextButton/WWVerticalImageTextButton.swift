//
//  WWVerticalImageTextButton.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 25/07/23.
//

import UIKit

class WWVerticalImageTextButton: UIButton {
    // MARK: - Properties
    private let verticalSpacing: CGFloat = 8 // Adjust this value for spacing between image and text
    
    var showUnderline: Bool = true {
        didSet {
            updateTitleAppearance()
        }
    }
    
    var normalTitleColor: UIColor = .black {
        didSet {
            updateTitleAppearance()
        }
    }
    
    var selectedTitleColor: UIColor = .black {
        didSet {
            updateTitleAppearance()
        }
    }
    
    var disabledTitleColor: UIColor = .lightGray {
        didSet {
            updateTitleAppearance()
        }
    }
    
    var font: UIFont = WWFonts.europaRegular.withSize(12) {
        didSet {
            updateTitleAppearance()
        }
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    // MARK: - Setup Views
    private func setupViews() {
        imageView?.contentMode = .scaleAspectFit
        titleLabel?.textAlignment = .center
        titleLabel?.font = WWFonts.europaRegular.withSize(12)
        updateTitleAppearance()
    }

    // MARK: - Layout Subviews
    override func layoutSubviews() {
        super.layoutSubviews()

        guard let imageView = imageView, let titleLabel = titleLabel else { return }

        // Center the image and label horizontally
        imageView.center.x = bounds.width / 2
        titleLabel.center.x = bounds.width / 2

        // Position the image above the label with the specified vertical spacing
        let totalHeight = imageView.frame.height + verticalSpacing + titleLabel.frame.height
        imageView.frame.origin.y = (bounds.height - totalHeight) / 2
        titleLabel.frame.origin.y = imageView.frame.maxY + verticalSpacing
    }
    
    private func updateTitleAppearance() {
        guard let title = titleLabel?.text else { return }
        tintColor = normalTitleColor
        let underlineStyle: NSUnderlineStyle = showUnderline ? .single : []
        let attributes: [NSAttributedString.Key: Any] = [.underlineStyle: underlineStyle.rawValue,
                                                         .underlineColor: normalTitleColor,
                                                         .font: font]
        let attributedText = NSAttributedString(string: title, attributes: attributes)
        setAttributedTitle(attributedText, for: .normal)
    }
    
    override func setTitle(_ title: String?, for state: UIControl.State) {
        titleLabel?.text = title
        updateTitleAppearance()
    }
}
