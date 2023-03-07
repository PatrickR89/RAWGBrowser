//
//  GenreModels.swift
//  RAWGBrowser
//
//  Created by Patrick on 06.03.2023..
//

import Foundation

struct GenreResponseModel: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [GenreModel]
}

struct GenreModel: Codable {
    let id: Int
    let name: String
    let slug: String
    let games_count: Int
    let image_background : String
}
