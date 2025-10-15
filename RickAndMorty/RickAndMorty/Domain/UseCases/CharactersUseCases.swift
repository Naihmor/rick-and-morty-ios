// 
//  CharactersUseCases.swift
//  RickAndMorty
//
//  Created by Javier Fernández Martínez on 15/10/25.
//  Copyright © 2025 Naihmor Apps. All rights reserved.
//
//  This code is the property of Naihmor Apps. Unauthorized distribution, 
//  modification, or use of this code, in whole or in part, is strictly prohibited.
//

import Foundation

struct CharactersUseCases {
    let getCharacters: GetCharactersUseCase
    let getFilteredCharacters: GetFilteredCharactersUseCase
    let getMultipleCharacters: GetMultipleCharactersUseCase
    let getCharacter: GetCharacterUseCase
    init(repository: CharactersRepositoryProtocol) {
        self.getCharacters = .init(repository: repository)
        self.getFilteredCharacters = .init(repository: repository)
        self.getMultipleCharacters = .init(repository: repository)
        self.getCharacter = .init(repository: repository)
    }
}

struct GetCharactersUseCase {
    private let repository: CharactersRepositoryProtocol
    init(repository: CharactersRepositoryProtocol) { self.repository = repository }
    func execute() async throws -> [Character] {
        try await repository.getCharacters(by: nil)
    }
}

struct GetFilteredCharactersUseCase {
    private let repository: CharactersRepositoryProtocol
    init(repository: CharactersRepositoryProtocol) { self.repository = repository }
    func execute(by filter: CharactersFilter) async throws -> [Character] {
        try await repository.getCharacters(by: filter)
    }
}

struct GetMultipleCharactersUseCase {
    private let repository: CharactersRepositoryProtocol
    init(repository: CharactersRepositoryProtocol) { self.repository = repository }
    func execute(ids: [Int]) async throws -> [Character] {
        try await repository.getCharacters(by: ids)
    }
}

struct GetCharacterUseCase {
    private let repository: CharactersRepositoryProtocol
    init(repository: CharactersRepositoryProtocol) { self.repository = repository }
    func execute(id: Int) async throws -> Character {
        try await repository.getCharacter(by: id)
    }
}
