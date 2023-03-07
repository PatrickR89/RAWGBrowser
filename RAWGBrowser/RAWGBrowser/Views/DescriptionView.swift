//
//  DescriptionView.swift
//  RAWGBrowser
//
//  Created by Patrick on 07.03.2023..
//

import UIKit

protocol DescriptionViewDelegate: AnyObject {
    func viewDidRequestClose()
}

class DescriptionView: UIView {

    weak var delegate: DescriptionViewDelegate?

    let closeButton: UIButton = {
        let button = UIButton().createCircularButton("xmark.circle")
        return button
    }()

    let textView: UITextView = {
        let textView = UITextView()
        textView.textColor = ColorConstants.orangeAccent
        textView.backgroundColor = .clear
        textView.font = UIFont.systemFont(ofSize: 15)
        return textView
    }()

    init() {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func didTapClose() {
        delegate?.viewDidRequestClose()
    }

    private func setupUI() {
        layer.cornerRadius = 15
        backgroundColor = ColorConstants.darkBackground.withAlphaComponent(0.8)
        addCloseButtonSubview()
        addTextViewSubview()
    }

    func populateData(_ description: String) {
        textView.text = description
    }
}

private extension DescriptionView {
    func addCloseButtonSubview() {
        addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
        ])
    }

    func addTextViewSubview() {
        addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 10),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
