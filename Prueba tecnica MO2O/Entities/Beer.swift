//
//  BeerSearch.swift
//  Prueba tecnica MO2O
//
//  Created by Wanaldino Antimonio on 21/10/2020.
//

import Foundation

struct Beer: Codable {
    let id: Int
    let name: String
    let image: URL?
    let alcoholByVolume: Double
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        if let imageString = try? values.decode(String.self, forKey: .image) {
            image = URL(string: imageString)
        } else {
            image = nil
        }
        alcoholByVolume = try values.decode(Double.self, forKey: .alcoholByVolume)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image = "image_url"
        case alcoholByVolume = "abv"
    }
}
