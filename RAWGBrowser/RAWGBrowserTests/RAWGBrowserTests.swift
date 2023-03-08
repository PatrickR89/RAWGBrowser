//
//  RAWGBrowserTests.swift
//  RAWGBrowserTests
//
//  Created by Patrick on 08.03.2023..
//

import XCTest
@testable import RAWGBrowser
import FirebaseCore
import Combine

final class RAWGBrowserTests: XCTestCase {

    var mainCoordinator: MainCoordinator?
    var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        FirebaseApp.configure()
            let mockDatabase = MockDatabaseService()
            self.mainCoordinator = MainCoordinator(NavigationController(), MockAPIService(), mockDatabase)
    }

    override func tearDown() {
        super.tearDown()
        mainCoordinator = nil
        cancellables.removeAll()
    }

    func testServiceFetchGenres() {
        mainCoordinator?.networkService.fetchGenres()

        let expectation = XCTestExpectation(description: "populate genres")

        mainCoordinator?.onboardingController?.$genres.sink(receiveValue: { genres in
            XCTAssertFalse(genres.isEmpty)
            expectation.fulfill()
        }).store(in: &cancellables)

        wait(for: [expectation], timeout: 5)
    }

    func testServiceFetchGames() {

        mainCoordinator?.networkService.fetchGamesForGenre(100)
        let expectation = XCTestExpectation(description: "populate games")

        mainCoordinator?.gameListController?.$gameList.sink(receiveValue: { games in
            XCTAssertFalse(games.isEmpty)
            expectation.fulfill()
        }).store(in: &cancellables)

        wait(for: [expectation], timeout: 5)
    }

    func testServiceFetchSingleGame() {
        mainCoordinator?.networkService.fetchGame(by: 12)
        let expectation = XCTestExpectation(description: "populate game details")

        mainCoordinator?.gameDetailsController?.$keys.sink(receiveValue: { detailKeys in
            XCTAssertFalse(detailKeys.isEmpty)
            expectation.fulfill()
        }).store(in: &cancellables)

        wait(for: [expectation], timeout: 5)
    }
}
