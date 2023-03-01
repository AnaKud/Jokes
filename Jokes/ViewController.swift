// ViewController.swift
// Created by Anastasiya Kudasheva

import UIKit

protocol IAlertPresentable: AnyObject {
	func present(_ viewControllerToPresent: UIViewController,
				 animated: Bool,
				 completion: (() -> Void)?)
}

extension IAlertPresentable {
	func present(_ viewControllerToPresent: UIViewController, animated: Bool) {
		self.present(viewControllerToPresent, animated: animated, completion: nil)
	}
}

class ViewController: UIViewController {
	@IBOutlet weak var jokeIdView: UIView!
	@IBOutlet weak var idLabel: UILabel!

	@IBOutlet weak var jokeTypeView: UIView!
	@IBOutlet weak var typeLabel: UILabel!

	@IBOutlet weak var jokeView: UIView!
	@IBOutlet weak var setupJokeLabel: UILabel!

	@IBOutlet weak var showPunchButton: UIButton!
	@IBOutlet weak var refreshButton: UIButton!

	private var alertPresenter: IAlertPresenter?

	// To-Do Удалить после добавления сетевых данных
	private let jokeModelsMock = JokeModelsMock()
	private var currentJokeIndex = 0

	override func viewDidLoad() {
		super.viewDidLoad()

		self.alertPresenter = AlertPresenter()
		self.alertPresenter?.didLoad(self)

		self.showJoke(jokeModelsMock[currentJokeIndex])
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.roundCornerForAllViews()
	}

	@IBAction func showPunchButtonTapped(_ sender: Any) {
		let joke = jokeModelsMock[currentJokeIndex]
		let alertModel = AlertModel(title: joke.punchline, buttonTitle: "Ok")
		self.alertPresenter?.showAlert(for: alertModel)
	}

	@IBAction func refreshButtonTapped(_ sender: Any) {
		self.setupData()
	}
}

// MARK: - IAlertPresentable
extension ViewController: IAlertPresentable { }

// MARK: - Additional UI Settings
private extension ViewController {
	func setupData() {
		if currentJokeIndex + 1 == jokeModelsMock.jokesCount {
			let alertModel = AlertModel(title: "Not sorry",
										message: "Sorry, all jokes is end",
										buttonTitle: "Ok") {
				self.currentJokeIndex = 0
				self.showJoke(self.jokeModelsMock[self.currentJokeIndex])
			}
			self.alertPresenter?.showAlert(for: alertModel)
		} else {
			self.currentJokeIndex += 1
			let joke = jokeModelsMock[currentJokeIndex]
			self.showJoke(joke)
		}
	}
}

// MARK: - Additional UI Settings
private extension ViewController {
	func showJoke(_ joke: JokeModel) {
		self.idLabel.text = String(joke.id)
		self.typeLabel.text = joke.type
		self.setupJokeLabel.text = joke.setup
	}

	func roundCornerForAllViews() {
		let cornerRadius: CGFloat = 8
		let borderWidth: CGFloat = 2

		self.jokeIdView.layer.borderColor = UIColor.jBlack.cgColor
		self.jokeIdView.layer.borderWidth = borderWidth
		self.jokeIdView.layer.cornerRadius = cornerRadius

		self.jokeTypeView.layer.borderColor = UIColor.jBlack.cgColor
		self.jokeTypeView.layer.borderWidth = borderWidth
		self.jokeTypeView.layer.cornerRadius = cornerRadius

		self.jokeView.layer.borderColor = UIColor.jBlack.cgColor
		self.jokeView.layer.borderWidth = borderWidth
		self.jokeView.layer.cornerRadius = cornerRadius

		self.showPunchButton.layer.borderColor = UIColor.jBlack.cgColor
		self.showPunchButton.layer.borderWidth = borderWidth
		self.showPunchButton.layer.cornerRadius = cornerRadius

		self.refreshButton.layer.borderColor = UIColor.jBlack.cgColor
		self.refreshButton.layer.borderWidth = borderWidth
		self.refreshButton.layer.cornerRadius = cornerRadius
	}
}
