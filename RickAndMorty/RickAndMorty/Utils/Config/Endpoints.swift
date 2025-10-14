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
	case getAllCharacters(_ filter: CharactersFilter?)
	case getMultipleCharacters(_ ids: [Int])
	case getCharacter(_ id: Int)
	case getAllLocations(_ filter: LocationsFilter?)
	case getMultipleLocations(_ ids: [Int])
	case getLocation(_ id: Int)
	case getAllEpisodes(_ filter: EpisodesFilter?)
	case getMultipleEpisodes(_ ids: [Int])
	case getEpisode(_ id: Int)
}

struct CharactersFilter {
	let name: String?
	let status: String?
	let species: String?
	let type: String?
	let gender: String?
}

struct LocationsFilter {
	let name: String?
	let type: String?
	let dimension: String?
}

struct EpisodesFilter {
	let name: String?
	let episode: String?
}

// MARK: - Public computed properties

extension Endpoint {
	
	/// Path component for this endpoint (without base host or root path).
	var path: String {
		switch self {
		case .getAllCharacters:					return AppConfig.apiCharacterPath
		case .getMultipleCharacters(let ids):	return AppConfig.apiCharacterPath + idsJoined(ids)
		case .getCharacter(let id): 			return AppConfig.apiCharacterPath + "/\(id)"
		case .getAllLocations:					return AppConfig.apiLocationPath
		case .getMultipleLocations(let ids):	return AppConfig.apiLocationPath + idsJoined(ids)
		case .getLocation(let id):				return AppConfig.apiLocationPath + "/\(id)"
		case .getAllEpisodes: 					return AppConfig.apiEpisodePath
		case .getMultipleEpisodes(let ids):		return AppConfig.apiEpisodePath + idsJoined(ids)
		case .getEpisode(let id):				return AppConfig.apiEpisodePath + "/\(id)"
		}
	}
	
	/// Query items for this endpoint.
	var queryItems: [URLQueryItem]? {
		switch self {
		case .getAllCharacters(let filter):
			var items: [URLQueryItem] = []
			if let name = filter?.name, !name.isEmpty 			{ items.append(.init(name: "name", value: name)) }
			if let status = filter?.status, !status.isEmpty 	{ items.append(.init(name: "status", value: status)) }
			if let species = filter?.species, !species.isEmpty	{ items.append(.init(name: "species", value: species)) }
			if let type = filter?.type, !type.isEmpty 			{ items.append(.init(name: "type", value: type)) }
			if let gender = filter?.gender, !gender.isEmpty 	{ items.append(.init(name: "gender", value: gender)) }
			return items.isEmpty ? nil : items
		case .getAllLocations(let filter):
			var items: [URLQueryItem] = []
			if let name = filter?.name, !name.isEmpty 					{ items.append(.init(name: "name", value: name)) }
			if let type = filter?.type, !type.isEmpty 					{ items.append(.init(name: "type", value: type)) }
			if let dimension = filter?.dimension, !dimension.isEmpty	{ items.append(.init(name: "dimension", value: dimension)) }
			return items.isEmpty ? nil : items
		case .getAllEpisodes(let filter):
			var items: [URLQueryItem] = []
			if let name = filter?.name, !name.isEmpty 			{ items.append(.init(name: "name", value: name)) }
			if let episode = filter?.episode, !episode.isEmpty 	{ items.append(.init(name: "episode", value: episode)) }
			return items.isEmpty ? nil : items
		default: return nil
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
		components.port = AppConfig.apiBaseURL.port
		let basePath = AppConfig.apiBaseURL.path == "/" ? "" : AppConfig.apiBaseURL.path
		components.path = basePath + AppConfig.apiRootPath + path
		components.queryItems = queryItems
		guard let url = components.url else { preconditionFailure("Invalid URL components for endpoint: \(self)") }
		return url
	}
}

// MARK: - Private functions. Helpers

private extension Endpoint {
	
	func idsJoined(_ ids: [Int]) -> String {
		"/" + ids.map { String($0) }.joined(separator: ",")
	}
}
