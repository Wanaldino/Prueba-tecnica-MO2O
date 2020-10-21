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
        return stackView
    }()
    
    let beerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 32),
            imageView.widthAnchor.constraint(equalToConstant: 32)
        ])
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Punk IPA 2007 - 2010"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let alcoholLabel: UILabel = {
        let label = UILabel()
        label.text = "Alcohol: 4.5%"
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
        DispatchQueue.global().async {
            guard let url = url, let imageData = try? Data(contentsOf: url), let image = UIImage(data: imageData) else { return }
            DispatchQueue.main.async { [weak self] in
                self?.beerImageView.image = image
            }
        }
    }
}
