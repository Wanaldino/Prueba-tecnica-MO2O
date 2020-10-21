//
//  BeerSearchBuilder.swift
//  Prueba tecnica MO2O
//
//  Created by Wanaldino Antimonio on 21/10/2020.
//

import UIKit

class BeerSearchBuilder: Builder {
    func build() -> UIViewController {
        let viewController = BeerSearchViewController()
        
        return viewController
    }
}
