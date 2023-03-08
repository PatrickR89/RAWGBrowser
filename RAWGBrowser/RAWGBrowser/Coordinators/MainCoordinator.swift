//
//  MainCoordinator.swift
//  RAWGBrowser
//
//  Created by Patrick on 06.03.2023..
//

import UIKit

/// `Coordinator class` contains all ViewControllers, and is responsible for all screen changes, as also for communication between all separate classes
class MainCoordinator {

    let navController: UINavigationController
    let networkService: APIService
    let databaseService: DatabaseService
    var onboardingController: OnboardingController?
    var gameListController: GameListController?
    var gameDetailsController: GameDetailsController?

    init(_ navController: UINavigationController, _ networkService: APIService, _ databaseService: DatabaseService) {
        self.navController = navController
        self.networkService = networkService
        self.databaseService = databaseService
        self.networkService.delegate = self
        self.databaseService.delegate = self
    }

    /// Main method to start application
    /// - Parameter id: genre id as optional `Int`, in case of nil ``APIService`` sends request to `RAWG API` to fetch genres, else request to fetch games for selected genre
    func start(_ id: Int?) {

        guard let id else {
            networkService.fetchGenres()
            return
        }

        networkService.fetchGamesForGenre(id)
    }

    /// Method to present error as modal view
    /// - Parameter message: error message
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
            self.navController.view.addSubview(serviceNotification)
        }
    }

    /// Method to present loading spinner while waiting for response
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

    /// Method to remove loading spinner on recieved response or error
    private func removeSpinner() {
        DispatchQueue.main.async {
            if let spinner = self.navController.view.subviews.first(where: {$0 as? WaitingNotificationView != nil}) {
                spinner.removeFromSuperview()
            }
        }
    }

    /// Method to present main screen where user selects genre
    /// - Parameter data: recieved list of available genres from `RAWG API`
    func presentOnboardingViewController(with data: [GenreModel]) {
        onboardingController = OnboardingController(self)
        onboardingController?.populateData(data)
        guard let onboardingController else { return }
        DispatchQueue.main.async {
            let viewController = OnboardingViewController(controller: onboardingController)
            self.navController.setViewControllers([viewController], animated: true)
        }
    }

    /// Method to present list of games for selected genre
    /// - Parameter data: response from `RAWG API` containing results and next page URL
    func presentGameListViewController(with data: GameListResponseModel) {
        gameListController = GameListController(data)
        guard let gameListController else { return }
        DispatchQueue.main.async {
            let viewController = GameListViewController(gameListController)
            viewController.delegate = self.networkService
            viewController.actions = self
            self.navController.setViewControllers([viewController], animated: true)
        }
    }

    /// Method to present screen with detailed information about selected game
    /// - Parameter data: view model converted from `HTTPResponse`
    func presentGameDetailsViewController(with data: GameDetailViewModel) {
        gameDetailsController = GameDetailsController()
        gameDetailsController?.populateData(data.tableContent)
        guard let gameDetailsController else {return}
        DispatchQueue.main.async {
            let viewController = GameDetailViewController(data, gameDetailsController)
            self.navController.pushViewController(viewController, animated: true)
        }
    }
}

extension MainCoordinator: GenreDetailViewCellAction {
    func cellDidRecieveTap(for genreId: Int) {
        databaseService.saveGenreId(genreId)
    }
}

extension MainCoordinator: GameListViewControllerActions {
    func viewControllerDidRequestClose() {
        databaseService.removeId()
    }
}

extension MainCoordinator: APIServiceDelegate {
    /// Delegate method wich notifies of recieved genre id, forwarded to ``DatabaseService`` in order to be saved
    /// - Parameter id: genre id
    func service(didRecieveId id: Int) {
        databaseService.saveGenreId(id)
    }

    /// Delegate method notifying of recieved data for single game, forwarding it to ``presentGameDetailsViewController(with:)``
    /// - Parameter data: data about the game
    func service(didReciveGame data: GameDetailViewModel) {
        presentGameDetailsViewController(with: data)
    }

    /// Delegate method notifying about recieved list of games for selected genre
    /// - Parameter data: `HTTPResponse` decoded, containing list of games and next page URL
    func service(didRecieveGameList data: GameListResponseModel) {
        presentGameListViewController(with: data)
    }

    /// Delegate method notifying about updated list of games
    /// - Parameter data: list of games
    func service(didUpdateGamesList data: GameListResponseModel) {
        gameListController?.populateData(data)
    }

    /// Delegate method notifying about recieved list of genres, in order to present ``OnboardingViewController``
    /// - Parameter data: list of genres
    func service(didRecieveGenres data: [GenreModel]) {
        self.presentOnboardingViewController(with: data)
    }

    /// Delegate method notifying about error from ``APIService``, forwarding error message to `presentServiceNotification`
    /// - Parameter error: error message
    func service(didRecieveError error: String) {
        DispatchQueue.main.async {
            self.presentServiceNotification(error)
        }

    }

    /// Delegate method notifying about waiting for response from `RAWG API`
    /// - Parameter isWaiting: `Bool` - waiting state
    func service(isWaiting: Bool) {
        DispatchQueue.main.async {
            if isWaiting {
                self.presentLoadingSpinner()
            } else {
                self.removeSpinner()
            }
        }
    }
}

extension MainCoordinator: DatabaseServiceDelegate {
    /// Delegate method notifying about error from ``DatabaseService``, forwarding error message to `presentServiceNotification`
    /// - Parameter error: error message
    func databaseService(didRecieveError error: String) {
        DispatchQueue.main.async {
            self.presentServiceNotification(error)
        }
    }

    /// Delegate method notifying about change in stored genreId
    /// - Parameter id: genreId, optional in case of removed value
    func databaseService(didRecieveId id: Int?) {
        start(id)
    }
}
