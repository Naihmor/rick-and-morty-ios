// 
//  EpisodesRepository.swift
//  RickAndMorty
//
//  Created by Javier Fernández Martínez on 15/10/25.
//  Copyright © 2025 Naihmor Apps. All rights reserved.
//
//  This code is the property of Naihmor Apps. Unauthorized distribution, 
//  modification, or use of this code, in whole or in part, is strictly prohibited.
//

import Foundation

actor EpisodesRepository: EpisodesRepositoryProtocol {
    
    private let api: APIClientProtocol
    
    init(api: APIClientProtocol) {
        self.api = api
    }
    
    func getEpisodes(by filter: EpisodesFilter) async throws -> Result<Episode> {
        let page = try await api.fetchEpisodes(filter: filter)
        return await EpisodeMapper.map(from: page)
    }

    func getEpisodes(by ids: [Int]) async throws -> [Episode] {
        let dtos = try await api.fetchEpisodes(ids: ids)
        return await EpisodeMapper.map(from: dtos)
    }

    func getEpisode(by id: Int) async throws -> Episode {
        let dto = try await api.fetchEpisode(id: id)
        return await EpisodeMapper.map(from: dto)
    }
}
