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

/// A repository responsible for managing character data retrieval and mapping.
///
/// This repository acts as a bridge between the domain layer use cases and the data API client,
/// encapsulating the details of fetching character data and transforming it into domain models.
/// It provides an abstraction over the underlying API client, ensuring separation of concerns
/// and promoting testability and maintainability.
actor CharactersRepository: CharactersRepositoryProtocol, Sendable {
    
    /// The API client used to fetch character data from the remote source.
    /// This client handles the network requests and raw data retrieval.
    private let api: APIClientProtocol
    
    /// Initializes a new instance of `CharactersRepository` with the specified API client.
    ///
    /// - Parameter api: The API client responsible for fetching character data.
    init(api: APIClientProtocol) {
        self.api = api
    }
    
    /// Retrieves an array of characters filtered by the specified criteria.
    ///
    /// The filter parameter allows for flexible querying of characters based on various attributes.
    /// The method performs asynchronously and may throw an error if the data fetch fails.
    ///
    /// - Returns: An array of `Character` objects matching the filter criteria.
    /// - Throws: An error if the retrieval operation fails.
    func getCharacters(by filter: CharactersFilter? = nil) async throws -> [Character] {
        let page = try await api.fetchCharacters(filter: filter)
        return await CharacterMapper.map(from: page.results)
    }
    
    /// Retrieves multiple characters by their unique identifiers.
    ///
    /// This method fetches an array of characters corresponding to the provided list of IDs.
    /// It performs asynchronously and may throw an error if the fetch operation encounters issues.
    ///
    /// - Returns: An array of `Character` objects corresponding to the specified IDs.
    /// - Throws: An error if the retrieval operation fails.
    func getCharacters(by ids: [Int]) async throws -> [Character] {
        let dtos = try await api.fetchCharacters(ids: ids)
        return await CharacterMapper.map(from: dtos)
    }
    
    /// Retrieves a single character by its unique identifier.
    ///
    /// This method fetches the character matching the given ID asynchronously.
    /// It throws an error if the character cannot be found or if the fetch operation fails.
    ///
    /// - Returns: The `Character` object with the specified ID.
    /// - Throws: An error if the character is not found or the retrieval operation fails.
    func getCharacter(by id: Int) async throws -> Character {
        let dto = try await api.fetchCharacter(id: id)
        return await CharacterMapper.map(from: dto)
    }
}
