// ViewController.swift
// Created by Anastasiya Kudasheva

import UIKit

class ViewController: UIViewController {
	@IBOutlet weak var jokeIdView: UIView!
	@IBOutlet weak var idLabel: UILabel!

	@IBOutlet weak var jokeTypeView: UIView!
	@IBOutlet weak var typeLabel: UILabel!

	@IBOutlet weak var jokeView: UIView!
	@IBOutlet weak var setupJokeLabel: UILabel!

	@IBOutlet weak var showPunchButton: UIButton!
	@IBOutlet weak var refreshButton: UIButton!

	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!

	private var alertPresenter: IAlertPresenter?
	private var joke: JokeModel!
	private var jokesLoader: JokesLoading?

	override func viewDidLoad() {
		super.viewDidLoad()
		self.jokesLoader = JokesLoader()
		self.alertPresenter = AlertPresenter()
		self.alertPresenter?.didLoad(self)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.roundCornerForAllViews()
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		self.setupData()
	}

	@IBAction func showPunchButtonTapped(_ sender: Any) {
		let alertModel = AlertModel(title: self.joke.punchline, buttonTitle: "Ok")
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
		self.showActivity()
		jokesLoader?.load { [weak self] result in
			guard let self else { return }
			switch result {
			case .success(let joke):
				self.joke = joke
				self.showJoke(self.joke)
			case .failure(let error):
				self.showError(error)
			}
			self.hideActivity()
		}
	}

	func showError(_ error: AppError) {
		DispatchQueue.main.async { [weak self] in
			let alertModel = AlertModel(message: error.description, buttonTitle: "OK")
			self?.alertPresenter?.showAlert(for: alertModel)
		}
	}

	func showJoke(_ joke: JokeModel) {
		DispatchQueue.main.async {
			self.idLabel.text = String(joke.id)
			self.typeLabel.text = joke.type
			self.setupJokeLabel.text = joke.setup
		}
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

	func showActivity() {
		DispatchQueue.main.async { [weak self] in
			self?.activityIndicator.isHidden = false
			self?.activityIndicator.startAnimating()
		}
	}

	func hideActivity() {
		DispatchQueue.main.async { [weak self] in
			self?.activityIndicator.stopAnimating()
		}
	}
}
