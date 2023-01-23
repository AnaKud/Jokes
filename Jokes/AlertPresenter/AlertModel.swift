// AlertModel.swift
// Created by Anastasiya Kudasheva

import Foundation

struct AlertModel {
	let title: String?
	let message: String?
	let buttonTitle: String
	let tapHandler: (() -> Void)?

	init(title: String? = nil,
		 message: String? = nil,
		 buttonTitle: String,
		 tapHandler: (() -> Void)? = nil) {
		self.title = title
		self.message = message
		self.buttonTitle = buttonTitle
		self.tapHandler = tapHandler
	}
}
