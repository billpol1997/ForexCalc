//
//  ButtonsEnum.swift
//  ForexCalc
//
//  Created by Bill on 26/7/24.
//

import Foundation

enum ButtonsEnum: CustomStringConvertible {
    case number(String)
    case zero, decimal, add, subtract, divide, multiply, equal, clear, percent, negative

    var description: String {
        switch self {
        case .number(let value):
            return value
        case .zero:
            return "0"
        case .decimal:
            return "."
        case .add:
            return "+"
        case .subtract:
            return "-"
        case .divide:
            return "/"
        case .multiply:
            return "*"
        case .equal:
            return "="
        case .clear:
            return "AC"
        case .percent:
            return "%"
        case .negative:
            return "-/+"
        }
    }
}
