//
//  WWPickerView.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 22/08/23.
//

import UIKit

class WWPickerView: UIPickerView {

    var customBackgroundColor = WWColors.hexFFFFFF.color

    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)

        if newWindow != nil {
            inputView?.backgroundColor = customBackgroundColor
        }
    }
}
