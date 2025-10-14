// 
//  CharacterMapper.swift
//  RickAndMorty
//
//  Created by Javier Fernández Martínez on 14/10/25.
//  Copyright © 2025 Naihmor Apps. All rights reserved.
//
//  This code is the property of Naihmor Apps. Unauthorized distribution, 
//  modification, or use of this code, in whole or in part, is strictly prohibited.
//

import Foundation

enum CharacterMapper {
    
    static func map(from dto: CharacterDTO) -> Character {
        Character(
            id: dto.id,
            name: dto.name,
            status: Character.Status(rawValue: dto.status) ?? .unknown,
            species: dto.species,
            type: dto.type,
            gender: Character.Gender(rawValue: dto.gender) ?? .unknown,
            origin: .init(name: dto.origin.name, url: dto.origin.url),
            location: .init(name: dto.location.name, url: dto.location.url),
            image: URL(string: dto.image),
            episode: dto.episode.map { URL(string: $0) },
            url: URL(string: dto.url),
            created: dto.created
        )
    }
    
    static func map(from dtos: [CharacterDTO]) -> [Character] {
        dtos.map { map(from: $0) }
    }
}
