//
//  GenreViewModel.swift
//  RAWGBrowser
//
//  Created by Patrick on 06.03.2023..
//

import Foundation

/// `ViewModel` provided to ``OnboardingController`` as the blueprint for presented data in ``OnboardingViewController``
struct GenreViewModel {
    let id: Int
    let name: String
    let gamesCount: Int
    let backgroundImage : URL?

    init(_ model: GenreModel) {
        id = model.id
        name = model.name
        gamesCount = model.games_count
        backgroundImage = URL(string: model.image_background)
    }
}
