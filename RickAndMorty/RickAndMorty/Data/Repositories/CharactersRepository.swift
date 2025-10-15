// 
//  CharactersRepository.swift
//  RickAndMorty
//
//  Created by Javier Fernández Martínez on 13/10/25.
//  Copyright © 2025 Naihmor Apps. All rights reserved.
//
//  This code is the property of Naihmor Apps. Unauthorized distribution, 
//  modification, or use of this code, in whole or in part, is strictly prohibited.
//

import Foundation

actor CharactersRepository: CharactersRepositoryProtocol, Sendable {
	
	private let api: APIClientProtocol
	
    init(api: APIClientProtocol) {
		self.api = api
	}
	
	func getCharacters(by filter: CharactersFilter? = nil) async throws -> [Character] {
		let page = try await api.fetchCharacters(filter: filter)
        return await CharacterMapper.map(from: page.results)
	}
	
	func getCharacters(by ids: [Int]) async throws -> [Character] {
        let dtos = try await api.fetchCharacters(ids: ids)
        return await CharacterMapper.map(from: dtos)
	}
	
	func getCharacter(by id: Int) async throws -> Character {
		let dto = try await api.fetchCharacter(id: id)
        return await CharacterMapper.map(from: dto)
	}
}

