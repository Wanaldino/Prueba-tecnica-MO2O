//
//  BeerSearchInteractor.swift
//  Prueba tecnica MO2O
//
//  Created by Wanaldino Antimonio on 21/10/2020.
//

import Foundation

class BeerSearchInteractor {
    let dataManager: BeerSearchDataManagerProtocol
    
    var beers = [Beer]()
    var foodText = ""
    var page = 0
    var isPaging = false
    
    init(dataManager: BeerSearchDataManager) {
        self.dataManager = dataManager
    }
}

extension BeerSearchInteractor: BeerSearchInteractorProtocol {
    func updateFood(_ food: String, completion: @escaping (Result<Void, Error>) -> Void) {
        foodText = food
        page = 0
        beers.removeAll()
        getBeers(completion: completion)
    }
    
    func getBeers(completion: @escaping (Result<Void, Error>) -> Void) {
        if isPaging { return }
        isPaging.toggle()
        page += 1
        
        let requestModel = BeerSearchRequestModel(page: page, food: foodText)
        dataManager.retrieveBeers(with: requestModel, completion: { [weak self] result in
            self?.isPaging.toggle()
            switch result {
            case .success(let beers):
                self?.beers.append(contentsOf: beers)
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func getBeer(at index: Int) -> Beer {
        beers[index]
    }
    
    func numberOfBeers() -> Int {
        beers.count
    }
}
