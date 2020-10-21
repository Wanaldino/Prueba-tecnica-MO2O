//
//  BeerSearchDataManagerProtocol.swift
//  Prueba tecnica MO2O
//
//  Created by Wanaldino Antimonio on 21/10/2020.
//

import Foundation

protocol BeerSearchDataManagerProtocol {
    func retrieveBeers(with model: BeerSearchRequestModel,completion: @escaping (Result<[Beer], Error>) -> Void)
}
