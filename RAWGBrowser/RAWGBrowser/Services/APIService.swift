//
//  APIService.swift
//  RAWGBrowser
//
//  Created by Patrick on 06.03.2023..
//

import Foundation

protocol APIServiceDelegate: AnyObject {
    func service(didReciveGame data: GameDetailViewModel)
    func service(didRecieveGenres data: [GenreModel])
    func service(didRecieveError error: String)
    func service(isWaiting: Bool)
    func service(didRecieveGameList data: GameListResponseModel)
    func service(didUpdateGamesList data: GameListResponseModel)
    func service(didRecieveId id: Int)
}

class APIService {

    weak var delegate: APIServiceDelegate?

    func mockFetchGenres() {
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

    func mockFetchGamesForGenre(_ genreId: Int) {
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

    func mockFetchGame(_ gameId: Int) {
        print("Game original id: \(gameId)")
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

    /// Method to fetch all available genres from `RAWG API`, using `HTTPRequest`
    func fetchGenres() {
        let url = URL(string: "\(APIConstants.baseURL)\(APIConstants.genresURL)")!

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        request.timeoutInterval = 5

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in

            if let error = error {
                DispatchQueue.main.async { [weak self] in
                    self?.delegate?.service(isWaiting: false)
                    self?.delegate?.service(didRecieveError: error.localizedDescription)
                }

                return
            }

            guard let response = response as? HTTPURLResponse else { return }
            guard response.statusCode == 200 else {
                if response.statusCode == 403 || response.statusCode == 401 {
                    self?.delegate?.service(didRecieveError: "Error occured while authenticating")
                } else if response.statusCode >= 400 && response.statusCode < 500 {
                    self?.delegate?.service(didRecieveError: "Error occured in request")
                } else if response.statusCode >= 500 {
                    self?.delegate?.service(didRecieveError: "Error occured in response")
                }
                self?.delegate?.service(isWaiting: false)
                return
            }

            guard let data = data else {
                self?.delegate?.service(didRecieveError: "Error occured while retrieving data")
                self?.delegate?.service(isWaiting: false)
                return
            }
            guard let respData = try? JSONDecoder().decode(GenreResponseModel.self, from: data) else {
                self?.delegate?.service(didRecieveError: "Error occured while retrieving data")
                self?.delegate?.service(isWaiting: false)
                return
            }

            let genres = respData.results
            self?.delegate?.service(didRecieveGenres: genres)
            self?.delegate?.service(isWaiting: false)
        }

        delegate?.service(isWaiting: true)
        task.resume()
    }

    /// Method to fetch games for given genre  from `RAWG API`, using `HTTPRequest`
    /// - Parameter genreId: id for genre
    func fetchGamesForGenre(_ genreId: Int) {
        delegate?.service(didRecieveId: genreId)
        let url = URL(string: "\(APIConstants.baseURL)games?\(APIConstants.apiKey)&genres=\(genreId)")!

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        request.timeoutInterval = 5

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in

            if let error = error {
                DispatchQueue.main.async { [weak self] in
                    self?.delegate?.service(isWaiting: false)
                    self?.delegate?.service(didRecieveError: error.localizedDescription)
                }

                return
            }

            guard let response = response as? HTTPURLResponse else { return }
            guard response.statusCode == 200 else {
                if response.statusCode >= 400 && response.statusCode < 500 {
                    self?.delegate?.service(didRecieveError: "Error occured in request")
                } else if response.statusCode >= 500 {
                    self?.delegate?.service(didRecieveError: "Error occured in response")
                }
                self?.delegate?.service(isWaiting: false)
                return
            }

            guard let data = data else {
                self?.delegate?.service(didRecieveError: "Error occured while retrieving data")
                self?.delegate?.service(isWaiting: false)
                return
            }
            guard let respData = try? JSONDecoder().decode(GameListResponseModel.self, from: data) else {
                self?.delegate?.service(didRecieveError: "Error occured while retrieving data")
                self?.delegate?.service(isWaiting: false)
                return
            }

            DispatchQueue.main.async {
                self?.delegate?.service(didRecieveGameList: respData)
            }

            self?.delegate?.service(isWaiting: false)
        }

        delegate?.service(isWaiting: true)
        task.resume()
    }

    /// Method to fetch next page of games for given genre from `RAWG API`, using `HTTPRequest`
    /// - Parameter pageString: `String` containing required path for `URLRequest`
    func fetchGamesNextPage(for pageString: String) {
        guard let url = URL(string: pageString) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        request.timeoutInterval = 5

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in

            if let error = error {
                DispatchQueue.main.async { [weak self] in
                    self?.delegate?.service(isWaiting: false)
                    self?.delegate?.service(didRecieveError: error.localizedDescription)
                }

                return
            }

            guard let response = response as? HTTPURLResponse else { return }
            guard response.statusCode == 200 else {
                if response.statusCode >= 400 && response.statusCode < 500 {
                    self?.delegate?.service(didRecieveError: "Error occured in request")
                } else if response.statusCode >= 500 {
                    self?.delegate?.service(didRecieveError: "Error occured in response")
                }
                self?.delegate?.service(isWaiting: false)
                return
            }

            guard let data = data else {
                self?.delegate?.service(didRecieveError: "Error occured while retrieving data")
                self?.delegate?.service(isWaiting: false)
                return
            }
            guard let respData = try? JSONDecoder().decode(GameListResponseModel.self, from: data) else {
                self?.delegate?.service(didRecieveError: "Error occured while retrieving data")
                self?.delegate?.service(isWaiting: false)
                return
            }

            DispatchQueue.main.async {
                self?.delegate?.service(didUpdateGamesList: respData)
            }

            self?.delegate?.service(isWaiting: false)
        }

        delegate?.service(isWaiting: true)
        task.resume()
    }

    /// Method to fetch selected game from `RAWG API`, using `HTTPRequest`
    /// - Parameter id: game id, as the search query param
    func fetchGame(by id: Int) {
        let url = URL(string: "\(APIConstants.baseURL)games/\(id)?\(APIConstants.apiKey)")!

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        request.timeoutInterval = 5

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in

            if let error = error {
                DispatchQueue.main.async { [weak self] in
                    self?.delegate?.service(isWaiting: false)
                    self?.delegate?.service(didRecieveError: error.localizedDescription)
                }

                return
            }

            guard let response = response as? HTTPURLResponse else { return }
            guard response.statusCode == 200 else {
                 if response.statusCode >= 400 && response.statusCode < 500 {
                    self?.delegate?.service(didRecieveError: "Error occured in request")
                } else if response.statusCode >= 500 {
                    self?.delegate?.service(didRecieveError: "Error occured in response")
                }
                self?.delegate?.service(isWaiting: false)
                return
            }

            guard let data = data else {
                self?.delegate?.service(didRecieveError: "Error occured while retrieving data")
                self?.delegate?.service(isWaiting: false)
                return
            }
            guard let respData = try? JSONDecoder().decode(GameModel.self, from: data) else {
                self?.delegate?.service(didRecieveError: "Error occured while retrieving data")
                self?.delegate?.service(isWaiting: false)
                return
            }

            let gameViewModel = GameDetailViewModel(respData)

            self?.delegate?.service(didReciveGame: gameViewModel)
            self?.delegate?.service(isWaiting: false)
        }

        delegate?.service(isWaiting: true)
        task.resume()
    }
}

extension APIService: GameListViewControllerDelegate {
    func viewController(didRequestNextPage pageUrl: String) {
        fetchGamesNextPage(for: pageUrl)
    }

    func viewController(didTapCellWith id: Int) {
        fetchGame(by: id)
    }
}
