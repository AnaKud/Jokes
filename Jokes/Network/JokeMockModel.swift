// JokeMockModel.swift
// Created by Anastasiya Kudasheva

import Foundation

struct JokeModel: Codable {
	let id: Int
	let type: String
	let setup: String
	let punchline: String
}
