//
//  UIButton+Extension.swift
//  RAWGBrowser
//
//  Created by Patrick on 07.03.2023..
//

import UIKit

extension UIButton {
    /// Method adds visual parameters to `UIButton` and returns styled button
    /// - Parameter imageSystemName: selected system image name (SFSymbol)
    /// - Returns: styled  `UIButton`
    func createCircularButton(_ imageSystemName: String) -> UIButton {
        let buttonImage = UIImage(
            systemName: imageSystemName,
            withConfiguration: UIImage.SymbolConfiguration(
                font: UIFont.systemFont(ofSize: 25)))

        backgroundColor = ColorConstants.darkBackground.withAlphaComponent(0.8)
        tintColor = ColorConstants.orangeAccent
        setImage(buttonImage, for: .normal)
        layer.cornerRadius = 15
        frame.size = CGSize(width: 30, height: 30)
        
        return self
    }

    /// Method creates styled `UIButton` for ``GenreDetailViewCell`` in ``OnboardingViewController``
    /// - Returns: styled `UIButton`
    func createExploreButton() -> UIButton {
        layer.cornerRadius = 20
        frame.size.height = 40
        backgroundColor = ColorConstants.greenAccent
        setTitleColor(ColorConstants.darkBackground, for: .normal)
        setTitle("Explore", for: .normal)
        titleLabel?.font = UIFont(name: "Thonburi", size: 20)

        return self
    }
}
