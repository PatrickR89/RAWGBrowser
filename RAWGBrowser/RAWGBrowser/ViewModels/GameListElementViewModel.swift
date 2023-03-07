//
//  GameListElementViewModel.swift
//  RAWGBrowser
//
//  Created by Patrick on 07.03.2023..
//

import Foundation

struct GameListElementViewModel {
    let id: Int
    let name: String
    let background_image: URL?
    let rating: Double

    init(_ model: GameListElementModel) {
        self.id = model.id
        self.name = model.name
        self.background_image = URL(string: model.background_image)
        self.rating = model.rating
    }
}
