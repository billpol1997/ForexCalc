//
//  MainDataFactory.swift
//  ForexCalc
//
//  Created by Bill on 28/7/24.
//

import Foundation
import SwiftUI

final class MainDataFactory {
    
    //MARK: Handle currency list
    func assignList(currencyList: [CurrencyEnum]) -> [String] {
        let list = currencyList.map { currency in
            currency.rawValue
        }
        return list
    }
    
    //MARK: UI logic
    func getButtonBGColor(button: ButtonsEnum) -> Color {
        switch button {
        case .number, .decimal, .zero:
            return Color.white.opacity(0.3)
        case .clear, .negative, .percent:
            return Color.white.opacity(0.8)
        default:
            return Color.orange
        }
    }
    
    func getButtonTextColor(button: ButtonsEnum) -> Color {
        switch button {
        case .clear, .negative, .percent:
            return Color.black
        default:
            return Color.white
        }
    }
    
    func getButtonWidth(button: ButtonsEnum) -> CGFloat {
        switch button {
        case .zero:
            return ((UIScreen.main.bounds.width - (4 * 12)) / 4 ) * 2
        default:
            return (UIScreen.main.bounds.width - (5 * 12)) / 4
        }
    }
    
    func initializeButtons() -> [[ButtonsEnum]] {
        let buttons = [
            [ ButtonsEnum.clear, ButtonsEnum.negative, ButtonsEnum.percent, ButtonsEnum.divide ],
            [ ButtonsEnum.number("1"),  ButtonsEnum.number("2"),  ButtonsEnum.number("3"), ButtonsEnum.multiply ],
            [ ButtonsEnum.number("4"),  ButtonsEnum.number("5"),  ButtonsEnum.number("6"), ButtonsEnum.subtract ],
            [  ButtonsEnum.number("7"),  ButtonsEnum.number("8"),  ButtonsEnum.number("9"), ButtonsEnum.add],
            [ ButtonsEnum.zero, ButtonsEnum.decimal, ButtonsEnum.equal]
        ]
        
        return buttons
    }
}
