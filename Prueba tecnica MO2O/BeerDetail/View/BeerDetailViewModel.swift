//
//  BeerDetailViewModel.swift
//  Prueba tecnica MO2O
//
//  Created by Wanaldino Antimonio on 22/10/2020.
//

import UIKit
import Combine

class BeerDetailViewModel {
    private let beer: Beer
    @Published var beerImage: UIImage?
    
    init(beer: Beer) {
        self.beer = beer
        self.downloadImage()
    }
    
    var title: String {
        beer.name
    }
    
    var description: String {
        beer.description
    }
    
    var firstBrewed: String? {
        guard let date = beer.firstBrewed else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        let dateString = dateFormatter.string(from: date)
        return String(format: "First brewed at: %@", dateString)
    }
    
    var volume: String {
        String(format: "Volume: %.2f %@", beer.volume.value, beer.volume.unit)
    }
    
    var alcohol: String {
        String(format: "Alcohol: %.2f%%", beer.alcoholByVolume)
    }
    
    func downloadImage() {
        guard let url = beer.image else { return }
        ImageDownloader.default.downloadImage(at: url) { [weak self] (data) in
            self?.beerImage = UIImage(data: data)
        }
    }
}
