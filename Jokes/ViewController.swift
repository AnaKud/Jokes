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

	override func viewDidLoad() {
		super.viewDidLoad()

		self.alertPresenter = AlertPresenter()
		self.alertPresenter?.didLoad(self)

		self.setupData()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.roundCornerForAllViews()
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
		self.refreshButton.isEnabled = false
		self.showPunchButton.isEnabled = false

		guard let url = URL(string: "https://official-joke-api.appspot.com/jokes/random") else {
			self.showError(.internetError)
			return
		}

		URLSession.shared
			.dataTask(with: URLRequest(url: url)) { [weak self] data, response, error in
				guard let self,
					  let data,
					  error == nil,
					  let response = response as? HTTPURLResponse,
					  response.statusCode == 200
				else {
					self?.hideActivity()
					self?.showError(.emptyDataError)
					return
				}

				do {
					let joke = try JSONDecoder().decode(JokeModel.self, from: data)
					self.hideActivity()
					self.joke = joke
					self.showJoke(joke)
				}
				catch {
					self.hideActivity()
					self.showError(.parsingError)
				}
			}
			.resume()
	}

	func showError(_ error: AppError) {
		DispatchQueue.main.async {
			self.refreshButton.isEnabled = true
			self.showPunchButton.isEnabled = true
			let alertModel = AlertModel(message: error.description, buttonTitle: "OK")
			self.alertPresenter?.showAlert(for: alertModel)
		}
	}

	func showJoke(_ joke: JokeModel) {
		DispatchQueue.main.async {
			self.idLabel.text = String(joke.id)
			self.typeLabel.text = joke.type
			self.setupJokeLabel.text = joke.setup

			self.refreshButton.isEnabled = true
			self.showPunchButton.isEnabled = true
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
