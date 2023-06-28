//
// Calculator.Models.swift

import UIKit

extension Calculator {
    enum Models {}
}

// MARK: - Enum

extension Calculator.Models {
    enum Tip {
        case none
        case tenPercent
        case fifteenPercent
        case twentyPercent
        case custom(value: Int)
        
        var stringValue: String {
            switch self {
            case .none:
                return ""
            case .tenPercent:
                return "10%"
            case .fifteenPercent:
                return "15%"
            case .twentyPercent:
                return "20%"
            case let .custom(value):
                return "\(value)%"
            }
        }
    }
}

// MARK: - Display Model

extension Calculator.Models {
    struct Result {
        let totalPerPerson: Double
        let totalBill: Double
        let totalTip: Double
    }
}
