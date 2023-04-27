// IAlertPresentable.swift
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
