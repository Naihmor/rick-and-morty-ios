// 
//  Character.swift
//  RickAndMorty
//
//  Created by Javier Fernández Martínez on 13/10/25.
//  Copyright © 2025 Naihmor Apps. All rights reserved.
//
//  This code is the property of Naihmor Apps. Unauthorized distribution, 
//  modification, or use of this code, in whole or in part, is strictly prohibited.
//

import Foundation

struct Character: Identifiable {
	let id: Int
	let name: String
	let status: Status
	let species: String
	let type: String
	let gender: Gender
	let origin: Origin
	let location: Location
	let image: URL?
	let episode: [URL?]
	let url: URL?
	let created: Date
}

extension Character {
    
    static var mock: Character {
        Character(
            id: 2,
            name: "Morty Smith",
            status: .alive,
            species: "Human",
            type: "",
            gender: .male,
            origin: .init(name: "Earth", url: URL(string: "https://rickandmortyapi.com/api/location/1")!),
            location: .init(name: "Earth", url: URL(string: "https://rickandmortyapi.com/api/location/20")!),
            image: URL(string: "https://rickandmortyapi.com/api/character/avatar/2.jpeg")!,
            episode: [URL(string: "https://rickandmortyapi.com/api/episode/1")],
            url: URL(string: "https://rickandmortyapi.com/api/character/2")!,
            created: .now
        )
    }
}
