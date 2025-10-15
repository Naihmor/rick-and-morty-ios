// 
//  EpisodeMapper.swift
//  RickAndMorty
//
//  Created by Javier Fernández Martínez on 15/10/25.
//  Copyright © 2025 Naihmor Apps. All rights reserved.
//
//  This code is the property of Naihmor Apps. Unauthorized distribution, 
//  modification, or use of this code, in whole or in part, is strictly prohibited.
//

import Foundation

enum EpisodeMapper {
    
    static func map(from dto: EpisodeDTO) -> Episode {
        Episode(
            id: dto.id,
            name: dto.name,
            airDate: dto.airDate,
            episode: dto.episode,
            characters: dto.characters.map { URL(string: $0) },
            url: URL(string: dto.url),
            created: dto.created
        )
    }
    
    static func map(from dtos: [EpisodeDTO]) -> [Episode] {
        dtos.map { map(from: $0) }
    }
}
