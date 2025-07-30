//
//  ResponseDetailViewController.swift
//  Enthral_Project
//
//  Created by sakshi shete on 29/07/25.
//
import UIKit

class ResponseDetailViewController: UIViewController {

    var savedResponse: SavedResponse?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        guard let response = savedResponse else { return }

        // Create scroll view
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        // Constraints for scroll view
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        // Create content label
        let contentLabel = UILabel()
        contentLabel.numberOfLines = 0
        contentLabel.translatesAutoresizingMaskIntoConstraints = false

        let qaText = response.questionsAndAnswers.enumerated().map {
            "Q\($0.offset + 1): \($0.element.question)\nA: \($0.element.answer)"
        }.joined(separator: "\n\n")

        contentLabel.text = """
        Name: \(response.userName)
        Time: \(response.completionTime)

        \(qaText)
        """

        scrollView.addSubview(contentLabel)

        // Constraints for label inside scroll view
        NSLayoutConstraint.activate([
            contentLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            contentLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            contentLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            contentLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            contentLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40)
        ])
    }
}
