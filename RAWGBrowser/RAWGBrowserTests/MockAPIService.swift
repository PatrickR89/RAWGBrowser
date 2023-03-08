//
//  MockAPIService.swift
//  RAWGBrowserTests
//
//  Created by Patrick on 08.03.2023..
//

import UIKit

@testable import RAWGBrowser

class MockAPIService: APIService {
    override func fetchGamesForGenre(_ genreId: Int) {
        print("Genre original id: \(genreId)")
        let path = Bundle.main.path(forResource: "mockGenreList", ofType: "json")
        let pathURL = URL(filePath: path!)
        do {
            let data = try Data(contentsOf: pathURL)
            let genresResponse = try JSONDecoder().decode(GameListResponseModel.self, from: data)
            delegate?.service(didRecieveGameList: genresResponse)
        } catch {
            print(error)
        }
    }

    override func fetchGenres() {
        let path = Bundle.main.path(forResource: "mockGenres", ofType: "json")
        let pathURL = URL(filePath: path!)
        do {
            let data = try Data(contentsOf: pathURL)
            let genresResponse = try JSONDecoder().decode(GenreResponseModel.self, from: data)
            let genres = genresResponse.results
            delegate?.service(didRecieveGenres: genres)
        } catch {
            print(error)
        }
    }

    override func fetchGame(by id: Int) {
        print("Game original id: \(id)")
        let path = Bundle.main.path(forResource: "mockGame", ofType: "json")
        let pathURL = URL(filePath: path!)
        do {
            let data = try Data(contentsOf: pathURL)
            let game = try JSONDecoder().decode(GameModel.self, from: data)
            let gameViewModel = GameDetailViewModel(game)
            delegate?.service(didReciveGame: gameViewModel)

        } catch {
            print(error)
        }
    }

    override func fetchGamesNextPage(for pageString: String) {
        //
    }
}
