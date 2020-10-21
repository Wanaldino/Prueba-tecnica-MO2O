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
    let alcoholText: String
}

class BeerTableViewCell: UITableViewCell {
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            beerImageView,
            nameLabel,
            alcoholLabel
        ])
        stackView.spacing = 10
        return stackView
    }()
    
    let beerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 64),
            imageView.widthAnchor.constraint(equalToConstant: 64)
        ])
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let alcoholLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.italicSystemFont(ofSize: 16)
        return label
    }()
    
    override func layoutSublayers(of layer: CALayer) {
        if layer == beerImageView.layer {
            layer.cornerRadius = layer.bounds.height / 2
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.fill(with: mainStackView, edges: .init(top: 3, left: 3, bottom: 3, right: 3))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(with model: BeerTableViewCellModel) {
        self.nameLabel.text = model.name
        self.alcoholLabel.text = model.alcoholText
        addImage(of: model.image)
    }
    
    private func addImage(of url: URL?) {
        beerImageView.image = nil
        beerImageView.isHidden = true
        
        guard let url = url else { return }
        ImageDownloader.default.downloadImage(at: url) { [weak self] (data) in
            guard let image = UIImage(data: data) else { return }
            self?.beerImageView.image = image
            self?.beerImageView.isHidden = false
        }
    }
}
