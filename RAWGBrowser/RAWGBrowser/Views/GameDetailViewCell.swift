//
//  GameDetailViewCell.swift
//  RAWGBrowser
//
//  Created by Patrick on 07.03.2023..
//

import UIKit

class GameDetailViewCell: UITableViewCell {

    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorConstants.greenAccent
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

    func populateData(key: String, values: [String]) {
        nameLabel.text = key

        values.forEach { value in
            let label = UILabel()
            label.textColor = ColorConstants.textColor
            label.text = value
            label.numberOfLines = 0
            label.font = UIFont.systemFont(ofSize: 15)
            stackView.addArrangedSubview(label)
        }
    }

    func setupUI() {
        isUserInteractionEnabled = false
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(nameLabel)
        contentView.addSubview(stackView)
        contentView.layer.borderColor = ColorConstants.lightBackground.cgColor
        contentView.layer.borderWidth = 0.5

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