// 
//  APIClientProtocol.swift
//  RickAndMorty
//
//  Created by Javier Fernández Martínez on 13/10/25.
//  Copyright © 2025 Naihmor Apps. All rights reserved.
//
//  This code is the property of Naihmor Apps. Unauthorized distribution, 
//  modification, or use of this code, in whole or in part, is strictly prohibited.
//

import Foundation

protocol APIClientProtocol: Sendable {
	
	func fetchCharacters(filter: CharactersFilter?) async throws -> CharacterResultDTO
	
	func fetchCharacters(ids: [Int]) async throws -> [CharacterDTO]
	
	func fetchCharacter(id: Int) async throws -> CharacterDTO
	
	func fetchLocations(filter: LocationsFilter?) async throws -> ResultDTO<LocationDTO>
	
	func fetchLocations(ids: [Int]) async throws -> [LocationDTO]
	
	func fetchLocation(id: Int) async throws -> LocationDTO
	
	func fetchEpisodes(filter: EpisodesFilter?) async throws -> ResultDTO<EpisodeDTO>
	
	func fetchEpisodes(ids: [Int]) async throws -> [EpisodeDTO]
	
	func fetchEpisode(id: Int) async throws -> EpisodeDTO
}
