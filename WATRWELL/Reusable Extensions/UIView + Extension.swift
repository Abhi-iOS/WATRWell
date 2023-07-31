//
//  UIView + Extension.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 29/07/23.
//

import UIKit

extension UIView {
    ///Sets the corner radius of the view
    @IBInspectable var `cornerRadius`: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    ///Sets the border width of the view
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    ///Sets the border color of the view
    @IBInspectable var borderColor: UIColor? {
        get {
            let color = UIColor(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    ///Sets the shadow color of the view
    @IBInspectable var shadowColor:UIColor? {
        set {
            layer.shadowColor = newValue!.cgColor
        }
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            else {
                return nil
            }
        }
    }
    
    ///Sets the shadow opacity of the view
    @IBInspectable var shadowOpacity:Float {
        set {
            layer.shadowOpacity = newValue
        }
        get {
            return layer.shadowOpacity
        }
    }
    
    ///Sets the shadow offset of the view
    @IBInspectable var shadowOffset:CGSize {
        set {
            layer.shadowOffset = newValue
        }
        get {
            return layer.shadowOffset
        }
    }
    
    ///Sets the shadow radius of the view
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    var size: CGSize {
        set { self.frame.size = newValue }
        get { return self.frame.size }
    }
    
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    var tableViewCell : UITableViewCell? {
        
        var subviewClass = self
        
        while !(subviewClass is UITableViewCell){
            guard let view = subviewClass.superview else { return nil }
            subviewClass = view
        }
        return subviewClass as? UITableViewCell
    }
    
    func tableViewIndexPath(_ tableView: UITableView) -> IndexPath? {
        if let cell = self.tableViewCell {
            return tableView.indexPath(for: cell)
        }
        return nil
    }
}

extension UIWindow {
    var currentViewController: UIViewController? {
        guard let rootViewController = self.rootViewController else { return nil}
        return topViewController(for: rootViewController)
    }
    
    private func topViewController(for rootViewController: UIViewController?) -> UIViewController? {
        guard let rootViewController = rootViewController else {
            return nil
        }
        switch rootViewController {
        case is UINavigationController:
            let navigationController = rootViewController as! UINavigationController
            return topViewController(for: navigationController.viewControllers.last)
        case is UITabBarController:
            let tabBarController = rootViewController as! UITabBarController
            return topViewController(for: tabBarController.selectedViewController)
        default:
            guard let presentedViewController = rootViewController.presentedViewController else {
                return rootViewController
            }
            return topViewController(for: presentedViewController)
        }
    }
}
