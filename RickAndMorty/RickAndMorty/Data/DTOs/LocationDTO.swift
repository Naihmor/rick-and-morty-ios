// 
//  LocationDTO.swift
//  RickAndMorty
//
//  Created by Javier Fernández Martínez on 13/10/25.
//  Copyright © 2025 Naihmor Apps. All rights reserved.
//
//  This code is the property of Naihmor Apps. Unauthorized distribution, 
//  modification, or use of this code, in whole or in part, is strictly prohibited.
//

import Foundation

struct LocationDTO: Decodable {
	let id: Int
	let name: String
	let type: String
	let dimension: String
	let residents: [String]
	let url: String
	let created: Date
}

// MARK: - Mapper

extension LocationDTO {
	
	func toDomain() -> Location {
		Location(
			id: id,
			name: name,
			type: type,
			dimension: dimension,
			residents: residents.map { URL(string: $0) },
			url: URL(string: url),
			created: created
		)
	}
}
