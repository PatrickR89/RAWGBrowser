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
    let service: APIService

    init(_ service: APIService) {
        self.service = service
    }

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
                cell.action = self?.service
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
            let viewModel = GenreViewModel(model)
            return viewModel
        }

        self.genres = updatedData
    }
}
