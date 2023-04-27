// AppError.swift
// Created by Anastasiya Kudasheva

import Foundation

enum AppError: Error {
	case parsingError
	case internetError
	case emptyDataError

	var description: String {
		switch self {
		case .parsingError: return "Ошибка декодирования данных"
		case .internetError: return "Ошибка получения данных"
		case .emptyDataError: return "Данные не пришли"
		}
	}
}
