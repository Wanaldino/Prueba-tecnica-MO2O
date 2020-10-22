//
//  BeerDetailViewController.swift
//  Prueba tecnica MO2O
//
//  Created by Wanaldino Antimonio on 22/10/2020.
//

import UIKit

class BeerDetailViewController: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.fill(with: mainStackView, edges: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        return scrollView
    }()
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            beerImageView,
            descriptionLabel,
            firstBrewedLabel,
            volumeLabel,
            alcoholLabel,
            UIView()
        ])
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var beerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let firstBrewedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let volumeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let alcoholLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.italicSystemFont(ofSize: 16)
        return label
    }()
    
    let viewModel: BeerDetailViewModel

    init(viewModel: BeerDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        
        view.fill(with: scrollView)
        mainStackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -16).isActive = true
        beerImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.title
        beerImageView.image = viewModel.beerImage
        descriptionLabel.text = viewModel.description
        firstBrewedLabel.text = viewModel.firstBrewed
        volumeLabel.text = viewModel.volume
        alcoholLabel.text = viewModel.alcohol
    }
    
    func setUpObservers() {
        viewModel.beerImage?.addObserver(self, forKeyPath: "beerImage", options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        beerImageView.image = viewModel.beerImage
    }
}
