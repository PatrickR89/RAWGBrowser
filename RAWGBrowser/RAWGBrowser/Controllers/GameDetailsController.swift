//
//  GameDetailsController.swift
//  RAWGBrowser
//
//  Created by Patrick on 07.03.2023..
//

import UIKit

class GameDetailsController {
    var keys: [String] = [] {
        didSet {
            updateSnapshot()
        }
    }
    var details: [String: [String]] = [:] {
        didSet {
            keys = details.keys.sorted(by: { $0 < $1 }).map { $0 }
        }
    }

    var dataSource: UITableViewDiffableDataSource<Int, String>?

    func createDataSource(for tableView: UITableView) {
        let dataSource = UITableViewDiffableDataSource<
            Int, String
        >(tableView: tableView) { [weak self] tableView, indexPath, itemIdentifier in
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "Detail cell",
                for: indexPath) as? GameDetailViewCell else {
                fatalError("Cell not found")
            }
            if let data = self?.details[itemIdentifier, default: []] {
                cell.populateData(key: itemIdentifier, values: data)
            }

            return cell
        }

        self.dataSource = dataSource
        updateSnapshot()
    }

    func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])

        snapshot.appendItems(keys, toSection: 0)
        dataSource?.apply(snapshot)
    }

    func populateData(_ data: [String: [String]]) {
        self.details = data
    }
}
