//
//  WaitingNotificationView.swift
//  RAWGBrowser
//
//  Created by Patrick on 07.03.2023..
//

import UIKit

/// `UIView class` which presents `UIActivityIndicatorView` to notify user when application is waiting for `HTTPResponse` from `API`
class WaitingNotificationView: UIView {

    let spinner = UIActivityIndicatorView(style: .large)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        spinner.stopAnimating()
    }

    /// Method to setup UI
    func setupUI() {
        layer.zPosition = CGFloat(Float.greatestFiniteMagnitude) - 5
        addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.color = .white
        spinner.startAnimating()

        NSLayoutConstraint.activate([
            spinner.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
