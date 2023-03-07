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
    var gameListController: GameListController?

    init(_ navController: UINavigationController, _ service: APIService) {
        self.navController = navController
        self.service = service
        self.service.delegate = self
    }

    func start() {
        presentOnboardingViewController(with: [])
//        service.fetchGenres()
        service.mockFetchGenres()
    }

    private func presentServiceNotification(_ message: String) {

        var yPosition = navController.view.frame.height / 2

        if let height = navController.viewControllers.last?.view.frame.height {
            yPosition -= height / 2
        }

        let frame = CGRect(
            x: 0,
            y: yPosition,
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height / 2)

        DispatchQueue.main.async {
            let serviceNotification = ServiceNotificationView(frame: frame, message: message)

            self.navController.viewControllers.last?.view.addSubview(serviceNotification)
        }
    }

    private func presentLoadingSpinner() {
        var yPosition = navController.view.frame.height / 2

        if let height = navController.viewControllers.last?.view.frame.height {
            yPosition -= height / 2
        }

        let frame = CGRect(
            x: 0,
            y: yPosition,
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height / 2)

        DispatchQueue.main.async {
            let serviceNotification = WaitingNotificationView(frame: frame)

            self.navController.view.addSubview(serviceNotification)
        }
    }

    private func removeSpinner() {
        DispatchQueue.main.async {
            if let spinner = self.navController.view.subviews.first(where: {$0 as? WaitingNotificationView != nil}) {
                spinner.removeFromSuperview()
            }
        }
    }

    func presentOnboardingViewController(with data: [GenreModel]) {
        onboardingController = OnboardingController(service)
        onboardingController?.populateData(data)
        guard let onboardingController else { return }
        DispatchQueue.main.async {
            let viewController = OnboardingViewController(controller: onboardingController)
            self.navController.setViewControllers([viewController], animated: true)
        }
    }

    func presentGameListViewController(with data: [GameListElementModel]) {
        gameListController = GameListController(data)
        guard let gameListController else { return }
        DispatchQueue.main.async {
            let viewController = GameListViewController(gameListController)
            viewController.delegate = self.service
            self.navController.setViewControllers([viewController], animated: true)
        }
    }

    func presentGameDetailsViewController(with data: GameDetailViewModel) {
        DispatchQueue.main.async {
            let viewController = GameDetailViewController(data)
            self.navController.pushViewController(viewController, animated: true)
        }
    }
}

extension MainCoordinator: APIServiceDelegate {
    func service(didReciveGame detail: GameDetailViewModel) {
        presentGameDetailsViewController(with: detail)
    }

    func service(didRecieveGameList list: [GameListElementModel]) {
        presentGameListViewController(with: list)
    }

    func service(didRecieveData data: [GenreModel]) {
        presentOnboardingViewController(with: data)
    }

    func service(didRecieveError error: String) {
        presentServiceNotification(error)
    }

    func service(isWaiting: Bool) {
        if isWaiting {
            presentLoadingSpinner()
        } else {
            removeSpinner()
        }
    }
}
