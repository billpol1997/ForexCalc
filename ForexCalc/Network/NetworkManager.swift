//
//  NetworkManager.swift
//  ForexCalc
//
//  Created by Bill on 27/7/24.
//

import Foundation
import Alamofire

final class NetworkManager {
    let service = NetworkService()
    static let shared = NetworkManager()
    
    let headers: HTTPHeaders = [
        "apikey" : Constants.shared.getKey()
    ]
    
    func getConvertionRates(from base: String, to currencies: [String]) async throws -> ConvertCurrencyResponse {
        let parameters: [String : String] = [
            "base_currency": base,
            "currencies": currencies.joined(separator: ",")
        ]
        
        let data: ConvertCurrencyResponse = try await service.fetchData(from: UrlEnum.convert.rawValue, method: .get, headers: headers, parameters: parameters ,responseModel: ConvertCurrencyResponse.self)
        return data
    }
}
