//
//  HeroImageView.swift
//  RAWGBrowser
//
//  Created by Patrick on 07.03.2023..
//

import UIKit
import SDWebImage

class HeroImageView: UIView {

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.zPosition = 0
        return imageView
    }()

    let shaderView: UIView = {
        let view = UIView()
        view.layer.zPosition = 50
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        label.textColor = ColorConstants.orangeAccent
        label.layer.zPosition = 100
        return label
    }()

    func setupUI(in frame: CGRect, for imageUrl: URL?, with title: String) {
        addSubview(imageView)
        addSubview(shaderView)
        addSubview(titleLabel)

        if let url = imageUrl {
            imageView.sd_setImage(with: url)
        }

        imageView.translatesAutoresizingMaskIntoConstraints = false
        shaderView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.text = title
        shaderView.frame = frame

        let gradient = CAGradientLayer()
        gradient.colors = [ColorConstants.darkBackground.withAlphaComponent(0).cgColor, ColorConstants.darkBackground.cgColor]
        gradient.frame = frame
        gradient.frame.size.height = frame.height * 0.5
        gradient.startPoint = .init(x: 0, y: 0.5)
        gradient.endPoint = .init(x: 0, y: 0.9)
        shaderView.layer.insertSublayer(gradient, at: 0)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            shaderView.topAnchor.constraint(equalTo: topAnchor),
            shaderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            shaderView.trailingAnchor.constraint(equalTo: trailingAnchor),
            shaderView.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
