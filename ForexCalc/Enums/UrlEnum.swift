//
//  UrlEnum.swift
//  ForexCalc
//
//  Created by Bill on 27/7/24.
//

import Foundation

enum UrlEnum: String {
    case status = "https://api.freecurrencyapi.com/v1/status"
    case symbol = "https://data.fixer.io/api/symbols"
    case convert = "https://data.fixer.io/api/convert"
}
