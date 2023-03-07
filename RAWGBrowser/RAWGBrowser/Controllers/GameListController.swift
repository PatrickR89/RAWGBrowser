//
//  GameListController.swift
//  RAWGBrowser
//
//  Created by Patrick on 07.03.2023..
//

import UIKit

class GameListController {
    var previousPage: String?
    var nextPage: String?
    var gameList: [GameListElementViewModel] = [] {
        didSet {
            updateSnapshot()
        }
    }

    init(_ data: GameListResponseModel) {
        previousPage = data.previous
        nextPage = data.next
        data.results.forEach { gameList.append(GameListElementViewModel($0)) }
    }

    var diffableDataSource: UITableViewDiffableDataSource<Int, Int>?

    func createDataSource(for tableView: UITableView) {
        let dataSource = UITableViewDiffableDataSource<
            Int, Int
        >(tableView: tableView) { [weak self] tableView, indexPath, itemIdentifier in
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "Game Cell",
                for: indexPath) as? GameViewCell else {
                fatalError("Cell not found")
            }

            if let game = self?.gameList.first(where: { $0.id == itemIdentifier}) {
                cell.setupData(game)
            }

            return cell
        }
        diffableDataSource = dataSource
        updateSnapshot()
    }

    func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        snapshot.appendSections([0])

        snapshot.appendItems(gameList.map { $0.id}, toSection: 0)

        diffableDataSource?.apply(snapshot)
    }

    func populateData(_ data: GameListResponseModel) {
        previousPage = data.previous
        nextPage = data.next

        data.results.forEach { model in
            if !gameList.contains(where: { viewModel in
                viewModel.id == model.id
            }) {
                gameList.append(GameListElementViewModel(model))
            }
        }
    }
}
