//
//  ImageDownloaderTest.swift
//  Prueba tecnica MO2OTests
//
//  Created by Wanaldino Antimonio on 22/10/2020.
//

import XCTest
@testable import Prueba_tecnica_MO2O

class ImageDownloaderTest: XCTestCase {
    let imageDownloader = ImageDownloader.default
    
    func testAlreadyDownloaded() {
        let data = Data()
        imageDownloader.downloadedImagesData["test"] = data
        imageDownloader.downloadImage(at: URL(string: "test")!) { (downloadedData) in
            XCTAssertTrue(downloadedData == data)
        }
    }
}
