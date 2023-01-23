// JokeMockModel.swift
// Created by Anastasiya Kudasheva

import Foundation

struct JokeModel {
	let id: Int
	let type: String
	let setup: String
	let punchline: String
}

struct JokeModelsMock {
	private let jokes = [
		JokeModel(id: 1,
				  type: "general",
				  setup: "What's Forrest Gump's password?",
				  punchline: "1Forrest1"),
		JokeModel(id: 167,
				  type: "numbers",
				  setup: "What did the 0 say to the 8?",
				  punchline: "Nice belt."),
		JokeModel(id: 23,
				  type: "animals",
				  setup: "What do you call a careful wolf?",
				  punchline: "Aware wolf"),
		JokeModel(id: 999,
				  type: "general",
				  setup: "99.9% of the people are dumb!",
				  punchline: "Fortunately I belong to the remaining 1%"),
		JokeModel(id: 834,
				  type: "countries",
				  setup: "What’s the advantage of living in Switzerland?",
				  punchline: "Well, the flag is a big plus."),
		JokeModel(id: 737,
				  type: "programming",
				  setup: "- Knock-knock\n- Who's there?",
				  punchline: "Alert"),
	]

	var jokesCount: Int {
		return jokes.count
	}

	subscript(_ index: Int) -> JokeModel {
		return self.jokes[index]
	}
}
