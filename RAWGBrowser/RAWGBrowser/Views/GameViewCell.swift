//
//  GameViewCell.swift
//  RAWGBrowser
//
//  Created by Patrick on 07.03.2023..
//

import UIKit
import SDWebImage

class GameViewCell: UITableViewCell {

    var id = 0

    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorConstants.textColor
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 0
        label.layer.zPosition = 100
        return label
    }()

    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.zPosition = 0
        return imageView
    }()

    let imageViewCover: UIView = {
        let view = UIView()
        view.layer.zPosition = 10
        return view
    }()

    let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .gray
        label.frame.size.height = 10
        label.frame.size.width = 30
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupData(_ viewModel: GameListElementViewModel) {
        nameLabel.text = viewModel.name
        ratingLabel.text = "\(viewModel.rating)"
        if let url = viewModel.background_image {
            posterImageView.sd_setImage(with: url)
        }
    }

    func setupUI() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(nameLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(posterImageView)
        contentView.addSubview(imageViewCover)

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        imageViewCover.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            posterImageView.heightAnchor.constraint(equalToConstant: 100),
            nameLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: -15),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            nameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            ratingLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            imageViewCover.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor),
            imageViewCover.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor),
            imageViewCover.topAnchor.constraint(equalTo: posterImageView.topAnchor),
            imageViewCover.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor)
        ])

        coverImage()
    }

    func coverImage() {
        let gradient = CAGradientLayer()
        gradient.colors = [ColorConstants.lightBackground.withAlphaComponent(0).cgColor, ColorConstants.darkBackground.cgColor]
        gradient.frame.size.height = 100
        gradient.frame.size.width = UIScreen.main.bounds.width * 0.51
        gradient.startPoint = .init(x: 0.3, y: 0)
        gradient.endPoint = .init(x: 0.9, y: 0)
        imageViewCover.layer.insertSublayer(gradient, at: 0)
    }
}
