// ViewController.swift
// Created by Anastasiya Kudasheva

import UIKit

class ViewController: UIViewController {
	@IBOutlet weak var jokeView: UIView!
	@IBOutlet weak var setupJokeLabel: UILabel!

	private let jokes = JokeModelsMock()
	private var joke: JokeModel {
		jokes[currentIndex]
	}
	var currentIndex = 0

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		roundCornerForAllViews()
		showJoke()
	}

	override func viewDidAppear(_ animated: Bool) {
		showAlert(title: "Привет", message: "Юзер")
	}

	func roundCornerForAllViews() {
		let cornerRadius: CGFloat = 8
		let borderWidth: CGFloat = 2

		// ToDo: Неверный черный
		jokeView.layer.borderColor = UIColor.black.cgColor
		jokeView.layer.borderWidth = borderWidth
		jokeView.layer.cornerRadius = cornerRadius
	}

	func setupData() {
	}

	func showJoke() {
		setupJokeLabel.text = joke.setup
	}

	@IBAction func showPunchButtonTapped(_ sender: Any) {
		showAlert(title: "Punchline", message: joke.punchline)
	}

	@IBAction func refreshButtonTapped(_ sender: Any) {
		if currentIndex == jokes.jokesCount - 1 {
			currentIndex = -1
		}
		currentIndex += 1
		showJoke()
	}

	func showAlert(title: String, message: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let action = UIAlertAction(title: "Ok", style: .default)
		alert.addAction(action)
		present(alert, animated: true)
	}
}
