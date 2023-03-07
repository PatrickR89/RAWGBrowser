//
//  OnboardingController.swift
//  RAWGBrowser
//
//  Created by Patrick on 06.03.2023..
//

import UIKit

class OnboardingController {
    var genres: [GenreViewModel] = [] {
        didSet {
            updateSnapshot()
        }
    }

    var dataSource: UICollectionViewDiffableDataSource<Int, Int>?

    func createDataSource(for collectionView: UICollectionView) {
        let diffableDataSource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: collectionView) { [weak self] collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Genre cell", for: indexPath) as? GenreDetailViewCell else {
                fatalError("Cell not found")
            }
            let genre = self?.genres.first { viewModel in
                viewModel.id == itemIdentifier
            }
            if let genre {
                cell.setCellData(genre)
            }

            return cell
        }
        
        self.dataSource = diffableDataSource
        updateSnapshot()
    }

    func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()

        snapshot.appendSections([0])

        for genre in genres {
            snapshot.appendItems([genre.id], toSection: 0)
        }

        dataSource?.apply(snapshot, animatingDifferences: true)
    }

    func populateData(_ data: [GenreModel]) {

        let updatedData = data.map { model in
            let imageUrl = URL(string: model.image_background)
            let games = model.games.map { gameModel in
                return GameExample(id: gameModel.id, name: gameModel.name)
            }
            let viewModel = GenreViewModel(id: model.id, name: model.name, games_count: model.games_count, image_background: imageUrl, games: games)
            return viewModel
        }

        self.genres = updatedData
    }
}
