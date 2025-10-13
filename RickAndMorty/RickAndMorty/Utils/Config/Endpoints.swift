// 
//  Endpoints.swift
//  RickAndMorty
//
//  Created by Javier Fernández Martínez on 13/10/25.
//  Copyright © 2025 Naihmor Apps. All rights reserved.
//
//  This code is the property of Naihmor Apps. Unauthorized distribution, 
//  modification, or use of this code, in whole or in part, is strictly prohibited.
//

import Foundation

enum Endpoint {
	case characters(page: Int?, name: String?, status: String?, species: String?, type: String?, gender: String?)
}

// MARK: - Public computed properties

extension Endpoint {
	
	/// Path component for this endpoint (without base host or root path).
	var path: String {
		switch self {
		case .characters: return "/character"
		}
	}
	
	/// Query items for this endpoint.
	var queryItems: [URLQueryItem]? {
		switch self {
		case let .characters(page, name, status, species, type, gender):
			var items: [URLQueryItem] = []
			if let page 						{ items.append(.init(name: "page", value: String(page))) }
			if let name, !name.isEmpty 			{ items.append(.init(name: "name", value: name)) }
			if let status, !status.isEmpty 		{ items.append(.init(name: "status", value: status)) }
			if let species, !species.isEmpty	{ items.append(.init(name: "species", value: species)) }
			if let type, !type.isEmpty 			{ items.append(.init(name: "type", value: type)) }
			if let gender, !gender.isEmpty 		{ items.append(.init(name: "gender", value: gender)) }
			return items.isEmpty ? nil : items
		}
	}
}

// MARK: - Public functions

extension Endpoint {
	
	/// Builds a fully-qualified URL using `AppConfig` base and root path.
	/// - Returns: `URL` constructed with scheme/host from base, `/api` root path, endpoint path and query items.
	func url() -> URL {
		var components = URLComponents()
		components.scheme = AppConfig.apiBaseURL.scheme
		components.host = AppConfig.apiBaseURL.host
		// If base has a non-standard port or path, preserve them
		components.port = AppConfig.apiBaseURL.port
		let basePath = AppConfig.apiBaseURL.path == "/" ? "" : AppConfig.apiBaseURL.path
		components.path = basePath + AppConfig.apiRootPath + path
//		components.queryItems = queryItems
		guard let url = components.url else {
			preconditionFailure("Invalid URL components for endpoint: \(self)")
		}
		return url
	}
}
