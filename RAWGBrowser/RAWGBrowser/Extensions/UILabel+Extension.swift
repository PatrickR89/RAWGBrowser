//
//  UILabel+Extension.swift
//  RAWGBrowser
//
//  Created by Patrick on 07.03.2023..
//

import UIKit

extension UILabel {
    func createNotificationLabel() -> UILabel {
        backgroundColor = ColorConstants.darkBackground
        layer.cornerRadius = 10
        layer.borderColor = ColorConstants.orangeAccent.withAlphaComponent(0.7).cgColor
        layer.borderWidth = 2
        font = UIFont.systemFont(ofSize: 15, weight: .bold)
        clipsToBounds = true
        textAlignment = .center
        textColor = ColorConstants.orangeAccent
        numberOfLines = 0

        return self
    }

    func createNameLabel() -> UILabel {
        textColor = ColorConstants.orangeAccent
        font = UIFont.systemFont(ofSize: 15, weight: .bold)
        numberOfLines = 0
        layer.zPosition = 100

        return self
    }

    func createRatingLabel() -> UILabel {
        font = UIFont.systemFont(ofSize: 10)
        textColor = ColorConstants.textColor
        frame.size = CGSize(width: 30, height: 10)

        return self
    }
}
