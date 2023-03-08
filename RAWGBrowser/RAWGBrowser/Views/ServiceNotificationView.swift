//
//  ServiceNotificationView.swift
//  RAWGBrowser
//
//  Created by Patrick on 07.03.2023..
//

import UIKit

protocol ServiceNotificationViewDelegate: AnyObject {
    func viewDidRemoveSelf()
}

/// `UIView class` which is presented in case of errors, in order to provide user with error information
class ServiceNotificationView: UIView {

    weak var delegate: ServiceNotificationViewDelegate?

    let notificationLabel: UILabel = {
        let label = UILabel().createNotificationLabel()
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

    /// Main method to setup visuals and declared constraints
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

    /// Method to remove class from superview after defined time
    func removeSelf() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.removeFromSuperview()
            self.delegate?.viewDidRemoveSelf()
        }
    }
}
