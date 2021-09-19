//
//  DisabledTextField.swift
//  MyTravelHelper
//
//  Created by nadeem akram 9/19/21.
//  Copyright © 2021 Sample. All rights reserved.
//

import UIKit
class CustomTextField: UITextField {
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
}
