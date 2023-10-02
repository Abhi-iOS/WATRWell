//
//  WWPreSourcePopUpVC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 02/10/23.
//

import Foundation
import RxSwift
import RxCocoa

final class WWPreSourcePopUpVC: WWBaseVC {
    
    // Outlets
    @IBOutlet weak var clickHereLabel: UILabel!
    @IBOutlet weak var howItWorksLabel: UILabel!
    @IBOutlet weak var closeButton: WWVerticalImageTextButton!
    
    // Properties
    
    // Overriden functions
    override func setupViews() {
        setupClickHereLabel()
        setupHowItWorksLabel()
        closeButton.normalTitleColor = WWColors.hexFFFFFF.color
        closeButton.rx.tap.asDriver().drive(onNext: { [weak self] in
            self?.dismiss(animated: true)
        }).disposed(by: rx.disposeBag)
    }
}

private extension WWPreSourcePopUpVC {
    func setupClickHereLabel() {
        clickHereLabel.attributedText = "CLICK HERE TO LEARN HOW IT WORKS".underlinedString("CLICK HERE", color: WWColors.hexFFFFFF.color)
        clickHereLabel.isUserInteractionEnabled = true
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(tappedOnLabel(_ :)))
        tapgesture.numberOfTapsRequired = 1
        clickHereLabel.addGestureRecognizer(tapgesture)
    }
    
    func setupHowItWorksLabel() {
        howItWorksLabel.attributedText = "ALSO, YOU CAN ALWAYS LEARN BY CLICKING\nHOW IT WORKS IN THE MAIN MENU.".underlinedString("HOW IT WORKS", color: WWColors.hexFFFFFF.color)
        howItWorksLabel.isUserInteractionEnabled = true
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(tappedOnLabel(_ :)))
        tapgesture.numberOfTapsRequired = 1
        howItWorksLabel.addGestureRecognizer(tapgesture)

    }
    
    @objc func tappedOnLabel(_ gesture: UITapGestureRecognizer) {
        let clickHereText = clickHereLabel.attributedText?.string ?? ""
        let howItWorksText = howItWorksLabel.attributedText?.string ?? ""
        let clickHereRange = (clickHereText as NSString).range(of: "CLICK HERE")
        let howItWorksRange = (howItWorksText as NSString).range(of: "HOW IT WORKS")
        if gesture.didTapAttributedTextInLabel(label: clickHereLabel, inRange: clickHereRange) {
            showTutorial()
        } else if gesture.didTapAttributedTextInLabel(label: howItWorksLabel, inRange: howItWorksRange){
            showTutorial()
        }
    }
    
    func showTutorial() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "tabbarReset"), object: nil)
        dismiss(animated: true) {
            let tutorialScene = WWTutorialVC.instantiate(fromAppStoryboard: .Misc)
            sharedAppDelegate.window?.currentViewController?.navigationController?.pushViewController(tutorialScene, animated: true)
        }
    }
}

extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                                          y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x,
                                                     y: locationOfTouchInLabel.y - textContainerOffset.y);
        var indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        indexOfCharacter = indexOfCharacter + 4
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}
