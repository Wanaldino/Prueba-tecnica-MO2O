//
//  BeerSearchInteractorMock.swift
//  Prueba tecnica MO2OTests
//
//  Created by Wanaldino Antimonio on 22/10/2020.
//

@testable import Prueba_tecnica_MO2O

class BeerSearchInteractorMock: BeerSearchInteractorProtocol {
    var beers = [Beer]()
    var didUpdateFood = false
    var didRetrieveBeers = false
    
    init(beers: [Beer]) {
        self.beers = beers
    }
    
    func updateFood(_ food: String, completion: @escaping (Result<Void, Error>) -> Void) {
        didUpdateFood = true
    }
    
    func getBeers(completion: @escaping (Result<Void, Error>) -> Void) {
        didRetrieveBeers = true
    }
    
    func numberOfBeers() -> Int {
        beers.count
    }
    
    func getBeer(at index: Int) -> Beer {
        beers[index]
    }
}
