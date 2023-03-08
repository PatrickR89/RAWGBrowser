//
//  SceneDelegate.swift
//  RAWGBrowser
//
//  Created by Patrick on 06.03.2023..
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var mainCoordinator: MainCoordinator?


    func scene(
        _ scene: UIScene, willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions) {
            guard let windowScene: UIWindowScene = (scene as? UIWindowScene) else {return}

            let navigationController = NavigationController()
            navigationController.setBackGround()
            let databaseService = DatabaseService()
            mainCoordinator = MainCoordinator(navigationController, APIService(), databaseService)
            window = UIWindow(frame: windowScene.coordinateSpace.bounds)
            window?.windowScene = windowScene
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        }
}

