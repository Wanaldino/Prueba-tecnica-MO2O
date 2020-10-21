//
//  BeerSearchBuilder.swift
//  Prueba tecnica MO2O
//
//  Created by Wanaldino Antimonio on 21/10/2020.
//

import UIKit

class BeerSearchBuilder: Builder {
    func build() -> UIViewController {
        let dataManager = BeerSearchDataManager()
        let interactor = BeerSearchInteractor(dataManager: dataManager)
        let presenter = BeerSearchPresenter(interactor: interactor)
        let viewController = BeerSearchViewController(presenter: presenter)
        
        presenter.view = viewController
        
        return viewController
    }
}
