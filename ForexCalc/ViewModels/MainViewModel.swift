//
//  MainViewModel.swift
//  ForexCalc
//
//  Created by Bill on 26/7/24.
//

import Foundation
import SwiftUI

final class MainViewModel: ObservableObject {
    @Published var buttons: [[ButtonsEnum]] = []
    @Published var result: String = "0"
    @Published var toggledFunction: (type: MathFunctionsEnum, isOn: Bool) = (.none, false)
    private var storedNumber: Int = 0
    
    init() {
        self.buttons = self.initializeButtons()
    }
    
    
    //MARK: math calculation logic
    
    func getButtonData(button: ButtonsEnum) {
        switch button {
        case .number(let number):
            self.updateResult(with: number)
        case .zero:
            self.updateResult(with: "0")
        case .decimal:
            self.addDecimal()
        case .add:
            self.toggleFunction(type: .add)
        case .subtract:
            self.toggleFunction(type: .subtract)
        case .divide:
            self.toggleFunction(type: .divide)
        case .multiply:
            self.toggleFunction(type: .multiply)
        case .equal:
            self.getResult()
        case .clear:
            self.reset()
        case .percent:
            self.percentage()
        case .negative:
            self.switchNumberPolarity()
        }
    }
    
    private func updateResult(with number: String) {
        if self.result == "0" && number != "0" {
            self.result = number
        } else {
            if self.toggledFunction.isOn {
                self.result = number
            } else {
                let newRes = self.result + number
                self.result = newRes
            }
        }
    }
    
    private func addDecimal() {
        let newRes = self.result + "."
        self.result = newRes
    }
    
    private func switchNumberPolarity() {
        if Int(self.result) ?? 0 > 0 {
            let newRes = -1 * (Int(self.result) ?? 0)
            self.result = String(newRes)
        } else {
            let newRes = abs(Int(self.result) ?? 0)
            self.result = String(newRes)
        }
    }
    
    private func percentage() {
        let newRes = (Int(self.result) ?? 0) / 100
        self.result = String(newRes)
    }
    
    private func reset() {
        self.result = "0"
        self.storedNumber = 0
    }
    
    private func toggleFunction(type: MathFunctionsEnum) {
        self.toggledFunction = (type, true)
        self.storedNumber = Int(self.result) ?? 0
    }
    
    private func getResult() {
        if self.toggledFunction.isOn && self.storedNumber != 0 {
            switch self.toggledFunction.type {
            case .add:
                let nerRes = (Int(self.result) ?? 0) + self.storedNumber
                self.result = String(nerRes)
            case .subtract:
                let nerRes = (Int(self.result) ?? 0) - self.storedNumber
                self.result = String(nerRes)
            case .divide:
                let nerRes = (Int(self.result) ?? 0) / self.storedNumber
                self.result = String(nerRes)
            case .multiply:
                let nerRes = (Int(self.result) ?? 0) * self.storedNumber
                self.result = String(nerRes)
            case .none:
                break
            }
            self.toggledFunction = (.none, false)
        }
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
    
    private func initializeButtons() -> [[ButtonsEnum]] {
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
