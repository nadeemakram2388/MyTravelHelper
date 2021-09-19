//
//  NSObjectExtension.swift
//  MyTravelHelper
//
//  Created by nadeem akram on 9/19/21.
//  Copyright © 2021 Sample. All rights reserved.
//

import Foundation
extension NSObject {
    class var name: String {
        return String(describing: self)
    }
}

import UIKit
extension UITextField {
    override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        guard inputView != nil else { return super.canPerformAction(action, withSender: sender) }

        return action == #selector(UIResponderStandardEditActions.paste(_:)) ?
            false : super.canPerformAction(action, withSender: sender)
    }
}
