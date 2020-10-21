//
//  ImageDownloader.swift
//  Prueba tecnica MO2O
//
//  Created by Wanaldino Antimonio on 21/10/2020.
//

import Foundation

class ImageDownloader {
    static let `default` = ImageDownloader()
    
    var downloadedImagesData = [String: Data]()
    
    func downloadImage(at url: URL, completion: @escaping (Data) -> Void) {
        if let imageData = downloadedImagesData[url.absoluteString] {
            return completion(imageData)
        }
        DispatchQueue.global().async { [weak self] in
            guard let imageData = try? Data(contentsOf: url) else { return }
            self?.downloadedImagesData[url.absoluteString] = imageData
            DispatchQueue.main.async {
                completion(imageData)
            }
        }
    }
}
