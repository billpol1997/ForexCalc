//
//  Constants.swift
//  ForexCalc
//
//  Created by Bill on 29/7/24.
//

import Foundation

final class Constants {
    
    static let shared = Constants()
    
    func getKey() -> String {
        if let path = Bundle.main.path(
            forResource: "Keys",
            ofType: "plist"
        ), let xml = FileManager.default.contents(
            atPath: path
        ), let plist = try? PropertyListSerialization.propertyList(
            from: xml,
            options: .mutableContainersAndLeaves,
            format: nil
        ) as? [String: Any] {
            if let apiKey = plist["API_KEY"] as? String {
                return apiKey
            } else {
                return "Error"
            }
        } else {
            return "Error"
        }
    }
   
}
