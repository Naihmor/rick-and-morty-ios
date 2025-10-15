// 
//  APIClient.swift
//  RickAndMorty
//
//  Created by Javier Fernández Martínez on 13/10/25.
//  Copyright © 2025 Naihmor Apps. All rights reserved.
//
//  This code is the property of Naihmor Apps. Unauthorized distribution, 
//  modification, or use of this code, in whole or in part, is strictly prohibited.
//

import Foundation

struct APIClient: APIClientProtocol {
	
	private let http: HTTPClientProtocol
	
	init(http: HTTPClientProtocol = HTTPClient()) {
		self.http = http
	}
}

// MARK: - Characters

extension APIClient {
	
	func fetchCharacters(filter: CharactersFilter? = nil) async throws -> ResultCharacterDTO {
		try await http.request(.getAllCharacters(filter))
	}
	
	func fetchCharacter(id: Int) async throws -> CharacterDTO {
		try await http.request(.getCharacter(id))
	}
	
	func fetchCharacters(ids: [Int]) async throws -> [CharacterDTO] {
		try await http.request(.getMultipleCharacters(ids))
	}
}

// MARK: - Locations

extension APIClient {
	
	func fetchLocations(filter: LocationsFilter?) async throws -> ResultDTO<LocationDTO> {
		try await http.request(.getAllLocations(filter))
	}
	
	func fetchLocations(ids: [Int]) async throws -> [LocationDTO] {
		try await http.request(.getMultipleLocations(ids))
	}
	
	func fetchLocation(id: Int) async throws -> LocationDTO {
		try await http.request(.getLocation(id))
	}
}

// MARK: - Episodes

extension APIClient {
	
	func fetchEpisodes(filter: EpisodesFilter?) async throws -> ResultDTO<EpisodeDTO> {
		try await http.request(.getAllEpisodes(filter))
	}
	
	func fetchEpisodes(ids: [Int]) async throws -> [EpisodeDTO] {
		try await http.request(.getMultipleEpisodes(ids))
	}
	
	func fetchEpisode(id: Int) async throws -> EpisodeDTO {
		try await http.request(.getEpisode(id))
	}
}
