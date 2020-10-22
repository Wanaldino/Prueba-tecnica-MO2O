//
//  BeerSearchPresenterTest.swift
//  Prueba tecnica MO2OTests
//
//  Created by Wanaldino Antimonio on 22/10/2020.
//

import XCTest
@testable import Prueba_tecnica_MO2O

class BeerSearchPresenterTest: XCTestCase {
    let beers = [
        Beer(id: 0, name: "test beer", description: "description", image: nil, alcoholByVolume: 0, firstBrewed: nil, volume: Amount(value: 0, unit: ""))
    ]
    var presenter: BeerSearchPresenter!
    var interactor: BeerSearchInteractorMock!
    var coordinatorOutput: (Beer) -> Void = { beer in
        
    }
    
    override func setUp() {
        super.setUp()
        
        self.interactor = BeerSearchInteractorMock(beers: beers)
        self.presenter = BeerSearchPresenter(interactor: interactor, coordinatorOutput: coordinatorOutput)
    }
    
    func testBeerCell() {
        let mockCellModel = BeerTableViewCellModel(image: nil, name: "", description: "", alcoholText: "")
        let cellModel = presenter.modelForCell(at: IndexPath(row: 0, section: 0))
        XCTAssert(cellModel == .beer(mockCellModel))
    }
    
    func testLoadingCell() {
        interactor.beers = []
        let cellModel = presenter.modelForCell(at: IndexPath(row: 0, section: 0))
        XCTAssert(cellModel == .title(""))
    }
    
    func testNewFood() {
        XCTAssertFalse(interactor.didUpdateFood)
        presenter.searchBar(UISearchBar(), textDidChange: "")
        XCTAssertTrue(interactor.didUpdateFood)
    }
    
    func testViewDidLoad() {
        XCTAssertFalse(interactor.didRetrieveBeers)
        presenter.viewDidLoad()
        XCTAssertTrue(interactor.didRetrieveBeers)
    }
    
    func testScrollOnBottom() {
        XCTAssertFalse(interactor.didRetrieveBeers)
        presenter.didScrollToBottom()
        XCTAssertTrue(interactor.didRetrieveBeers)
    }
}
