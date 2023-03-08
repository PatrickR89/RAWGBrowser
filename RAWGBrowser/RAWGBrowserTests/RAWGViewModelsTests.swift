//
//  RAWGViewModelsTests.swift
//  RAWGBrowserTests
//
//  Created by Patrick on 08.03.2023..
//

import XCTest
@testable import RAWGBrowser

final class RAWGViewModelsTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testGenreViewModel() {
        let model = GenreModel(id: 123, name: "genre", slug: "genre_", games_count: 5, image_background: "none")
        let viewModel = GenreViewModel(model)

        XCTAssertEqual(viewModel.backgroundImage, URL(string: model.image_background))
        XCTAssertEqual(viewModel.id, model.id)
        XCTAssertEqual(viewModel.name, model.name)
        XCTAssertEqual(viewModel.gamesCount, model.games_count)
    }

    func testListElementViewModel() {
        let model = GameListElementModel(id: 33, name: "list element", tba: false, background_image: "some http", rating: 3.45)
        let viewModel = GameListElementViewModel(model)

        XCTAssertEqual(viewModel.id, model.id)
        XCTAssertEqual(viewModel.name, model.name)
        XCTAssertEqual(viewModel.rating, model.rating)
        XCTAssertEqual(viewModel.background_image, URL(string: model.background_image))
    }

    func testGameDetailViewModel() {
        let model = GameModel(name: "somegame", released: nil, rating: 4.5, background_image: nil, alternative_names: ["someOther"], parent_platforms: [], genres: [], esrb_rating: NameProperty.init(name: "13+"), description_raw: nil)
        let viewModel = GameDetailViewModel(model)

        XCTAssertEqual(viewModel.name, model.name)
        XCTAssertEqual(viewModel.description, "")
        XCTAssertEqual(viewModel.tableContent.keys.count, 3)
    }
}
