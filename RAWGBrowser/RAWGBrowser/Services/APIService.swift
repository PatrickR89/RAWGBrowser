//
//  APIService.swift
//  RAWGBrowser
//
//  Created by Patrick on 06.03.2023..
//

import Foundation

class APIService {

    func mockFetchGenres() -> [GenreModel] {
        let path = Bundle.main.path(forResource: "mockGenres", ofType: "json")
        let pathURL = URL(filePath: path!)
        do {
            let data = try Data(contentsOf: pathURL)
            let genresResponse = try JSONDecoder().decode(GenreResponseModel.self, from: data)
            let genres = genresResponse.results
            return genres
        } catch {
            print(error)
        }

        return []
    }
}
