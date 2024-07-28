//
//  DIContainer.swift
//  ForexCalc
//
//  Created by Bill on 26/7/24.
//

import Foundation
import Swinject

public protocol SwinjectInterface{
    func getContainerSwinject() -> Container
}

final class DIContainer: SwinjectInterface {
    static let shared = DIContainer()
    
    var diContainer: Container {
        let container = Container()
        
        container.register(MainView.self) { r in
            MainView(viewModel: r.resolve(MainViewModel.self)!)
        }
        
        container.register(MainDataFactory.self) { r in
            MainDataFactory()
        }
        
        container.register(MainViewModel.self) { r in
            MainViewModel(dataFactory: r.resolve(MainDataFactory.self)!)
        }
        
        return container
    }
   
    func getContainerSwinject() -> Container {
        return diContainer
    }
    
}
