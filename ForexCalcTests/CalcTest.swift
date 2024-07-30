//
//  CalcTest.swift
//  ForexCalcTests
//
//  Created by Bill on 30/7/24.
//

import XCTest
@testable import ForexCalc

final class CalcTest: XCTestCase {
    
    //MARK: Init DataFactory and ViewModel
    let viewmodel = MainViewModel(dataFactory: MainDataFactory())
    
    //MARK: Test Math functions
    func testMathFunctions() {
        //MARK: Add
        self.viewmodel.getButtonData(button: .number("3"))
        self.viewmodel.getButtonData(button: .number("0"))
        self.viewmodel.getButtonData(button: .add)
        self.viewmodel.getButtonData(button: .number("3"))
        self.viewmodel.getButtonData(button: .number("0"))
        self.viewmodel.getButtonData(button: .equal)
        
        let isValidAdd = Int(self.viewmodel.result) == 60
        XCTAssert(isValidAdd)
        self.viewmodel.getButtonData(button: .clear)
        
        //MARK: Subtract
        self.viewmodel.getButtonData(button: .number("3"))
        self.viewmodel.getButtonData(button: .number("0"))
        self.viewmodel.getButtonData(button: .subtract)
        self.viewmodel.getButtonData(button: .number("3"))
        self.viewmodel.getButtonData(button: .number("0"))
        self.viewmodel.getButtonData(button: .equal)
        
        let isValidSub = Int(self.viewmodel.result) == 0
        XCTAssert(isValidSub)
        self.viewmodel.getButtonData(button: .clear)
        
        //MARK: Multiply
        self.viewmodel.getButtonData(button: .number("3"))
        self.viewmodel.getButtonData(button: .number("0"))
        self.viewmodel.getButtonData(button: .multiply)
        self.viewmodel.getButtonData(button: .number("3"))
        self.viewmodel.getButtonData(button: .number("0"))
        self.viewmodel.getButtonData(button: .equal)
        
        let isValidMut = Int(self.viewmodel.result) == 900
        XCTAssert(isValidMut)
        self.viewmodel.getButtonData(button: .clear)
        
        //MARK: Divide
        self.viewmodel.getButtonData(button: .number("3"))
        self.viewmodel.getButtonData(button: .number("0"))
        self.viewmodel.getButtonData(button: .divide)
        self.viewmodel.getButtonData(button: .number("3"))
        self.viewmodel.getButtonData(button: .number("0"))
        self.viewmodel.getButtonData(button: .equal)
        
        let isValidDiv = Int(self.viewmodel.result) == 1
        XCTAssert(isValidDiv)
        self.viewmodel.getButtonData(button: .clear)
    }
    
    //MARK: Test Format Functions
    func testFormatFunctions() {
        
        //MARK: Decimal
        self.viewmodel.getButtonData(button: .number("3"))
        self.viewmodel.getButtonData(button: .number("0"))
        self.viewmodel.getButtonData(button: .decimal)
        self.viewmodel.getButtonData(button: .number("5"))
        
        let isValidDec = Double(self.viewmodel.result) == 30.5
        XCTAssert(isValidDec)
        self.viewmodel.getButtonData(button: .clear)
        
        //MARK: Percent
        self.viewmodel.getButtonData(button: .number("3"))
        self.viewmodel.getButtonData(button: .number("0"))
        self.viewmodel.getButtonData(button: .percent)
        
        let isValidPer = Double(self.viewmodel.result) == 0.3
        XCTAssert(isValidPer)
        self.viewmodel.getButtonData(button: .clear)
        
        //MARK: Negative
        self.viewmodel.getButtonData(button: .number("3"))
        self.viewmodel.getButtonData(button: .number("0"))
        self.viewmodel.getButtonData(button: .negative)
        
        let isValidNeg = Double(self.viewmodel.result) == -30
        XCTAssert(isValidNeg)
        self.viewmodel.getButtonData(button: .clear)
    }
}
