// ViewController.swift
// Created by Anastasiya Kudasheva

import UIKit

class ViewController: UIViewController {
	@IBOutlet weak var jokeView: UIView!
	@IBOutlet weak var setupJokeLabel: UILabel!

	@IBOutlet weak var refreshButton: UIButton!
	@IBOutlet weak var showButton: UIButton!

	private var currentIndex = 0
	private var joke: JokeModel?
	private let jokesMock = JokeModelsMock()

	private var alertPresenter: AlertPresenter?

	override func viewDidLoad() {
		super.viewDidLoad()
		setupData()
		alertPresenter = AlertPresenter(viewController: self)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		roundCornerForAllViews()
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
		if currentIndex == self.jokesMock.jokesCount {
			showAlert(for: AlertModel(title: "Jokes is end",
									  message: nil,
									  tapHandler: {
				self.currentIndex = 0
				self.setupData()
			}))
		} else {
			let newJoke = self.jokesMock[currentIndex]
			self.joke = newJoke
			self.showJoke(newJoke)
			currentIndex += 1
		}
	}

	func showAlert(for model: AlertModel) {
		alertPresenter?.showAlert(for: model)
	}

	func showJoke(_ joke: JokeModel) {
		self.setupJokeLabel.text = joke.setup
	}

	@IBAction func showPunchButtonTapped(_ sender: Any) {
		showAlert(for: AlertModel(title: joke?.punchline,
								  message: nil,
								  tapHandler: nil))
	}

	@IBAction func refreshButtonTapped(_ sender: Any) {
		setupData()
	}
}

struct AlertModel {
	let title: String?
	let message: String?
	let tapHandler: (() -> Void)?
}

class AlertPresenter {
	private weak var viewController: UIViewController?

	init(viewController: UIViewController?) {
		self.viewController = viewController
	}

	func showAlert(for model: AlertModel) {
		let alert = UIAlertController(title: model.title,
									  message: model.message,
									  preferredStyle: .alert)
		let action = UIAlertAction(title: "OK", style: .default) { _ in
			model.tapHandler?()
		}
		alert.addAction(action)
		viewController?.present(alert, animated: true)
	}
}
