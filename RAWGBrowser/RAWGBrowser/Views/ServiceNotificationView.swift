//
//  ServiceNotificationView.swift
//  RAWGBrowser
//
//  Created by Patrick on 07.03.2023..
//

import UIKit

class ServiceNotificationView: UIView {

    let notificationLabel: UILabel = {
        let label = UILabel()

        label.backgroundColor = ColorConstants.darkBackground
        label.layer.cornerRadius = 10
        label.layer.borderColor = ColorConstants.orangeAccent.withAlphaComponent(0.7).cgColor
        label.layer.borderWidth = 2
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.clipsToBounds = true
        label.textAlignment = .center
        label.textColor = ColorConstants.orangeAccent
        label.numberOfLines = 0

        return label
    }()

    init(frame: CGRect, message: String) {
        super.init(frame: frame)

        notificationLabel.text = message
        setupUI()
        removeSelf()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
        addSubview(notificationLabel)
        notificationLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            notificationLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            notificationLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            notificationLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            notificationLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30)
        ])
    }

    func removeSelf() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.removeFromSuperview()
        }
    }
}
