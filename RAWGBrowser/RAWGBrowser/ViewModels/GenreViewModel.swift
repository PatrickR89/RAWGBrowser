//
//  GenreViewModel.swift
//  RAWGBrowser
//
//  Created by Patrick on 06.03.2023..
//

import Foundation

struct GenreViewModel {
    let id: Int
    let name: String
    let games_count: Int
    let image_background : URL?
    let games: [GameExample]
}

struct GameExample {
    let id: Int
    let name: String
}
