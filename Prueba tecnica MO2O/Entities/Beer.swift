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
    let description: String
    let image: URL?
    let alcoholByVolume: Double
    let firstBrewed: Date?
    let volume: Amount
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        description = try values.decode(String.self, forKey: .description)
        if let imageString = try? values.decode(String.self, forKey: .image) {
            image = URL(string: imageString)
        } else {
            image = nil
        }
        alcoholByVolume = try values.decode(Double.self, forKey: .alcoholByVolume)
        
        let firstBrewedDate = try values.decode(String.self, forKey: .firstBrewed)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/yyyy"
        firstBrewed = dateFormatter.date(from: firstBrewedDate)
        volume = try values.decode(Amount.self, forKey: .volume)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case image = "image_url"
        case alcoholByVolume = "abv"
        case firstBrewed = "first_brewed"
        case volume
    }
}

extension Beer {
    init(id: Int, name: String, description: String, image: URL?, alcoholByVolume: Double, firstBrewed: Date?, volume: Amount) {
        self.id = id
        self.name = name
        self.description = description
        self.image = image
        self.alcoholByVolume = alcoholByVolume
        self.firstBrewed = firstBrewed
        self.volume = volume
    }
}
