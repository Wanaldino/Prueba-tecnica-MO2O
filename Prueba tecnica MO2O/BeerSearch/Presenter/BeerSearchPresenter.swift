//
//  BeerSearchPresenter.swift
//  Prueba tecnica MO2O
//
//  Created by Wanaldino Antimonio on 21/10/2020.
//

import UIKit

class BeerSearchPresenter: NSObject {
    weak var view: BeerSearchViewProtocol?
    let interactor: BeerSearchInteractorProtocol
    
    var foodText = ""
    var beerModels = [BeerSearchCell]()
    
    init(interactor: BeerSearchInteractorProtocol) {
        self.interactor = interactor
    }
    
    func getBeers() {
        interactor.getBeers(for: foodText) { [weak self] (result) in
            switch result {
            case .success(let beers):
                self?.saveBeers(beers)
                self?.view?.refresh()
            case .failure(let error):
                break
            }
        }
    }
    
    func saveBeers(_ beers: [Beer]) {
        if self.beerModels.count == 0 && beers.count == 0 {
            beerModels.append(.title("No results"))
        } else {
            beerModels = beers.compactMap { (beer) -> BeerSearchCell? in
                let alcoholText = String(format: "Alcohol: %.2f%%", beer.alcoholByVolume)
                let model = BeerTableViewCellModel(
                    image: beer.image,
                    name: beer.name,
                    alcoholText: alcoholText
                )
                return .beer(model)
            }
        }
    }
}

extension BeerSearchPresenter: BeerSearchPresenterProtocol {
    var viewModel: BeerSearchViewModel {
        BeerSearchViewModel(
            title: "Beers",
            searchBarDelegate: self
        )
    }
    
    func viewDidLoad() {
        getBeers()
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        max(1, beerModels.count)
    }
    
    func modelForCell(at indexPath: IndexPath) -> BeerSearchCell {
        if beerModels.count == 0 {
            return .loading
        } else {
            return beerModels[indexPath.row]
        }
    }
}

extension BeerSearchPresenter: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.foodText = searchText
        self.beerModels.removeAll()
        self.view?.refresh()
        getBeers()
    }
}
