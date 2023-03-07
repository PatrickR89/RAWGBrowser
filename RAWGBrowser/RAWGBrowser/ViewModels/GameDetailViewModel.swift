//
//  GameDetailViewModel.swift
//  RAWGBrowser
//
//  Created by Patrick on 07.03.2023..
//

import Foundation

struct GameDetailViewModel {
    let name: String
    let backgroundImage: URL?
    let description: String
    var tableContent: [String: [String]]

    init(_ model: GameModel) {
        self.name = model.name
        self.backgroundImage = URL(string: model.background_image)
        self.description = model.description_raw

        tableContent = [:]
        tableContent["Release date"] = [model.released]
        tableContent["Rating:"] = ["\(model.rating)"]
        tableContent["Alternative names:"] = model.alternative_names
        tableContent["Platforms: "] = model.parent_platforms.map { $0.platform.name }
        tableContent["Genres: "] = model.genres.map { $0.name }
        tableContent["ESRB rating: "] = [model.esrb_rating.name]
    }
}
