//
//  UIResponder+Extension.swift
//  Calculator
//
//  Created by user on 2023/6/28.
//

import UIKit

extension UIResponder {
    var parentController: UIViewController? {
        return next as? UIViewController ?? next?.parentController
    }
}
