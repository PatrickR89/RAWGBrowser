//
//  WaitingNotificationView.swift
//  RAWGBrowser
//
//  Created by Patrick on 07.03.2023..
//

import UIKit

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

    func setupUI() {
        layer.zPosition = CGFloat(Float.greatestFiniteMagnitude) - 5
        addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.color = .white
        spinner.startAnimating()

        NSLayoutConstraint.activate([
            spinner.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -20),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

//    func removeSelf() {
//        spinner.stopAnimating()
//        self.removeFromSuperview()
//    }
}
