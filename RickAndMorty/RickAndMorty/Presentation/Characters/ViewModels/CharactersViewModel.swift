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
    
    private var info: Info = Info(count: 0, pages: 0, next: nil, prev: nil)
    
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
            let result = try await useCases.getCharacters.execute()
            info = result.info
            characters = result.result
            filter(by: searchText)
            state = .loaded
        } catch {
            state = .error(friendly(error))
        }
    }
    
    func refresh() async {
        guard !characters.isEmpty else { return }
        await load()
    }
    
    func nextPage() async {
        guard let next = info.next
        else {
            state = .error(friendly(FetchError.noNextPage))
            return
        }
        do {
            let result = try await useCases.getCharactersPage.execute(url: next)
            info = result.info
            mergeUniqueSorted(new: result.result)
            filter(by: "")
        } catch {
            state = .error(friendly(error))
        }
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
            }/*.sorted(by: { $0.id < $1.id })*/
        }
    }
    
    private func mergeUniqueSorted(new: [Character]) {
        var seen = Set(characters.map(\.id))
        var merged = characters
        merged.reserveCapacity(characters.count + new.count)
        for c in new {
            if seen.insert(c.id).inserted {
                merged.append(c)
            }
        }
        merged.sort { $0.id < $1.id }
        characters = merged
    }
    
    func friendly(_ error: Error) -> String {
        if let http = error as? HTTPError {
            switch http {
            case .server(let code, _): return "Server error (\(code)). Try again."
            case .network: return "Network error. Check your connection."
            case .decoding: return "Data error. Please try later."
            case .invalidURL, .unknown: return "Unexpected error. Try again."
            }
        } else if let fetchError = error as? FetchError {
            switch fetchError {
            case .noNextPage: return "No more characters to load."
            case .noPrevPage: return "Cannot go back further."
            }
        }
        return "Something went wrong. Try again."
    }
}

// MARK: - Errors

private extension CharactersViewModel {
    
    enum FetchError: Error {
        case noNextPage
        case noPrevPage
    }
}
