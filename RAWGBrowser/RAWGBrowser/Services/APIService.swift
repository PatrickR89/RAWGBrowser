//
//  APIService.swift
//  RAWGBrowser
//
//  Created by Patrick on 06.03.2023..
//

import Foundation

protocol APIServiceDelegate: AnyObject {
    func service(didRecieveData data: [GenreModel])
    func service(didRecieveError error: String)
    func service(isWaiting: Bool)
    func service(didRecieveGameList list: [GameListElementModel])
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
            delegate?.service(didRecieveData: genres)
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
            let games = genresResponse.results
            delegate?.service(didRecieveGameList: games)
        } catch {
            print(error)
        }
    }

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
                    self?.delegate?.service(didRecieveError: "Error occure in response")
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
            self?.delegate?.service(didRecieveData: genres)
            self?.delegate?.service(isWaiting: false)
        }

        delegate?.service(isWaiting: true)
        task.resume()
    }

    func fetchGamesForGenre(_ genreId: Int) {
        let url = URL(string: "\(APIConstants.baseURL)games?genre=\(genreId)&\(APIConstants.apiKey)")!

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
                    self?.delegate?.service(didRecieveError: "Error occure in response")
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


            self?.delegate?.service(didRecieveGameList: respData.results)
            self?.delegate?.service(isWaiting: false)
        }

        delegate?.service(isWaiting: true)
        task.resume()
    }
}

extension APIService: GenreDetailViewCellAction {
    func cellDidRecieveTap(for genreId: Int) {
//        fetchGamesForGenre(genreId)
        mockFetchGamesForGenre(genreId)
    }
}
