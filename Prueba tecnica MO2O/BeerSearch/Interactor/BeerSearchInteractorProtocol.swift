//
//  BeerSearchInteractorProtocol.swift
//  Prueba tecnica MO2O
//
//  Created by Wanaldino Antimonio on 21/10/2020.
//

import Foundation

protocol BeerSearchInteractorProtocol: class {
    func updateFood(_ food: String, completion: @escaping (Result<Void, Error>) -> Void)
    func getBeers(completion: @escaping (Result<Void, Error>) -> Void)
    func numberOfBeers() -> Int
    func getBeer(at index: Int) -> Beer
}
