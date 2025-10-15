// 
//  CharactersViewModel.swift
//  RickAndMorty
//
//  Created by Javier Fernández Martínez on 15/10/25.
//  Copyright © 2025 Naihmor Apps. All rights reserved.
//
//  This code is the property of Naihmor Apps. Unauthorized distribution, 
//  modification, or use of this code, in whole or in part, is strictly prohibited.
//

import Foundation
import Observation

@Observable
final class CharactersViewModel {
    
    enum ViewState: Equatable {
        case loading
        case loaded
        case error(String)
    }
    
    private(set) var state: ViewState = .loading
    
    private(set) var filtered: [Character] = []
    
    private var characters: [Character] = []
    
    private let useCases: CharactersUseCases
    
    var searchText: String = "" {
        didSet { filter(by: searchText) }
    }
    
    init(useCases: CharactersUseCases) {
        self.useCases = useCases
    }
}

// MARK: - Public functions

extension CharactersViewModel {
    
    func load() async {
        do {
            state = .loading
            characters = try await useCases.getCharacters.execute()
            filter(by: "")
            state = .loaded
        } catch {
            state = .error(friendly(error))
        }
    }
    
    func refresh() async {
        guard !characters.isEmpty else { return }
        await load()
    }
}

// MARK: - Private functions

private extension CharactersViewModel {
    
    func filter(by text: String) {
        let query = text.trimmingCharacters(in: .whitespacesAndNewlines)
        if query.isEmpty {
            filtered = characters
        } else {
            let lower = query.lowercased()
            filtered = characters.filter { character in
                character.name.lowercased().contains(lower) ||
                character.species.lowercased().contains(lower) ||
                character.location.name.lowercased().contains(lower) ||
                character.origin.name.lowercased().contains(lower)
            }.sorted(by: { $0.id < $1.id })
        }
    }
    
    func friendly(_ error: Error) -> String {
        if let http = error as? HTTPError {
            switch http {
            case .server(let code, _): return "Server error (\(code)). Try again."
            case .network: return "Network error. Check your connection."
            case .decoding: return "Data error. Please try later."
            case .invalidURL, .unknown: return "Unexpected error. Try again."
            }
        }
        return "Something went wrong. Try again."
    }
}
