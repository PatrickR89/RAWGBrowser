//
//  SettingsViewController.swift
//  RAWGBrowser
//
//  Created by Patrick on 08.03.2023..
//

import UIKit

protocol SettingsViewControllerDelegate: AnyObject {
    func viewControllerDidRequestGenreReset()
}

class SettingsViewController: UIViewController {

    let controller = SettingsController()
    weak var delegate: SettingsViewControllerDelegate?

    let closeButton: UIButton = {
        let button = UIButton().createCircularButton("xmark")
        return button
    }()

    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    init() {
        super.init(nibName: nil, bundle: nil)
        controller.createDataSource(for: tableView)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func setupUI() {
        view.backgroundColor = ColorConstants.darkBackground.withAlphaComponent(0.9)
        addCloseButtonSubview()
        addTavbleViewSubview()
    }

    private func addCloseButtonSubview() {
        view.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(dismissSelf), for: .touchUpInside)

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }

    private func addTavbleViewSubview() {
        view.addSubview(tableView)
        tableView.headerView(forSection: 0)
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SettingsCell.self, forCellReuseIdentifier: "setting cell")

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    @objc private func dismissSelf() {
        dismiss(animated: true)
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let label = UILabel()
            label.text = "Settings"
            label.font = UIFont(name: "Thonburi-Bold", size: 20)
            label.textColor = ColorConstants.textColor.withAlphaComponent(0.8)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }
        return UILabel()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let itemIdentifier = controller.diffableDataSource?.itemIdentifier(for: indexPath) else { return }
        if itemIdentifier == "Reset genre" {
            delegate?.viewControllerDidRequestGenreReset()
            dismiss(animated: true)
        }
    }
}
