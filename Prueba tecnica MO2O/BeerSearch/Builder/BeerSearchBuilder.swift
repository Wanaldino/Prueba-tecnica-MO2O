//
//  BeerSearchBuilder.swift
//  Prueba tecnica MO2O
//
//  Created by Wanaldino Antimonio on 21/10/2020.
//

import UIKit

class BeerSearchBuilder: Builder {
    let coordinatorOutput: (Beer) -> Void
    
    init(coordinatorOutput: @escaping (Beer) -> Void) {
        self.coordinatorOutput = coordinatorOutput
    }
    
    func build() -> UIViewController {
        let dataManager = BeerSearchDataManager()
        let interactor = BeerSearchInteractor(dataManager: dataManager)
        let presenter = BeerSearchPresenter(interactor: interactor, coordinatorOutput: coordinatorOutput)
        let viewController = BeerSearchViewController(presenter: presenter)
        
        presenter.view = viewController
        
        return viewController
    }
}
