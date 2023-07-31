//
//  WWControllerType.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 25/07/23.
//

import UIKit

protocol WWControllerType: UIViewController {
    associatedtype ViewModelType: WWViewModelProtocol
    func configure(with viewModel: ViewModelType)
    static func create(with viewModel: ViewModelType) -> UIViewController
    func disableCompletionForEmptyInput()
}

extension WWControllerType{
    static func create(with viewModel: ViewModelType) -> UIViewController {
        return UIViewController()
    }
    
    func disableCompletionForEmptyInput(){}
}

protocol WWViewModelProtocol {
    associatedtype Input
    associatedtype Output
    func transform(input: Input) -> Output
}

protocol WWViewModelClassProtocol: AnyObject, WWViewModelProtocol{
    
}

extension WWViewModelClassProtocol{
    var memoryAddress: UnsafeMutableRawPointer{
        return Unmanaged.passUnretained(self).toOpaque()
    }
}

extension UIViewController{
    var memoryAddress: UnsafeMutableRawPointer{
        return Unmanaged.passUnretained(self).toOpaque()
    }
}
