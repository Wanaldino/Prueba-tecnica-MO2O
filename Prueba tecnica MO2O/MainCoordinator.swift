//
//  MainCoordinator.swift
//  Prueba tecnica MO2O
//
//  Created by Wanaldino Antimonio on 21/10/2020.
//

import UIKit

class MainCoordinator: Coordinator {
    let navigator: UINavigationController
    
    init(navigator: UINavigationController) {
        self.navigator = navigator
    }

    func start() {
        goToSearch()
    }
    
    func goToSearch() {
        let builder = BeerSearchBuilder { (beer) in
            self.goToDetail(of: beer)
        }
        let viewController = builder.build()
        navigator.pushViewController(viewController, animated: true)
    }
    
    func goToDetail(of beer: Beer) {
        let builder = BeerDetailBuilder(beer: beer)
        let viewController = builder.build()
        navigator.pushViewController(viewController, animated: true)
    }
}
