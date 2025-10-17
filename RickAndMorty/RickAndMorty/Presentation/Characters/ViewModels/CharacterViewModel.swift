//
//  CharacterViewModel.swift
//  RickAndMorty
//
//  Created by Javier Fernández Martínez on 16/10/25.
//  Copyright © 2025 Naihmor Apps. All rights reserved.
//
//  This code is the property of Naihmor Apps. Unauthorized distribution,
//  modification, or use of this code, in whole or in part, is strictly prohibited.
//

import Foundation
import Observation

/// ViewModel that powers `CharacterView`.
///
/// Responsibilities
/// - Exposes the selected `Character`.
/// - Manages UI state for the Episodes block (expanded state, loading, error).
/// - Orchestrates fetching all episode appearances of the character using `EpisodeUseCases`.
/// - Surfaces the resulting `[Episode]` directly to the view (no view-specific adapter type).
///
/// Notes
/// - The project defaults to `MainActor` isolation. This type is designed to be called from UI.
@Observable
final class CharacterViewModel {
    
    /// Aggregated episodes-related use cases (injected for extensibility/testing).
    private let useCases: EpisodeUseCases
    
    /// Loading flag for the episodes fetch operation.
    private(set) var isLoadingEpisodes: Bool = false
    
    /// Error message (if any) while loading episodes.
    private(set) var episodesErrorMessage: String? = nil
    
    /// Selected character displayed by the view.
    let character: Character
    
    /// Controls the disclosure of the Episodes section.
    var isEpisodesExpanded: Bool = false
    
    /// Episodes where this character appears. Exposed directly for rendering.
    var episodes: [Episode] = []
    
    /// Creates a new instance of `CharacterViewModel`.
    /// - Parameters:
    ///   - character: The character to display and fetch episodes for.
    ///   - useCases: The container of episode-related use cases.
    init(character: Character, useCases: EpisodeUseCases) {
        self.character = character
        self.useCases = useCases
    }
}

// MARK: - Public functions

extension CharacterViewModel {
    
    /// Handles the tap on “View all episode appearances”.
    ///
    /// Behavior
    /// - Expands the Episodes section.
    /// - Triggers a lazy load if episodes haven't been loaded yet.
    func onTapViewAllEpisodes() {
        isEpisodesExpanded.toggle()
        Task { await loadEpisodesIfNeeded() }
    }
    
    /// Forces a manual reload of the episodes list.
    ///
    /// Behavior
    /// - Clears current episodes and error.
    /// - Triggers a fresh load regardless of previous state.
    func reloadEpisodes() {
        episodes.removeAll()
        episodesErrorMessage = nil
        Task { await loadEpisodesIfNeeded() }
    }
    
    /// Lazily loads episodes only if not already available and not loading.
    ///
    /// Behavior
    /// - Prevents re-entrant calls using `isLoadingEpisodes`.
    /// - Calls the hybrid episodes use case (`getEpisodesByCharacter`).
    /// - Updates state with the result or a user-friendly error message.
    func loadEpisodesIfNeeded() async {
        guard episodes.isEmpty, !isLoadingEpisodes else { return }
        isLoadingEpisodes = true
        episodesErrorMessage = nil
        defer { isLoadingEpisodes = false }
        do {
            let result = try await useCases.getEpisodesByCharacter.execute(for: character.episode)
            self.episodes = result
        } catch {
            self.episodes = []
            self.episodesErrorMessage = friendly(error)
        }
    }
}

// MARK: - Error Handling

private extension CharacterViewModel {
    
    /// Maps an error to a user-friendly message suitable for UI.
    func friendly(_ error: Error) -> String {
        if let http = error as? HTTPError {
            switch http {
            case .server(let code, _):  return "Server error (\(code)). Try again."
            case .network:              return "Network error. Check your connection."
            case .decoding:             return "Data error. Please try later."
            case .invalidURL, .unknown: return "Unexpected error. Try again."
            }
        }
        return "Something went wrong. Try again."
    }
}
