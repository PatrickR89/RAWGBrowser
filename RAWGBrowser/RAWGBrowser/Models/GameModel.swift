//
//  GameModel.swift
//  RAWGBrowser
//
//  Created by Patrick on 07.03.2023..
//

import Foundation

struct GameModel: Codable {
    let name: String
    let released: String?
    let rating: Double?
    let background_image: String?
    let alternative_names: [String]
    let parent_platforms: [ParentPlatform]
    let genres: [NameProperty]
    let esrb_rating: NameProperty?
    let description_raw: String?
}

struct NameProperty: Codable {
    let name: String
}

struct ParentPlatform: Codable {
    let platform: NameProperty
}

