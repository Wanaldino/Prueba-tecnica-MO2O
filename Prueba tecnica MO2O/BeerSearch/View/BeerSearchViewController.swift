//
//  BeerSearchViewController.swift
//  Prueba tecnica MO2O
//
//  Created by Wanaldino Antimonio on 21/10/2020.
//

import UIKit

class BeerSearchViewController: UITableViewController {
    lazy var searchView: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Food"
        searchBar.heightAnchor.constraint(equalToConstant: 60).isActive = true
        searchBar.sizeToFit()
        searchBar.becomeFirstResponder()
        searchBar.delegate = viewModel.searchBarDelegate
        return searchBar
    }()
    
    let presenter: BeerSearchPresenterProtocol
    var viewModel: BeerSearchViewModel
    
    init(presenter: BeerSearchPresenterProtocol) {
        self.presenter = presenter
        self.viewModel = presenter.viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.register(BeerTableViewCell.self, forCellReuseIdentifier: "BeerTableViewCell")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setUpNavigation()
    }
    
    func setUpNavigation() {
        title = viewModel.title
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        searchView
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = presenter.modelForCell(at: indexPath)
        switch model {
        case .beer(let model):
            let cell = tableView.dequeueReusableCell(withIdentifier: "BeerTableViewCell", for: indexPath) as! BeerTableViewCell
            cell.config(with: model)
            return cell
        case .title(let title):
            let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
            cell.textLabel?.text = title
            return cell
        case .loading:
            let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
            cell.textLabel?.text = "Loading..."
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didTapCell(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentSize.height - scrollView.frame.height - scrollView.contentOffset.y < 100 {
            presenter.didScrollToBottom()
        }
    }
}

extension BeerSearchViewController: BeerSearchViewProtocol {
    func refresh() {
        self.viewModel = presenter.viewModel
        self.tableView.reloadData()
    }
}
