//
//  ConvertCurrencyResponse.swift
//  ForexCalc
//
//  Created by Bill on 27/7/24.
//

import Foundation

struct ConvertCurrencyResponse: Decodable {
    let data: [String : Double]?
}
