//
//  APIConstants.swift
//  RAWGBrowser
//
//  Created by Patrick on 07.03.2023..
//

import Foundation

/// Struct containing URLs required for fetching data
struct APIConstants {
    static let apiKey = "key=34ae34ff3e634dd99c5cbb1cb2058c64"
    static let baseURL = "https://api.rawg.io/api/"
    static let genresURL = "genres?\(apiKey)&ordering=name&page_size=100"
}
