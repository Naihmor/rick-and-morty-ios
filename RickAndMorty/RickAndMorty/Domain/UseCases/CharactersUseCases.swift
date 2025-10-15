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

/// Contains use cases related to character retrieval and filtering for the RickAndMorty app.
///
/// This struct serves as a centralized entry point for all character-related use cases.
/// It provides UI-friendly interfaces to fetch characters, filtered characters, multiple characters,
/// and individual characters. This project uses MainActor isolation by default,
/// so these use cases are designed to be safely invoked from the UI layer.
struct CharactersUseCases {
    
    /// Use case for retrieving all characters without any filters.
    let getCharacters: GetCharactersUseCase
    
    /// Use case for retrieving characters filtered by specific criteria.
    let getFilteredCharacters: GetFilteredCharactersUseCase
    
    /// Use case for retrieving multiple characters by their identifiers.
    let getMultipleCharacters: GetMultipleCharactersUseCase
    
    /// Use case for retrieving a single character by its identifier.
    let getCharacter: GetCharacterUseCase
    
    /// Initializes all character-related use cases with the provided repository.
    ///
    /// The repository is responsible for data fetching and persistence.
    /// This initializer creates UI-friendly use cases that interact with the repository.
    ///
    /// - Parameter repository: An object conforming to `CharactersRepositoryProtocol` used to fetch character data.
    init(repository: CharactersRepositoryProtocol) {
        self.getCharacters = .init(repository: repository)
        self.getFilteredCharacters = .init(repository: repository)
        self.getMultipleCharacters = .init(repository: repository)
        self.getCharacter = .init(repository: repository)
    }
}

// MARK: - GetCharactersUseCase

/// Use case responsible for retrieving all characters without any filtering.
///
/// This use case provides a simple interface to fetch the complete list of characters.
/// It abstracts the underlying data source and exposes an asynchronous method to retrieve data.
/// Designed to be called from the UI layer, respecting MainActor isolation.
struct GetCharactersUseCase {
    
    /// The repository used to fetch character data.
    private let repository: CharactersRepositoryProtocol
    
    /// Creates a new instance of `GetCharactersUseCase` with the specified repository.
    ///
    /// - Parameter repository: The repository responsible for character data retrieval.
    init(repository: CharactersRepositoryProtocol) { self.repository = repository }
    
    /// Executes the use case to fetch all characters.
    ///
    /// This asynchronous method fetches all characters without applying any filters.
    ///
    /// - Returns: An array of `Character` objects representing all characters.
    /// - Throws: An error if the data retrieval fails.
    func execute() async throws -> [Character] {
        try await repository.getCharacters(by: nil)
    }
}

// MARK: - GetFilteredCharactersUseCase

/// Use case responsible for retrieving characters filtered by specified criteria.
///
/// This use case allows fetching a subset of characters based on filter parameters.
/// It abstracts the filtering logic and provides an asynchronous interface suitable for UI usage.
/// MainActor isolation is respected by design.
struct GetFilteredCharactersUseCase {
    
    /// The repository used to fetch character data.
    private let repository: CharactersRepositoryProtocol
    
    /// Initializes the use case with the given repository.
    ///
    /// - Parameter repository: The repository responsible for character data retrieval.
    init(repository: CharactersRepositoryProtocol) { self.repository = repository }
    
    /// Executes the use case to fetch characters matching the provided filter.
    ///
    /// - Parameter filter: A `CharactersFilter` object defining the filtering criteria.
    /// - Returns: An array of `Character` objects that satisfy the filter conditions.
    /// - Throws: An error if the data retrieval or filtering process fails.
    func execute(by filter: CharactersFilter) async throws -> [Character] {
        try await repository.getCharacters(by: filter)
    }
}

// MARK: - GetMultipleCharactersUseCase

/// Use case responsible for retrieving multiple characters by their identifiers.
///
/// This use case provides a convenient way to fetch multiple characters in a single call,
/// optimizing network or database operations. It is designed for UI consumption with async support.
struct GetMultipleCharactersUseCase {
    
    /// The repository used to fetch character data.
    private let repository: CharactersRepositoryProtocol
    
    /// Initializes the use case with the specified repository.
    ///
    /// - Parameter repository: The repository responsible for character data retrieval.
    init(repository: CharactersRepositoryProtocol) { self.repository = repository }
    
    /// Executes the use case to fetch characters with the given identifiers.
    ///
    /// - Parameter ids: An array of integer identifiers representing the desired characters.
    /// - Returns: An array of `Character` objects matching the provided identifiers.
    /// - Throws: An error if the data retrieval fails.
    func execute(ids: [Int]) async throws -> [Character] {
        try await repository.getCharacters(by: ids)
    }
}

// MARK: - GetCharacterUseCase

/// Use case responsible for retrieving a single character by its identifier.
///
/// This use case provides a focused interface to fetch detailed information about a specific character.
/// It is designed to be called from the UI layer with async support and respects MainActor isolation.
struct GetCharacterUseCase {
    
    /// The repository used to fetch character data.
    private let repository: CharactersRepositoryProtocol
    
    /// Initializes the use case with the given repository.
    ///
    /// - Parameter repository: The repository responsible for character data retrieval.
    init(repository: CharactersRepositoryProtocol) { self.repository = repository }
    
    /// Executes the use case to fetch a character by its identifier.
    ///
    /// - Parameter id: The integer identifier of the character to retrieve.
    /// - Returns: A `Character` object corresponding to the specified identifier.
    /// - Throws: An error if the character cannot be found or data retrieval fails.
    func execute(id: Int) async throws -> Character {
        try await repository.getCharacter(by: id)
    }
}
