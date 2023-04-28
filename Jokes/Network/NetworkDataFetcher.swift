// NetworkDataFetcher.swift
// Created by Anastasiya Kudasheva

import Foundation

class NetworkDataFetcher {
	private static let urlString = "https://official-joke-api.appspot.com/jokes/random"

	func fetchJoke(_ completion: @escaping ((Result<Data, AppError>) -> Void)) {
		guard let url = URL(string: Self.urlString) else { return }
		let request = URLRequest(url: url)
		URLSession.shared.dataTask(with: request) { data, response, error in
			guard error == nil,
				  (response as? HTTPURLResponse)?.statusCode == 200 else { return completion(.failure(.internetError)) }
			guard let data = data else { return completion(.failure(.emptyDataError)) }

			completion(.success(data))
		}
		.resume()
	}
}
