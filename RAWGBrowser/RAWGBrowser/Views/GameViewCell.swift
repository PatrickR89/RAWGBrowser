//
//  GameViewCell.swift
//  RAWGBrowser
//
//  Created by Patrick on 07.03.2023..
//

import UIKit
import SDWebImage

/// `UITableViewCell` presenting each game forwarded by ``APIService``
class GameViewCell: UITableViewCell {

    var id = 0

    let nameLabel: UILabel = {
        let label = UILabel().createNameLabel()
        
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
        let label = UILabel().createRatingLabel()
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
        ratingLabel.text = "Rating: \(viewModel.rating)"

        if let url = viewModel.background_image {
            let transformer = SDImageResizingTransformer(size: CGSize(width: 300, height: 200), scaleMode: .aspectFill)
            posterImageView.sd_setImage(with: url, placeholderImage: nil, context: [.imageTransformer: transformer])
        }
    }

    /// Main method to setup UI
    func setupUI() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
        addPosterImageViewSubview()
        addNameLabelSubview()
        addImageShaderSubview()
        addRatingLabelSubview()
    }


}

private extension GameViewCell {
    /// Method to add ``posterImageView`` as subview and set declared constraints
    func addPosterImageViewSubview() {
        contentView.addSubview(posterImageView)
        posterImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            posterImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    /// Method to add ``nameLabel`` as subview and set declared constraints
    func addNameLabelSubview() {
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: -15),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            nameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])
    }

    /// Method to add ``ratingLabel`` as subview and set declared constraints
    func addRatingLabelSubview() {
        contentView.addSubview(ratingLabel)
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            ratingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            ratingLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }

    /// Method to add ``imageViewCover`` as subview and set declared constraints, which covers ``posterImageView``, adding defined shading
    func addImageShaderSubview() {
        contentView.addSubview(imageViewCover)
        imageViewCover.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageViewCover.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor),
            imageViewCover.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor),
            imageViewCover.topAnchor.constraint(equalTo: posterImageView.topAnchor),
            imageViewCover.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor)
        ])
        
        let gradient = CAGradientLayer()
        gradient.colors = [ColorConstants.lightBackground.withAlphaComponent(0).cgColor, ColorConstants.darkBackground.cgColor]
        gradient.frame.size.height = 100
        gradient.frame.size.width = UIScreen.main.bounds.width * 0.51
        gradient.startPoint = .init(x: 0.3, y: 0)
        gradient.endPoint = .init(x: 0.9, y: 0)
        imageViewCover.layer.insertSublayer(gradient, at: 0)
    }
}
