//
//  GenreDetailViewCell.swift
//  RAWGBrowser
//
//  Created by Patrick on 06.03.2023..
//

import UIKit
import SDWebImage

class GenreDetailViewCell: UICollectionViewCell {

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorConstants.textColor
        label.font = UIFont.systemFont(ofSize: 40)
        label.numberOfLines = 0
        return label
    }()

    let gameCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorConstants.textColor
        return label
    }()

    let exploreButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.frame.size.height = 40
        button.backgroundColor = ColorConstants.greenAccent
        button.setTitleColor(ColorConstants.darkBackground, for: .normal)
        button.setTitle("Explore", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return button
    }()

    func setCellData(_ viewModel: GenreViewModel) {
        titleLabel.text = viewModel.name
        gameCountLabel.text = "No. of games in genre: \(viewModel.games_count)"
        if let url = viewModel.image_background {
            imageView.sd_setImage(with: url)
        }
        setupUI()
    }

    func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(gameCountLabel)
        contentView.addSubview(imageView)
        contentView.addSubview(exploreButton)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        gameCountLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        exploreButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.layer.cornerRadius = 25
        contentView.clipsToBounds = true

        contentView.backgroundColor = ColorConstants.lightBackground.withAlphaComponent(0.2)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            gameCountLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            gameCountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant:  -10),
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8),
            gameCountLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            exploreButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            exploreButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            exploreButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8)
        ])

        addGradient()
    }

    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ColorConstants.lightBackground.withAlphaComponent(0).cgColor, ColorConstants.darkBackground.withAlphaComponent(0.8).cgColor]
        gradientLayer.frame = bounds
        gradientLayer.frame.size.height = bounds.size.height * 0.6
        imageView.layer.addSublayer(gradientLayer)
        imageView.layer.superlayer?.addSublayer(gradientLayer)
    }
}
