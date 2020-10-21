//
//  BeerSearchDataManager.swift
//  Prueba tecnica MO2O
//
//  Created by Wanaldino Antimonio on 21/10/2020.
//

import Foundation

class BeerSearchDataManager {
    let urlSession = URLSession(configuration: .default)
}

extension BeerSearchDataManager: BeerSearchDataManagerProtocol {
    func retrieveBeers(with model: BeerSearchRequestModel,completion: @escaping (Result<[Beer], Error>) -> Void) {
        guard var urlComponents = URLComponents(string: "https://api.punkapi.com/v2/beers") else { return }
        urlComponents.queryItems = [
            .init(name: "page", value: model.page.description),
            .init(name: "food", value: model.food?.replacingOccurrences(of: " ", with: "_"))
        ].filter({ !($0.value?.isEmpty ?? true) })
        
        guard let url = urlComponents.url else { return }
        let request = URLRequest(url: url)
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                } else if let data = data, let results = try? JSONDecoder().decode([Beer].self, from: data) {
                    completion(.success(results))
                } else {
                    completion(.failure(NSError()))
                }
            }
        }
        
        task.resume()
    }
}
