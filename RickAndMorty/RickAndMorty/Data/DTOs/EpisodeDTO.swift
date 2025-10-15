// 
//  EpisodeDTO.swift
//  RickAndMorty
//
//  Created by Javier Fernández Martínez on 13/10/25.
//  Copyright © 2025 Naihmor Apps. All rights reserved.
//
//  This code is the property of Naihmor Apps. Unauthorized distribution, 
//  modification, or use of this code, in whole or in part, is strictly prohibited.
//

import Foundation

struct EpisodeDTO: Decodable {
	let id: Int
	let name: String
	let airDate: String
	let episode: String
	let characters: [String]
	let url: String
	let created: Date
	
	enum CodingKeys: String, CodingKey {
		case id
		case name
		case airDate = "air_date"
		case episode
		case characters
		case url
		case created
	}
}
