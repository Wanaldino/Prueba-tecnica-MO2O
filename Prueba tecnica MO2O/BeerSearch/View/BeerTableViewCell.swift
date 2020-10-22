//
//  BeerTableViewCell.swift
//  Prueba tecnica MO2O
//
//  Created by Wanaldino Antimonio on 21/10/2020.
//

import UIKit

struct BeerTableViewCellModel {
    let image: URL?
    let name: String
    let description: String
    let alcoholText: String
}

class BeerTableViewCell: UITableViewCell {
    lazy var mainStackView: UIStackView = {
        let infoStackView = UIStackView(arrangedSubviews: [
            nameLabel,
            descriptionLabel,
            alcoholLabel
        ])
        infoStackView.axis = .vertical
        infoStackView.spacing = 4
        
        
        let stackView = UIStackView(arrangedSubviews: [
            beerImageContainer,
            infoStackView
        ])
        stackView.spacing = 10
        return stackView
    }()
    
    lazy var beerImageContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(beerImageView)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(lessThanOrEqualTo: beerImageView.topAnchor, constant: 0),
            view.bottomAnchor.constraint(greaterThanOrEqualTo: beerImageView.bottomAnchor, constant: 0),
            view.leadingAnchor.constraint(equalTo: beerImageView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: beerImageView.trailingAnchor),
            view.centerYAnchor.constraint(equalTo: beerImageView.centerYAnchor)
        ])
        return view
    }()
    let beerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 4
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 64),
            imageView.widthAnchor.constraint(equalToConstant: 64)
        ])
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 5
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let alcoholLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.italicSystemFont(ofSize: 16)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.fill(with: mainStackView, edges: .init(top: 3, left: 3, bottom: 3, right: 3))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(with model: BeerTableViewCellModel) {
        self.nameLabel.text = model.name
        self.descriptionLabel.text = model.description
        self.alcoholLabel.text = model.alcoholText
        addImage(of: model.image)
    }
    
    private func addImage(of url: URL?) {
        beerImageView.image = nil
        beerImageContainer.isHidden = true
        
        guard let url = url else { return }
        ImageDownloader.default.downloadImage(at: url) { [weak self] (data) in
            guard let image = UIImage(data: data) else { return }
            self?.beerImageView.image = image
            self?.beerImageContainer.isHidden = false
        }
    }
}
