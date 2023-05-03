// JokesLoader.swift
// Created by Anastasiya Kudasheva

import Foundation

protocol JokesLoading: AnyObject {
	func load(_ completion: @escaping ((Result<JokeModel, AppError>) -> Void))
}

class JokesLoader {
	private let networkDataFetcher = NetworkDataFetcher()
	private let jokesDataParser = JokesDataParser()
}

extension JokesLoader: JokesLoading {
	func load(_ completion: @escaping ((Result<JokeModel, AppError>) -> Void)) {
		networkDataFetcher.fetchData { [weak self] result in
			guard let self else { return }
			switch result {
			case .success(let data):
				let convertedValue = self.convert(data)
				switch convertedValue {
				case .success(let joke):
					completion(.success(joke))
				case .failure(let error):
					completion(.failure(error))
				}
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}

	func load1(_ completion: @escaping ((Result<JokeModel, AppError>) -> Void)) {
		networkDataFetcher.fetchData { [weak self] result in
			guard let self else { return }
			switch result {
			case .success(let data):
				self.jokesDataParser.parseData(from: data, completion)
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}

	private func convert(_ data: Data) -> Result<JokeModel, AppError> {
		do {
			let joke = try JSONDecoder().decode(JokeModel.self, from: data)
			return .success(joke)
		} catch {
			return .failure(.parsingError)
		}
	}
}
