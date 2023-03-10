//
//  GameDetailViewController.swift
//  RAWGBrowser
//
//  Created by Patrick on 07.03.2023..
//

import UIKit
import SDWebImage

/// `UIViewController` presenting details about selected game
class GameDetailViewController: UIViewController {

    let controller: GameDetailsController

    let heroHeader: HeroImageView = {
        return HeroImageView()
    }()

    let descriptionView: DescriptionView = {
        let view = DescriptionView()
        view.isHidden = true
        return view
    }()

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(GameDetailViewCell.self, forCellReuseIdentifier: "Detail cell")
        return tableView
    }()

    init(_ viewModel: GameDetailViewModel, _ controller: GameDetailsController) {
        self.controller = controller
        super.init(nibName: nil, bundle: nil)
        controller.createDataSource(for: tableView)
        heroHeader.setupUI(in: view.frame, for: viewModel.backgroundImage, with: viewModel.name)
        descriptionView.populateData(viewModel.description)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    /// Main method to set up UI
    func setupUI() {
        addHeroHeaderSubview()
        addTableViewSubview()
        addDescriptionViewSubview()
        setupBackground()
    }

    /// Method which sets customized background
    private func setupBackground() {
        let gradient = CAGradientLayer()
        gradient.colors = [ColorConstants.darkBackground.cgColor, ColorConstants.lightBackground.cgColor]
        gradient.frame = view.bounds
        gradient.startPoint = .init(x: 0, y: 0.7)
        gradient.endPoint = .init(x: 0, y: 1)
        view.layer.insertSublayer(gradient, at: 0)
    }
}

extension GameDetailViewController: HeroImageViewDelegate {
    /// `Delegate protocol` via which ``GameDetailViewController`` is notified to show ``descriptionView``
    func heroImageViewDidRequestInfo() {
        descriptionView.isHidden = false
        view.layoutIfNeeded()
    }
}

extension GameDetailViewController: DescriptionViewDelegate {
    /// `Delegate protocol` via which ``GameDetailViewController`` is notified to hide ``descriptionView``
    func viewDidRequestClose() {
        descriptionView.isHidden = true
        view.layoutIfNeeded()
    }
}

private extension GameDetailViewController {
    /// Method to add ``heroHeader`` as subview and set declared constraints
    func addHeroHeaderSubview() {
        view.addSubview(heroHeader)
        heroHeader.delegate = self
        heroHeader.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            heroHeader.topAnchor.constraint(equalTo: view.topAnchor),
            heroHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            heroHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            heroHeader.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ])
    }

    /// Method to add ``tableView`` as subview and set declared constraints
    func addTableViewSubview() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: heroHeader.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    /// Method to add ``descriptionView`` as subview and set declared constraints
    func addDescriptionViewSubview() {
        view.addSubview(descriptionView)
        descriptionView.delegate = self
        descriptionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            descriptionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            descriptionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            descriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
