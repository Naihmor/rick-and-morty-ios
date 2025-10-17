// 
//  RickAndMortyApp.swift
//  RickAndMorty
//
//  Created by Javier Fernández Martínez on 13/10/25.
//  Copyright © 2025 Naihmor Apps. All rights reserved.
//
//  This code is the property of Naihmor Apps. Unauthorized distribution, 
//  modification, or use of this code, in whole or in part, is strictly prohibited.
//

import SwiftUI

@main
struct RickAndMortyApp: App {
    
    private var dependencies: AppDependencies
    
    init() {
        let api = APIClient()
        let charactersRepository = CharactersRepository(api: api)
        let locationsRepository = LocationsRepository(api: api)
        let episodesRepository = EpisodesRepository(api: api)
        let charactersUseCases = CharactersUseCases(repository: charactersRepository)
        let episodesUseCases = EpisodeUseCases(repository: episodesRepository)
        self.dependencies = AppDependencies(
            repositories: .init(
                characters: charactersRepository,
                locations: locationsRepository,
                episodes: episodesRepository),
            useCases: .init(
                characters: charactersUseCases,
                episodes: episodesUseCases))
    }
    
    var body: some Scene {
        WindowGroup {
            CharactersViewBuilder.makeList(
                useCases: dependencies.useCases.characters
            )
            .environment(\.dependencies, dependencies)
            .preferredColorScheme(.dark)
        }
    }
}
