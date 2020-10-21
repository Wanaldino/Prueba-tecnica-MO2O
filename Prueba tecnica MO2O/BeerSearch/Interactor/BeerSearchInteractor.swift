//
//  BeerSearchInteractor.swift
//  Prueba tecnica MO2O
//
//  Created by Wanaldino Antimonio on 21/10/2020.
//

import Foundation

class BeerSearchInteractor {
    let dataManager: BeerSearchDataManagerProtocol
    
    var foodText = ""
    var page = 0
    var isPaging = false
    
    init(dataManager: BeerSearchDataManager) {
        self.dataManager = dataManager
    }
}

extension BeerSearchInteractor: BeerSearchInteractorProtocol {
    func updateFood(_ food: String) {
        foodText = food
        page = 0
    }
    
    func getBeers(completion: @escaping (Result<[Beer], Error>) -> Void) {
        if isPaging { return }
        isPaging.toggle()
        page += 1
        
        let requestModel = BeerSearchRequestModel(page: page, food: foodText)
        dataManager.retrieveBeers(with: requestModel, completion: { [weak self] result in
            completion(result)
            self?.isPaging.toggle()
        })
    }
}
