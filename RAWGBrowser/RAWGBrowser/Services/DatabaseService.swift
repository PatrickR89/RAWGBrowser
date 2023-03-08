//
//  DatabaseService.swift
//  RAWGBrowser
//
//  Created by Patrick on 08.03.2023..
//

import Foundation
import FirebaseDatabase

protocol DatabaseServiceDelegate: AnyObject {
    func databaseService(didRecieveId id: Int?)
    func databaseService(didRecieveError error: String)
}

class DatabaseService {
    let dbReference = Database.database().reference(withPath: "rawg_browser")
    var observers = [DatabaseHandle]()
    weak var delegate: DatabaseServiceDelegate?

    init() {
        observeGenreId()
    }

    deinit {
        
    }

    func saveGenreId(_ id: Int) {

        let genreIdRef = dbReference.child("genre_id")
        genreIdRef.setValue(id) { [weak self] error, _ in
            if let error {
                self?.delegate?.databaseService(didRecieveError: error.localizedDescription)
            }
        }
    }

    func observeGenreId() {
        let idObserver = dbReference.observe(.value) { [weak self] snapshot  in
            guard let dictionary = snapshot.value as? [String: Int] else {
                self?.delegate?.databaseService(didRecieveId: nil)
                return
            }

            self?.delegate?.databaseService(didRecieveId: dictionary["genre_id"])
        }

        observers.append(idObserver)
    }

    func removeId() {
        let genreIdRef = dbReference.child("genre_id")
        genreIdRef.removeValue { [weak self] error, _ in
            if let error {
                self?.delegate?.databaseService(didRecieveError: error.localizedDescription)
            }
        }
    }
}
