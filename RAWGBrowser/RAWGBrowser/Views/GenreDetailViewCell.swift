//
//  GenreDetailViewCell.swift
//  RAWGBrowser
//
//  Created by Patrick on 06.03.2023..
//

import UIKit

class GenreDetailViewCell: UICollectionViewCell {

    let titleLabel: UILabel = {
        let label = UILabel()

        return label
    }()

    let gameCountLabel: UILabel = {
        let label = UILabel()

        return label
    }()

    func setCellData(_ viewModel: GenreViewModel) {
        titleLabel.text = viewModel.name
        gameCountLabel.text = "No. of games in genre: \(viewModel.games_count)"
        setupUI()
    }

    func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(gameCountLabel)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        gameCountLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.layer.cornerRadius = 25
        contentView.clipsToBounds = true

        contentView.backgroundColor = .gray

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            gameCountLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            gameCountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant:  -10),
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8),
            gameCountLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8)
        ])
    }

}
