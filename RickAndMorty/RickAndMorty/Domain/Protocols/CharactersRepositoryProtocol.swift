// 
//  CharactersRepositoryProtocol.swift
//  RickAndMorty
//
//  Created by Javier Fernández Martínez on 13/10/25.
//  Copyright © 2025 Naihmor Apps. All rights reserved.
//
//  This code is the property of Naihmor Apps. Unauthorized distribution, 
//  modification, or use of this code, in whole or in part, is strictly prohibited.
//

import Foundation

protocol CharactersRepositoryProtocol: Sendable {
	
	func getCharacters(by filter: CharactersFilter) async throws -> [Character]
	
	func getCharacters(by ids: [Int]) async throws -> [Character]
	
	func getCharacter(by id: Int) async throws -> Character
}
