//
//  GameListModels.swift
//  RAWGBrowser
//
//  Created by Patrick on 07.03.2023..
//

import Foundation

/// Response `Model` for fetching and decoding List of games for given Genre
struct GameListResponseModel: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [GameListElementModel]
}

/// `Model` contained as result array in ``GameListResponseModel``
struct GameListElementModel: Codable {
    let id: Int
    let name: String
    let tba: Bool
    let background_image: String
    let rating: Double
}
