// NetworkDataFetcher.swift
// Created by Anastasiya Kudasheva

import Foundation

class NetworkDataFetcher {
	private let requestString = "https://official-joke-api.appspot.com/jokes/random"

	func fetchData(_ completion: @escaping ((Result<Data, AppError>) -> Void)) {
		guard let url = URL(string: self.requestString) else { return }
		let request = URLRequest(url: url)

		URLSession.shared.dataTask(with: request, completionHandler: { data, _, error in
			guard error == nil else { return completion(.failure(.internetError)) }

			guard let data else { return completion(.failure(.emptyDataError)) }

			completion(.success(data))
		})
		.resume()
	}
}
