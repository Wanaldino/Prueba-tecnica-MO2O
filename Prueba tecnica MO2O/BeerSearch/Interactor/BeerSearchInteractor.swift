//
//  BeerSearchInteractor.swift
//  Prueba tecnica MO2O
//
//  Created by Wanaldino Antimonio on 21/10/2020.
//

import Foundation

class BeerSearchInteractor {
    let dataManager: BeerSearchDataManagerProtocol
    
    init(dataManager: BeerSearchDataManager) {
        self.dataManager = dataManager
    }
}

extension BeerSearchInteractor: BeerSearchInteractorProtocol {
    func getBeers(for food: String, completion: @escaping (Result<[Beer], Error>) -> Void) {
        let requestModel = BeerSearchRequestModel(page: 1, food: food)
        dataManager.retrieveBeers(with: requestModel, completion: completion)
    }
}
