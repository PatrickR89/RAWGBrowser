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
    var onboardingController: OnboardingController?

    init(_ navController: UINavigationController, _ service: APIService) {
        self.navController = navController
        self.service = service
    }

    func start() {
        let genreData = service.mockFetchGenres()
        onboardingController = OnboardingController()
        onboardingController?.populateData(genreData)
        guard let onboardingController else { return }
        let viewController = OnboardingViewController(controller: onboardingController)
        navController.setViewControllers([viewController], animated: true)
    }
}
