// JokesDataParser.swift
// Created by Anastasiya Kudasheva

import Foundation

class JokesDataParser {
	func parseData(from data: Data, _ completion: @escaping ((Result<JokeModel, AppError>) -> Void)) {
		do {
			let joke = try JSONDecoder().decode(JokeModel.self, from: data)
			completion(.success(joke))
		} catch {
			completion(.failure(.parsingError))
		}
	}
}
