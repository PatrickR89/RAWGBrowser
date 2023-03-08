//
//  SettingsCell.swift
//  RAWGBrowser
//
//  Created by Patrick on 08.03.2023..
//

import UIKit

class SettingsCell: UITableViewCell {

    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.tintColor = ColorConstants.orangeAccent
        return imageView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Thonburi", size: 15)
        label.textColor = ColorConstants.textColor
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setContent(_ viewModel: SettingViewModel) {
        let image = UIImage(
            systemName: viewModel.imageName,
            withConfiguration: UIImage.SymbolConfiguration(
                font: UIFont.systemFont(ofSize: 20)
            ))
        iconImageView.image = image
        titleLabel.text = viewModel.title
    }

}

private extension SettingsCell {

    func setupUI() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        addIconImageViewSubview()
        addTitleLabelSubview()
    }

    func addIconImageViewSubview() {
        contentView.addSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            iconImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
        ])
    }
    func addTitleLabelSubview() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor)
        ])
    }
}
