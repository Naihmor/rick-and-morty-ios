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
    
    static func map(from result: ResultEpisodeDTO) -> Result<Episode> {
        var next: URL? = nil
        var prev: URL? = nil
        if let nextString = result.info.next { next = URL(string: nextString) }
        if let prevString = result.info.next { prev = URL(string: prevString) }
        return Result(
            info: .init(
                count: result.info.count,
                pages: result.info.pages,
                next: next,
                prev: prev
            ),
            result: map(from: result.results)
        )
    }
    
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
