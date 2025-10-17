// 
//  AppDependencies.swift
//  RickAndMorty
//
//  Created by Javier Fernández Martínez on 17/10/25.
//  Copyright © 2025 Naihmor Apps. All rights reserved.
//
//  This code is the property of Naihmor Apps. Unauthorized distribution, 
//  modification, or use of this code, in whole or in part, is strictly prohibited.
//

import Foundation
import SwiftUI

struct AppDependencies {
    
    let repositories: Repositories
    let useCases: UseCases
}

// MARK: - Repositories

extension AppDependencies {
    
    struct Repositories {
        let characters: CharactersRepository
        let locations: LocationsRepository
        let episodes: EpisodesRepository
    }
}

// MARK: - Use cases

extension AppDependencies {
    
    struct UseCases {
        
        let characters: CharactersUseCases
        let episodes: EpisodeUseCases
    }
}

// MARK: - Preview

extension AppDependencies {
    
    static var preview: AppDependencies {
        let api = APIClient()
        let charactersRepository = CharactersRepository(api: api)
        let locationsRepository = LocationsRepository(api: api)
        let episodesRepository = EpisodesRepository(api: api)
        let charactersUseCases = CharactersUseCases(repository: charactersRepository)
        let episodesUseCases = EpisodeUseCases(repository: episodesRepository)
        return AppDependencies(
            repositories: .init(
                characters: charactersRepository,
                locations: locationsRepository,
                episodes: episodesRepository),
            useCases: .init(
                characters: charactersUseCases,
                episodes: episodesUseCases))
    }
}

// MARK: - EnvironmentValue

extension EnvironmentValues {
    
    @Entry var dependencies = AppDependencies.preview
    
    var repositories: AppDependencies.Repositories { dependencies.repositories }
    var useCases: AppDependencies.UseCases { dependencies.useCases }
}
