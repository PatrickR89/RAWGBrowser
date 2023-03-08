//
//  OnboardingController.swift
//  RAWGBrowser
//
//  Created by Patrick on 06.03.2023..
//

import UIKit

/// `Controller class` containing methods for ``OnboardingViewController``
class OnboardingController {
    var genres: [GenreViewModel] = [] {
        didSet {
            updateSnapshot()
        }
    }

    var dataSource: UICollectionViewDiffableDataSource<Int, Int>?
    let coordinator: MainCoordinator

    init(_ coordinator: MainCoordinator) {
        self.coordinator = coordinator
    }

    /// Method for creating `DataSource` for `UICollectionView` in ``OnboardingViewController``
    /// - Parameter collectionView: `UICollectionView` which will recieve required data source
    func createDataSource(for collectionView: UICollectionView) {
        let diffableDataSource = UICollectionViewDiffableDataSource<
            Int, Int
        >(collectionView: collectionView) { [weak self] collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "Genre cell",
                for: indexPath) as? GenreDetailViewCell else {
                fatalError("Cell not found")
            }
            let genre = self?.genres.first { viewModel in
                viewModel.id == itemIdentifier
            }
            if let genre {
                cell.setCellData(genre)
                cell.action = self?.coordinator
            }
            return cell
        }
        
        self.dataSource = diffableDataSource
        updateSnapshot()
    }

    /// Method to update data source with newly recieved data
    func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        snapshot.appendSections([0])

        for genre in genres {
            snapshot.appendItems([genre.id], toSection: 0)
        }

        dataSource?.apply(snapshot, animatingDifferences: true)
    }

    /// Method to populate data which will be presented in ``OnboardingViewController`` `UICollectionView` via `UICollectionViewDiffableDataSource`
    /// - Parameter data: recieved data from ``APIService``
    func populateData(_ data: [GenreModel]) {

        let updatedData = data.map { model in
            let viewModel = GenreViewModel(model)
            return viewModel
        }

        self.genres = updatedData
    }
}
