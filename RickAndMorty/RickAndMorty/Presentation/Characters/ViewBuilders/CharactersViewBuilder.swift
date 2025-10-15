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

    static func makeList() -> CharactersView {
        let api = APIClient()
        let repository = CharactersRepository(api: api)
        let useCases = CharactersUseCases(repository: repository)
        let viewModel = CharactersViewModel(useCases: useCases)
        return CharactersView(viewModel: viewModel)
    }
}
