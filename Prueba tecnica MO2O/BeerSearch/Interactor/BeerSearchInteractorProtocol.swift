//
//  BeerSearchInteractorProtocol.swift
//  Prueba tecnica MO2O
//
//  Created by Wanaldino Antimonio on 21/10/2020.
//

import Foundation

protocol BeerSearchInteractorProtocol: class {
    func updateFood(_ food: String)
    func getBeers(completion: @escaping (Result<[Beer], Error>) -> Void)
}
