//
//  NSAttributeString+Extension.swift
//  Calculator
//
//  Created by user on 2023/6/26.
//

import Foundation
import UIKit

extension NSAttributedString {
    func color(_ color: UIColor, for subString: String? = nil) -> NSAttributedString {
        return NSMutableAttributedString(attributedString: self)
            .add(key: .foregroundColor, value: color, for: subString)
    }
}

extension NSAttributedString {
    func font(_ font: UIFont, for subString: String? = nil) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        let originLineHeight = font.lineHeight
        paragraphStyle.minimumLineHeight = originLineHeight
        
        return NSMutableAttributedString(attributedString: self)
            .add(key: .font, value: font, for: subString)
            .add(key: .paragraphStyle, value: paragraphStyle, for: subString)
    }
}

extension NSAttributedString {
    func alignment(_ alignment: NSTextAlignment) -> NSAttributedString {
        var result = self
        
        let value = NSMutableParagraphStyle()
        value.alignment = alignment
        result = add(key: .paragraphStyle, value: value)
        
        return result
    }
}

// MARK: - Private

private extension NSAttributedString {
    func add(key: NSAttributedString.Key, value: Any, for subString: String? = nil) -> NSAttributedString {
        let result: NSMutableAttributedString = .init(attributedString: self)
        let range: NSRange
        
        if let subString = subString {
            range = (string as NSString).range(of: subString)
        }
        else {
            range = NSRange(location: 0, length: string.utf16.count)
        }
        
        result.addAttribute(key, value: value, range: range)
        return result
    }
}
