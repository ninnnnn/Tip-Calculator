//
//  String+Extension.swift
//  Calculator
//
//  Created by user on 2023/6/26.
//

import Foundation
import UIKit

extension String {
    func richText(font: UIFont, color: UIColor) -> NSAttributedString {
        NSAttributedString(string: self).font(font).color(color)
    }
}
