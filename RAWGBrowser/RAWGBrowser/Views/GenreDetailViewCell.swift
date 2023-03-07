//
//  GenreDetailViewCell.swift
//  RAWGBrowser
//
//  Created by Patrick on 06.03.2023..
//

import UIKit
import SDWebImage

protocol GenreDetailViewCellAction: AnyObject {
    func cellDidRecieveTap(for genreId: Int)
}

class GenreDetailViewCell: UICollectionViewCell {

    weak var action: GenreDetailViewCellAction?

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
        let button = UIButton().createExploreButton()
        return button
    }()

    var id = 0

    func setCellData(_ viewModel: GenreViewModel) {
        titleLabel.text = viewModel.name
        gameCountLabel.text = "No. of games in genre: \(viewModel.gamesCount)"
        self.id = viewModel.id
        if let url = viewModel.backgroundImage {
            imageView.sd_setImage(with: url)
        }
        setupUI()
    }
}

private extension GenreDetailViewCell {

    func setupUI() {
        addImageViewSubview()
        addTitleLabelSubview()
        addExploreButtonSubview()
        addGameCountLabelSubview()

        contentView.layer.cornerRadius = 25
        contentView.clipsToBounds = true
        contentView.backgroundColor = ColorConstants.lightBackground.withAlphaComponent(0.2)
    }

    func addImageViewSubview() {
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6)
        ])
    }

    func addTitleLabelSubview() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10)
        ])
    }

    func addExploreButtonSubview() {
        contentView.addSubview(exploreButton)
        exploreButton.translatesAutoresizingMaskIntoConstraints = false
        exploreButton.addTarget(self, action: #selector(didTapExplore), for: .touchUpInside)

        NSLayoutConstraint.activate([
            exploreButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            exploreButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            exploreButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8)
        ])
    }

    func addGameCountLabelSubview() {
        contentView.addSubview(gameCountLabel)
        gameCountLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            gameCountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant:  -10),
            gameCountLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8),
            gameCountLabel.bottomAnchor.constraint(equalTo: exploreButton.topAnchor, constant: -10)
        ])
    }

    @objc func didTapExplore() {
        action?.cellDidRecieveTap(for: id)
    }
}
