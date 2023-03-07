//
//  HeroImageView.swift
//  RAWGBrowser
//
//  Created by Patrick on 07.03.2023..
//

import UIKit
import SDWebImage

protocol HeroImageViewDelegate: AnyObject {
    func heroImageViewDidRequestInfo()
}

class HeroImageView: UIView {

    weak var delegate: HeroImageViewDelegate?

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
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        label.textColor = ColorConstants.orangeAccent
        label.layer.zPosition = 100
        return label
    }()

    let infoButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(systemName: "info.circle", withConfiguration: UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 30)))
        button.setImage(buttonImage, for: .normal)
        button.tintColor = ColorConstants.orangeAccent
        button.backgroundColor = ColorConstants.darkBackground.withAlphaComponent(0.8)
        button.layer.zPosition = 100
        button.layer.cornerRadius = 15
        button.frame.size = CGSize(width: 30, height: 30)
        return button
    }()

    func setupUI(in frame: CGRect, for imageUrl: URL?, with title: String) {
        addImageViewSubview(imageUrl)
        addShaderSubview(frame)
        addTitleLabelSubview(title)
        addInfoButtonSubview()
    }

    @objc private func didTapInfo() {
        delegate?.heroImageViewDidRequestInfo()
    }
}

private extension HeroImageView {
    func addImageViewSubview(_ imageUrl: URL?) {
        addSubview(imageView)
        if let url = imageUrl {
            imageView.sd_setImage(with: url)
        }
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    func addShaderSubview(_ frame: CGRect) {
        addSubview(shaderView)
        shaderView.translatesAutoresizingMaskIntoConstraints = false
        shaderView.frame = frame
        let gradient = CAGradientLayer()
        gradient.colors = [ColorConstants.darkBackground.withAlphaComponent(0).cgColor, ColorConstants.darkBackground.cgColor]
        gradient.frame = frame
        gradient.frame.size.height = frame.height * 0.5
        gradient.startPoint = .init(x: 0, y: 0.5)
        gradient.endPoint = .init(x: 0, y: 0.9)
        shaderView.layer.insertSublayer(gradient, at: 0)

        NSLayoutConstraint.activate([
            shaderView.topAnchor.constraint(equalTo: topAnchor),
            shaderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            shaderView.trailingAnchor.constraint(equalTo: trailingAnchor),
            shaderView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func addTitleLabelSubview(_ title: String) {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = title

        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    func addInfoButtonSubview() {
        addSubview(infoButton)
        infoButton.translatesAutoresizingMaskIntoConstraints = false

        infoButton.addTarget(self, action: #selector(didTapInfo), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            infoButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            infoButton.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -10)
        ])
    }
}
