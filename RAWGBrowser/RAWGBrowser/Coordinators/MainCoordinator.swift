//
//  MainCoordinator.swift
//  RAWGBrowser
//
//  Created by Patrick on 06.03.2023..
//

import UIKit

class MainCoordinator {

    let navController: UINavigationController
    let service: APIService

    init(_ navController: UINavigationController, _ service: APIService) {
        self.navController = navController
        self.service = service
    }

    func start() {
        let viewController = ViewController()
        navController.setViewControllers([viewController], animated: true)
    }
}
