//
//  SettingsController.swift
//  RAWGBrowser
//
//  Created by Patrick on 08.03.2023..
//

import UIKit

class SettingsController {

    var settingOptions = [SettingViewModel]() {
        didSet {
            updateSnapshot()
        }
    }

    var diffableDataSource: UITableViewDiffableDataSource<String, String>?

    init() {
        addSettings()
    }

    func createDataSource(for tableView: UITableView) {
        let diffableDataSource = UITableViewDiffableDataSource<String, String>(tableView: tableView) { [weak self] tableView, indexPath, itemIdentifier in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "setting cell", for: indexPath) as? SettingsCell else {
                fatalError("Cell not found")
            }

            if let setting = self?.settingOptions.first(where: {$0.title == itemIdentifier}) {
                cell.setContent(setting)
            }

            return cell
        }
        
        self.diffableDataSource = diffableDataSource
        updateSnapshot()
    }

    func addSettings() {
        let settingOption = SettingViewModel(title: "Reset genre", imageName: "arrow.triangle.2.circlepath")
        settingOptions.append(settingOption)
    }

    func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<String, String>()

        snapshot.appendSections(["Settings"])

        settingOptions.forEach { viewModel in
            snapshot.appendItems([viewModel.title], toSection: "Settings")
        }

        diffableDataSource?.apply(snapshot)
    }
}
