// 
//  LocationMapper.swift
//  RickAndMorty
//
//  Created by Javier Fernández Martínez on 15/10/25.
//  Copyright © 2025 Naihmor Apps. All rights reserved.
//
//  This code is the property of Naihmor Apps. Unauthorized distribution, 
//  modification, or use of this code, in whole or in part, is strictly prohibited.
//

import Foundation

enum LocationMapper {
    
    static func map(from dto: LocationDTO) -> Location {
        Location(
            id: dto.id,
            name: dto.name,
            type: dto.type,
            dimension: dto.dimension,
            residents: dto.residents.map { URL(string: $0) },
            url: URL(string: dto.url),
            created: dto.created
        )
    }
    
    static func map(from dtos: [LocationDTO]) -> [Location] {
        dtos.map { map(from: $0) }
    }
}
