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
    let coordinatorOutput: (Beer) -> Void
    
    init(interactor: BeerSearchInteractorProtocol, coordinatorOutput: @escaping (Beer) -> Void) {
        self.interactor = interactor
        self.coordinatorOutput = coordinatorOutput
    }
    
    func getBeersCompletion(_ result: Result<Void, Error>) {
        switch result {
        case .success:
            view?.refresh()
        case .failure(let error):
            break
        }
    }
    
    func transform(beer: Beer) -> BeerSearchCell {
        let alcoholText = String(format: "Alcohol: %.2f%%", beer.alcoholByVolume)
        let model = BeerTableViewCellModel(
            image: beer.image,
            name: beer.name,
            description: beer.description,
            alcoholText: alcoholText
        )
        return .beer(model)
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
        interactor.getBeers(completion: getBeersCompletion)
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        max(1, interactor.numberOfBeers())
    }
    
    func modelForCell(at indexPath: IndexPath) -> BeerSearchCell {
        if interactor.numberOfBeers() == 0 {
            return .title("Loading...")
        } else {
            let beer = interactor.getBeer(at: indexPath.row)
            return transform(beer: beer)
        }
    }
    
    func didTapCell(at indexPath: IndexPath) {
        let beer = interactor.getBeer(at: indexPath.row)
        coordinatorOutput(beer)
    }
    
    func didScrollToBottom() {
        interactor.getBeers(completion: getBeersCompletion)
    }
}

extension BeerSearchPresenter: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        interactor.updateFood(searchText, completion: getBeersCompletion)
        view?.refresh()
    }
}
