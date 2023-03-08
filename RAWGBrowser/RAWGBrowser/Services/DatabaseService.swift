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
    var dbReference: DatabaseReference?
    var observers = [DatabaseHandle]()
    weak var delegate: DatabaseServiceDelegate?

    init() {
        self.dbReference = Database.database().reference(withPath: "rawg_browser")
        observeGenreId()
    }

    deinit {
        
    }

    /// Method to save genresId to `Firebase`
    /// - Parameter id: id of genre which will be saved
    func saveGenreId(_ id: Int) {
        guard let dbReference else {return}
        let genreIdRef = dbReference.child("genre_id")
        genreIdRef.setValue(id) { [weak self] error, _ in
            if let error {
                self?.delegate?.databaseService(didRecieveError: error.localizedDescription)
            }
        }
    }

    /// Observer/subscription to `Firebase` in order to listen to changes created for genreId
    func observeGenreId() {
        guard let dbReference else {return}
        let idObserver = dbReference.observe(.value) { [weak self] snapshot  in
            guard let dictionary = snapshot.value as? [String: Int] else {
                self?.delegate?.databaseService(didRecieveId: nil)
                return
            }

            self?.delegate?.databaseService(didRecieveId: dictionary["genre_id"])
        }

        observers.append(idObserver)
    }

    /// Method to remove genreId from `Firebase
    func removeId() {
        guard let dbReference else {return}
        let genreIdRef = dbReference.child("genre_id")
        genreIdRef.removeValue { [weak self] error, _ in
            if let error {
                self?.delegate?.databaseService(didRecieveError: error.localizedDescription)
            }
        }
    }
}
