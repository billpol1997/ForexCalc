//
//  MainViewModel.swift
//  ForexCalc
//
//  Created by Bill on 26/7/24.
//

import Foundation
import SwiftUI

final class MainViewModel: ObservableObject {
    
    //MARK: Vars
    @Published var buttons: [[ButtonsEnum]]
    @Published var result: String = "0"
    @Published var toggledFunction: (type: MathFunctionsEnum, isOn: Bool) = (.none, false)
    @Published var baseCurrency: CurrencyEnum = .euro
    @Published var currencyList: [CurrencyEnum] = [.usd, .yen, .pounds]
    @Published var showConvertionError: Bool = false
    var dataFactory: MainDataFactory
    private var storedNumber: Double = 0
    private var manager = NetworkManager.shared
    private var response: ConvertCurrencyResponse?
    
    //MARK: Init
    init(dataFactory: MainDataFactory) {
        self.dataFactory = DIContainer.shared.getContainerSwinject().resolve(MainDataFactory.self)!
        self.buttons = self.dataFactory.initializeButtons()
        self.fetchCurrencies()
    }
    
    //MARK: Network fetching
    func fetchRates() async {
        do {
            self.response = try await manager.getConvertionRates(from: baseCurrency.rawValue, to: self.assignList())
        } catch {
            self.showConvertionError = true
        }
    }
    
    private func fetchCurrencies() {
        Task { [weak self] in
            guard let self else { return }
            await self.fetchRates()
        }
    }
    
    //MARK: Handle currency list
    private func assignList() -> [String] {
        return dataFactory.assignList(currencyList: self.currencyList)
    }
    
    private func changeBase(with currency: CurrencyEnum) {
        if currency != self.baseCurrency {
            currencyList.removeAll { item in
                item == currency
            }
            currencyList.append(self.baseCurrency)
            self.baseCurrency = currency
            self.fetchCurrencies()
        }
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
    
    func convertCurrency(to currency: CurrencyEnum) {
        let rate = response?.data?[currency.rawValue] ?? 0.0
        let newRes = (Double(self.result) ?? 0.0) * rate
        self.result = newRes != 0 ? String(format: "%.3f", newRes) : "Error"
        self.changeBase(with: currency)
    }
    
    private func updateResult(with number: String) {
        if self.result == "0" && number != "0" {
            self.result = number
        } else {
            if self.toggledFunction.isOn && Double(self.result) == self.storedNumber {
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
        let newRes = (Double(self.result) ?? 0) / 100
        self.result = String(newRes)
    }
    
    private func reset() {
        self.result = "0"
        self.storedNumber = 0
        self.toggledFunction = (.none, false)
    }
    
    private func toggleFunction(type: MathFunctionsEnum) {
        self.toggledFunction = (type, true)
        self.storedNumber = Double(self.result) ?? 0
    }
    
    private func getResult() {
        if self.toggledFunction.isOn && self.storedNumber != 0 {
            switch self.toggledFunction.type {
            case .add:
                let nerRes = self.storedNumber + (Double(self.result) ?? 0)
                self.result = String(nerRes)
            case .subtract:
                let nerRes = self.storedNumber - (Double(self.result) ?? 0)
                self.result = String(nerRes)
            case .divide:
                let nerRes =  self.storedNumber / (Double(self.result) ?? 0)
                self.result = String(nerRes)
            case .multiply:
                let nerRes = self.storedNumber * (Double(self.result) ?? 0)
                self.result = String(nerRes)
            case .none:
                break
            }
            self.toggledFunction = (.none, false)
            self.removeDecimal()
        }
    }
    
    private func removeDecimal() {
        let value = Double(self.result) ?? 0.0
        if value.truncatingRemainder(dividingBy: 1) == 0 {
            self.result = String(Int(value))
        }
    }
}

//MARK: Extension
extension String {
    func toFormattedNumberToString(_ numberFormatter: NumberFormatter? = nil) -> String? {
        let formatter = (numberFormatter != nil) ? numberFormatter : NumberFormatter()
        formatter?.numberStyle = .decimal
        formatter?.maximumFractionDigits = 3
        formatter?.minimumFractionDigits = 0
        formatter?.groupingSeparator = ","
        formatter?.locale = Locale(identifier: "en_US")
        return formatter?.string(from: NSNumber(value: Double(self) ?? 0.0))
    }
}
