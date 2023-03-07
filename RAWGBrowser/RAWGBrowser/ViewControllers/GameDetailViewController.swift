//
//  GameDetailViewController.swift
//  RAWGBrowser
//
//  Created by Patrick on 07.03.2023..
//

import UIKit
import SDWebImage

class GameDetailViewController: UIViewController {

    let controller = GameDetailsController()

    let heroHeader: HeroImageView = {
        return HeroImageView()
    }()

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(GameDetailViewCell.self, forCellReuseIdentifier: "Detail cell")
        return tableView
    }()

    init(_ viewModel: GameDetailViewModel) {
        super.init(nibName: nil, bundle: nil)
        controller.createDataSource(for: tableView)
        controller.populateData(viewModel.tableContent)
        heroHeader.setupUI(in: view.frame, for: viewModel.backgroundImage, with: viewModel.name)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        view.addSubview(heroHeader)
        view.addSubview(tableView)

        heroHeader.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

        tableView.backgroundColor = .clear

        NSLayoutConstraint.activate([
            heroHeader.topAnchor.constraint(equalTo: view.topAnchor),
            heroHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            heroHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            heroHeader.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            tableView.topAnchor.constraint(equalTo: heroHeader.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        setupBackground()
    }

    private func setupBackground() {
        let gradient = CAGradientLayer()
        gradient.colors = [ColorConstants.darkBackground.cgColor, ColorConstants.lightBackground.cgColor]
        gradient.frame = view.bounds
        gradient.startPoint = .init(x: 0, y: 0.7)
        gradient.endPoint = .init(x: 0, y: 1)
        view.layer.insertSublayer(gradient, at: 0)
    }
}
