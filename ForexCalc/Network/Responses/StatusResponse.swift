//
//  StatusResponse.swift
//  ForexCalc
//
//  Created by Bill on 27/7/24.
//

import Foundation

struct StatusResponse: Decodable {
    let quotas: Quotas?
}

struct Quotas: Decodable {
    let month: Month?
}

struct Month: Decodable {
    let total: Int?
    let used: Int?
    let remaining: Int?
}
