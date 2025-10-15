// 
//  LocationsRepository.swift
//  RickAndMorty
//
//  Created by Javier Fernández Martínez on 15/10/25.
//  Copyright © 2025 Naihmor Apps. All rights reserved.
//
//  This code is the property of Naihmor Apps. Unauthorized distribution, 
//  modification, or use of this code, in whole or in part, is strictly prohibited.
//

import Foundation

actor LocationsRepository: LocationsRepositoryProtocol {
    
    private let api: APIClientProtocol
    
    init(api: APIClientProtocol) {
        self.api = api
    }
    
    func getLocations(by filter: LocationsFilter) async throws -> [Location] {
        let page = try await api.fetchLocations(filter: filter)
        return await LocationMapper.map(from: page.results)
    }

    func getLocations(by ids: [Int]) async throws -> [Location] {
        let dtos = try await api.fetchLocations(ids: ids)
        return await LocationMapper.map(from: dtos)
    }

    func getLocation(by id: Int) async throws -> Location {
        let dto = try await api.fetchLocation(id: id)
        return await LocationMapper.map(from: dto)
    }
}
