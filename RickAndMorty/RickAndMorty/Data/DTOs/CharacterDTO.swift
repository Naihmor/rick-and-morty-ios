// 
//  CharacterDTO.swift
//  RickAndMorty
//
//  Created by Javier Fernández Martínez on 13/10/25.
//  Copyright © 2025 Naihmor Apps. All rights reserved.
//
//  This code is the property of Naihmor Apps. Unauthorized distribution, 
//  modification, or use of this code, in whole or in part, is strictly prohibited.
//

import Foundation

struct CharacterDTO: Decodable {
	let id: Int
	let name: String
	let status: String
	let species: String
	let type: String
	let gender: String
	let origin: ItemDTO
	let location: ItemDTO
	let image: String
	let episode: [String]
	let url: String
	let created: Date
}
