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
    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case name
//        case airDate = "air_date"
//        case episode
//        case characters
//        case url
//        case created
//    }
//    
//    init(from decoder: any Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try container.decode(Int.self, forKey: .id)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.airDate = try container.decode(String.self, forKey: .airDate)
//        self.episode = try container.decode(String.self, forKey: .episode)
//        self.characters = try container.decode([String].self, forKey: .characters)
//        self.url = try container.decode(String.self, forKey: .url)
//        self.created = try container.decode(Date.self, forKey: .created)
//        print("[\(self.id)]: \(self.name)")
//    }
}
