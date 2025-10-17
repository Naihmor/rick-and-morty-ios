//
//  EpisodeUseCases.swift
//  RickAndMorty
//
//  Created by Javier Fernández Martínez on 16/10/25.
//  Copyright © 2025 Naihmor Apps. All rights reserved.
//
//  This code is the property of Naihmor Apps. Unauthorized distribution,
//  modification, or use of this code, in whole or in part, is strictly prohibited.
//

import Foundation

/// A namespace struct that aggregates all episode-related use cases.
///
/// This struct serves as a centralized access point for episode use cases,
/// simplifying dependency injection and improving code organization.
struct EpisodeUseCases {
    
    /// Use case responsible for fetching episodes associated with a given character.
    ///
    /// This use case is typically used when you need to retrieve all episodes in which a particular character appears.
    let getEpisodesByCharacter: GetEpisodesByCharacterUseCase
    
    /// Initializes the `EpisodeUseCases` with the provided episodes repository.
    ///
    /// - Parameter repository: An object conforming to `EpisodesRepositoryProtocol` used to fetch episode data.
    init(repository: EpisodesRepositoryProtocol) {
        self.getEpisodesByCharacter = .init(repository: repository)
    }
}

// MARK: - GetEpisodesByCharacterUseCase

/// A use case responsible for fetching all episodes associated with a specific character.
///
/// This use case implements a hybrid batching strategy to efficiently retrieve episode data.
/// It accepts a list of episode URLs, extracts their identifiers, and fetches episodes in concurrent batches.
/// The concurrency model leverages Swift's `withThrowingTaskGroup` to maximize performance while handling potential errors gracefully.
///
/// This approach balances network load and responsiveness by chunking requests into manageable sizes,
/// ensuring that the system remains performant and scalable when dealing with large numbers of episodes.
struct GetEpisodesByCharacterUseCase {
    
    /// The repository used to fetch episode data.
    let repository: EpisodesRepositoryProtocol
    
    /// Initializes the use case with the given episodes repository.
    ///
    /// - Parameter repository: An object conforming to `EpisodesRepositoryProtocol` responsible for data fetching.
    init(repository: EpisodesRepositoryProtocol) { self.repository = repository }
    
    /// Executes the use case to fetch episodes for a character.
    ///
    /// This function extracts episode IDs from the provided URLs, divides them into chunks of a specified size,
    /// and concurrently fetches each chunk using the repository. The results are combined, flattened,
    /// and sorted by episode ID before being returned.
    ///
    /// - Parameters:
    ///   - episodes: An array of `URL` objects representing the episodes associated with a character.
    ///   - chunkSize: The maximum number of episode IDs to fetch concurrently in each batch. Defaults to 10.
    /// - Returns: An array of `Episode` objects sorted by their identifier.
    /// - Throws: An error if any of the concurrent fetch operations fail.
    func execute(for episodes: [URL?], chunkSize: Int = 10) async throws -> [Episode] {
        let ids = episodes
            .compactMap { $0?.lastPathComponent }
            .compactMap(Int.init)
        return try await repository.getEpisodes(by: ids)
//        let chunks = ids.chunked(into: chunkSize)
//        let results: [[Episode]] = try await withThrowingTaskGroup(of: [Episode].self) { group in
//            for chunk in chunks {
//                group.addTask { try await repository.getEpisodes(by: chunk) }
//            }
//            return try await group.reduce(into: []) { $0.append($1) }
//        }
//        return results
//            .flatMap { $0 }
//            .sorted(by: { $0.id < $1.id })
    }
}
