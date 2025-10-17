// 
//  CharactersViewBuilder.swift
//  RickAndMorty
//
//  Created by Javier Fernández Martínez on 15/10/25.
//  Copyright © 2025 Naihmor Apps. All rights reserved.
//
//  This code is the property of Naihmor Apps. Unauthorized distribution, 
//  modification, or use of this code, in whole or in part, is strictly prohibited.
//

import Foundation

struct CharactersViewBuilder {

    static func makeList(useCases: CharactersUseCases) -> CharactersView {
        let viewModel = CharactersViewModel(useCases: useCases)
        return CharactersView(viewModel: viewModel)
    }
    
    static func makeDetail(for character: Character, useCases: EpisodeUseCases) -> CharacterView {
        let viewModel = CharacterViewModel(character: character, useCases: useCases)
        return CharacterView(viewModel: viewModel)
    }
}
