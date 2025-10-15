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

/// This file defines the `CharactersRepositoryProtocol`, which acts as a bridge between the Domain and Data layers,
/// providing an abstraction for retrieving character data within the RickAndMorty app.

/// An abstraction that defines the responsibilities for fetching character data.
///
/// This protocol serves as the contract for any repository responsible for retrieving character information,
/// either from a remote source, local cache, or any other data source. It is designed to be used in an asynchronous
/// context and supports concurrency safety via the `Sendable` protocol. Implementations should be marked with `@MainActor`
/// when UI updates or main thread operations are involved.
protocol CharactersRepositoryProtocol: Sendable {
    
    /// Retrieves an array of characters filtered by the specified criteria.
    ///
    /// The filter parameter allows for flexible querying of characters based on various attributes.
    /// The method performs asynchronously and may throw an error if the data fetch fails.
    ///
    /// - Returns: An array of `Character` objects matching the filter criteria.
    /// - Throws: An error if the retrieval operation fails.
    func getCharacters(by filter: CharactersFilter?) async throws -> [Character]
    
    /// Retrieves multiple characters by their unique identifiers.
    ///
    /// This method fetches an array of characters corresponding to the provided list of IDs.
    /// It performs asynchronously and may throw an error if the fetch operation encounters issues.
    ///
    /// - Returns: An array of `Character` objects corresponding to the specified IDs.
    /// - Throws: An error if the retrieval operation fails.
    func getCharacters(by ids: [Int]) async throws -> [Character]
    
    /// Retrieves a single character by its unique identifier.
    ///
    /// This method fetches the character matching the given ID asynchronously.
    /// It throws an error if the character cannot be found or if the fetch operation fails.
    ///
    /// - Returns: The `Character` object with the specified ID.
    /// - Throws: An error if the character is not found or the retrieval operation fails.
    func getCharacter(by id: Int) async throws -> Character
}
