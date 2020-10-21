//
//  BeerSearchViewController.swift
//  Prueba tecnica MO2O
//
//  Created by Wanaldino Antimonio on 21/10/2020.
//

import UIKit

class BeerSearchViewController: UITableViewController {
    let searchView: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Food"
        searchBar.heightAnchor.constraint(equalToConstant: 60).isActive = true
        searchBar.sizeToFit()
        searchBar.becomeFirstResponder()
        return searchBar
    }()
    
    override func loadView() {
        super.loadView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.register(BeerTableViewCell.self, forCellReuseIdentifier: "BeerTableViewCell")
        tableView.tableHeaderView = searchView
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "BeerTableViewCell", for: indexPath)
    }
}
