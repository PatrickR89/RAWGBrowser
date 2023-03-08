//
//  GameDetailViewCell.swift
//  RAWGBrowser
//
//  Created by Patrick on 07.03.2023..
//

import UIKit

/// `UITableViewCell` which presents details from loaded game, using ``nameLabel`` top present keys/categories, and ``stackView`` to present values for each category
class GameDetailViewCell: UITableViewCell {

    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorConstants.greenAccent
        label.font = UIFont(name: "Thonburi", size: 15)
        return label
    }()

    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 3
        stack.alignment = .leading
        stack.distribution = .equalCentering
        stack.backgroundColor = .clear
        return stack
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Method to populate visual data in cell
    /// - Parameters:
    ///   - key: value provided to ``nameLabel``
    ///   - values: values for which new `UILabel`s are created and added to ``stackView`` as arranged subviews
    func populateData(key: String, values: [String]) {
        nameLabel.text = key

        values.forEach { value in
            let label = UILabel()
            label.textColor = ColorConstants.textColor
            label.text = value
            label.numberOfLines = 0
            label.font = UIFont(name: "Thonburi", size: 15)
            stackView.addArrangedSubview(label)
        }
    }

    /// Method to create UI with declared constraints,  disabling interaction for `UITableViewCell`
    func setupUI() {
        isUserInteractionEnabled = false
        backgroundColor = .clear
        contentView.layer.borderColor = ColorConstants.lightBackground.cgColor
        contentView.layer.borderWidth = 0.5
        contentView.backgroundColor = .clear
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(stackView)

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
            stackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5)
        ])
    }
}
