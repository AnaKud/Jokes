// JokesDataParser.swift
// Created by Anastasiya Kudasheva

import Foundation

class JokesDataParser {
	private let decoder = JSONDecoder()

	func parseData(_ data: Data) -> Result<JokeModel, AppError> {
		do {
			let joke = try self.decoder.decode(JokeModel.self, from: data)
			return .success(joke)
		} catch {
			return .failure(.parsingError)
		}
	}
}

class JokesDataParser1 {
	func parseData(_ data: Data) -> Result<JokeModel, AppError> {
		do {
			guard let jokeDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
				  let type = jokeDictionary["type"] as? String,
				  let setup = jokeDictionary["setup"] as? String,
				  let punchline = jokeDictionary["punchline"] as? String,
				  let id = jokeDictionary["id"] as? Int
			else { return .failure(.parsingError) }
			let joke = JokeModel(id: id, type: type, setup: setup, punchline: punchline)
			return .success(joke)
		} catch {
			return .failure(.parsingError)
		}
	}
}
