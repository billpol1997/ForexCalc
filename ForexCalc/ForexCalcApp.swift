//
//  ForexCalcApp.swift
//  ForexCalc
//
//  Created by Bill on 26/7/24.
//

import SwiftUI

@main
struct ForexCalcApp: App {
    var body: some Scene {
        WindowGroup {
            DIContainer.shared.getContainerSwinject().resolve(MainView.self)!
        }
    }
}
