//
//  BeerSearchPresenterProtocol.swift
//  Prueba tecnica MO2O
//
//  Created by Wanaldino Antimonio on 21/10/2020.
//

import Foundation

protocol BeerSearchPresenterProtocol {
    var viewModel: BeerSearchViewModel { get }
    func viewDidLoad()
    func numberOfRowsInSection(_ section: Int) -> Int
    func modelForCell(at indexPath: IndexPath) -> BeerSearchCell
    func didScrollToBottom()
}
