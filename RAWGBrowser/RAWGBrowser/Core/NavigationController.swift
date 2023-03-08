//
//  NavigationController.swift
//  RAWGBrowser
//
//  Created by Patrick on 08.03.2023..
//

import UIKit

/// Custom `UINavigationController` class, setting status bar to light content as the application is dark, and setting custom background
class NavigationController: UINavigationController {

    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackGround()
    }

    func setBackGround() {
        let gradient = CAGradientLayer()
        gradient.colors = [ColorConstants.darkBackground.cgColor,
                           ColorConstants.lightBackground.cgColor]
        gradient.frame = view.bounds
        gradient.startPoint = .init(x: 0.5, y: 0.5)
        gradient.endPoint = .init(x: 0, y: 1)
        view.layer.insertSublayer(gradient, at: 0)
    }
}
