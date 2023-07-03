// NetworkDataFetcher.swift
// Created by Anastasiya Kudasheva

import Foundation

class NetworkDataFetcher {
	private let urlString = "https://official-joke-api.appspot.com/jokes/random"

	func fetchData(_ completion: @escaping (Result<JokeModel, AppError>) -> Void) {
		guard let url = URL(string: urlString) else {
			completion(.failure(.internetError))
			return
		}

		URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in

			guard error == nil,
				(response as? HTTPURLResponse)?.statusCode == 200 else {
				completion(.failure(.internetError))
				return
			}

			guard let data else {
				completion(.failure(.emptyDataError))
				return
			}

			do {
				let joke = try JSONDecoder().decode(JokeModel.self, from: data)
				completion(.success(joke))
			}
			catch {
				completion(.failure(.parsingError))
			}
		}
		.resume()
	}
}
