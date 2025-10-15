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
    
//    enum CodingKeys: CodingKey {
//        case id
//        case name
//        case status
//        case species
//        case type
//        case gender
//        case origin
//        case location
//        case image
//        case episode
//        case url
//        case created
//    }
//    
//    init(from decoder: any Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try container.decode(Int.self, forKey: .id)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.status = try container.decode(String.self, forKey: .status)
//        self.species = try container.decode(String.self, forKey: .species)
//        self.type = try container.decode(String.self, forKey: .type)
//        self.gender = try container.decode(String.self, forKey: .gender)
//        self.origin = try container.decode(ItemDTO.self, forKey: .origin)
//        self.location = try container.decode(ItemDTO.self, forKey: .location)
//        self.image = try container.decode(String.self, forKey: .image)
//        self.episode = try container.decode([String].self, forKey: .episode)
//        self.url = try container.decode(String.self, forKey: .url)
//        self.created = try container.decode(Date.self, forKey: .created)
////        print("[\(self.id)]: \(self.name)")
//    }
}
