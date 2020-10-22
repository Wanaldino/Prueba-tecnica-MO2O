//
//  BeerDetailBuilder.swift
//  Prueba tecnica MO2O
//
//  Created by Wanaldino Antimonio on 22/10/2020.
//

import UIKit

class BeerDetailBuilder: Builder {
    let beer: Beer
    
    init(beer: Beer) {
        self.beer = beer
    }
    
    func build() -> UIViewController {
        let viewModel = BeerDetailViewModel(beer: beer)
        let viewController = BeerDetailViewController(viewModel: viewModel)
        
        return viewController
    }
}
