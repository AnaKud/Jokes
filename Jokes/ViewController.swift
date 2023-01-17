// ViewController.swift
// Created by Anastasiya Kudasheva

import UIKit

class ViewController: UIViewController {
	@IBOutlet weak var jokeView: UIView!
	@IBOutlet weak var setupJokeLabel: UILabel!

	override func viewDidLoad() {
		super.viewDidLoad()
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
	}

	func showJoke(_ joke: JokeModel) {
	}

	@IBAction func showPunchButtonTapped(_ sender: Any) {
	}

	@IBAction func refreshButtonTapped(_ sender: Any) {
	}
}
