//
//  OnboardingViewController.swift
//  RAWGBrowser
//
//  Created by Patrick on 06.03.2023..
//

import UIKit

class OnboardingViewController: UIViewController {

    let controller: OnboardingController
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.95, height: UIScreen.main.bounds.height * 0.8)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collectionView.register(GenreDetailViewCell.self, forCellWithReuseIdentifier: "Genre cell")
        return collectionView
    }()

    init(controller: OnboardingController) {
        self.controller = controller
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        controller.createDataSource(for: collectionView)
        collectionView.backgroundColor = .red
        collectionView.delegate = self

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension OnboardingViewController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            let center = CGPoint(x: collectionView.frame.size.width / 2 + scrollView.contentOffset.x,
                                 y: collectionView.frame.size.height / 2 + scrollView.contentOffset.y)

            guard let indexPath = collectionView.indexPathForItem(at: center) else { return }
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}
