//
//  UILabel+Extension.swift
//  RAWGBrowser
//
//  Created by Patrick on 07.03.2023..
//

import UIKit

extension UILabel {
    /// Method creates styled `UILabel` which is used for error messages provided to the user
    /// - Returns: styled `UILabel`
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

    /// Method creates styled `UILabel` which presents Game name  for ``GameViewCell``
    /// - Returns: styled `UILabel`
    func createNameLabel() -> UILabel {
        textColor = ColorConstants.orangeAccent
        font = UIFont(name: "Thonburi-Bold", size: 15)
        numberOfLines = 0
        layer.zPosition = 100

        return self
    }

    /// Method creates styled `UILabel` presents Game rating for ``GameViewCell``
    /// - Returns: styled `UILabel`
    func createRatingLabel() -> UILabel {
        font = UIFont(name: "Thonburi", size: 10)
        textColor = ColorConstants.textColor
        frame.size = CGSize(width: 30, height: 10)

        return self
    }
}
