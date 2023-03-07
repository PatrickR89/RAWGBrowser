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
        self.backgroundImage = URL(string: model.background_image ?? "")
        self.description = model.description_raw ?? ""

        tableContent = [:]
        if let released = model.released {
            tableContent["Release date", default: []].append(released)
        }
        if let rating = model.rating {
            tableContent["Rating:", default: []].append("\(rating)")
        }
        if let esrbRating = model.esrb_rating?.name {
            tableContent["ESRB rating: ", default: []].append(esrbRating)
        }

        if !model.alternative_names.isEmpty {
            tableContent["Alternative names:"] = model.alternative_names
        }

        if !model.parent_platforms.isEmpty {
            tableContent["Platforms: "] = model.parent_platforms.map { $0.platform.name }
        }

        if !model.genres.isEmpty {
            tableContent["Genres: "] = model.genres.map { $0.name }
        }
    }
}
