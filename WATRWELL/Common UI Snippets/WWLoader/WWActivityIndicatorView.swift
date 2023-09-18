//
//  WWActivityIndicatorView.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 18/09/23.
//

import UIKit
import ImageIO

class WWActivityIndicatorView: UIView {
    
    // MARK: - Properties
    static let shared = WWActivityIndicatorView()
    private let loaderSize: CGFloat = 200.0
    private var gifImageView: UIImageView?
    
    // MARK: - Initialization
    private override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        let screenSize = UIScreen.main.bounds.size
        let x = (screenSize.width - loaderSize) / 2.0
        let y = (screenSize.height - loaderSize) / 2.0
        
        frame = UIScreen.main.bounds
        backgroundColor = WWColors.loaderBG.color
        isUserInteractionEnabled = false
        gifImageView = UIImageView()
        gifImageView?.contentMode = .scaleAspectFit
        if let gifImageView = gifImageView {
            addSubview(gifImageView)
            gifImageView.frame = CGRect(x: x, y: y, width: loaderSize, height: loaderSize)
        }
        isHidden = true
    }
    
    // MARK: - GIF Animation
    func startAnimating() {
        guard let gifURL = Bundle.main.url(forResource: "yegoa6grz7xa1", withExtension: "gif"),
              let source = CGImageSourceCreateWithURL(gifURL as NSURL, nil) else {
            return
        }
        
        let frameCount = CGImageSourceGetCount(source)
        var images: [UIImage] = []
        
        for index in 0..<frameCount {
            if let cgImage = CGImageSourceCreateImageAtIndex(source, index, nil) {
                let image = UIImage(cgImage: cgImage)
                images.append(image)
            }
        }
        
        gifImageView?.animationImages = images
        gifImageView?.animationDuration = TimeInterval(frameCount) * 0.1 // Adjust the speed of animation
        gifImageView?.startAnimating()
        
        isHidden = false
        
        let window = UIApplication.shared.keyWindow
        window?.addSubview(self)
    }
    
    func stopAnimatingAndRemove() {
        gifImageView?.stopAnimating()
        gifImageView?.animationImages = nil
        isHidden = true
        removeFromSuperview()
    }
}
