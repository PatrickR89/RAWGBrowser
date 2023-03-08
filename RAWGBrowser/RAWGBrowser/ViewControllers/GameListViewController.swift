//
//  GameListViewController.swift
//  RAWGBrowser
//
//  Created by Patrick on 07.03.2023..
//

import UIKit

protocol GameListViewControllerDelegate: AnyObject {
    func viewController(didTapCellWith id: Int)
    func viewController(didRequestNextPage pageUrl: String)
}

protocol GameListViewControllerActions: AnyObject {
    func viewControllerDidRequestClose()
}

class GameListViewController: UIViewController {

    let controller: GameListController
    weak var delegate: GameListViewControllerDelegate?
    weak var actions: GameListViewControllerActions?

    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    } ()

    init(_ controller: GameListController) {
        self.controller = controller
        super.init(nibName: nil, bundle: nil)
        self.controller.createDataSource(for: tableView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        customizeNavBar()
        addNavigationItem()
    }

    func setupUI() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.register(GameViewCell.self, forCellReuseIdentifier: "Game Cell")
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = 100

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        setupBackground()
    }

    private func addNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .plain,
            target: self,
            action: #selector(didTapCloseButton))
    }

    private func customizeNavBar() {
        let customNavigationBarAppearance = UINavigationBarAppearance()
        customNavigationBarAppearance.configureWithOpaqueBackground()
        customNavigationBarAppearance.backgroundColor = ColorConstants.darkBackground.withAlphaComponent(0.7)
        navigationController?.navigationBar.standardAppearance = customNavigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = customNavigationBarAppearance
        navigationController?.navigationBar.tintColor = ColorConstants.orangeAccent
    }

    private func setupBackground() {
        let gradient = CAGradientLayer()
        gradient.colors = [ColorConstants.darkBackground.cgColor,
                           ColorConstants.lightBackground.cgColor]
        gradient.frame = view.bounds
        gradient.startPoint = .init(x: 0.6, y: 0)
        gradient.endPoint = .init(x: 1, y: 0)
        view.layer.insertSublayer(gradient, at: 0)
    }

    @objc private func didTapCloseButton() {
        actions?.viewControllerDidRequestClose()
    }
}

extension GameListViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            guard let itemIdentifier = controller.diffableDataSource?.itemIdentifier(for: indexPath) else {
                return
            }
            delegate?.viewController(didTapCellWith: itemIdentifier)
        }

    func tableView(
        _ tableView: UITableView, willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath) {
            if indexPath.row == tableView.numberOfRows(inSection: 0) - 1 {
                guard let next = controller.nextPage else { return }
                delegate?.viewController(didRequestNextPage: next)
            }
        }
}
