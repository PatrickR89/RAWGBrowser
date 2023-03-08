//
//  MockDatabaseService.swift
//  RAWGBrowserTests
//
//  Created by Patrick on 08.03.2023..
//

import UIKit
@testable import RAWGBrowser
import FirebaseDatabase

class MockDatabaseService: DatabaseService {

    override init() {
        super.init()
        self.dbReference = nil
    }
    
    override func saveGenreId(_ id: Int) {
        //
    }

    override func observeGenreId() {
        //
    }

    override func removeId() {
        //
    }
}
