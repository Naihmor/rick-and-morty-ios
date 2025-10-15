// 
//  InfoDTO.swift
//  RickAndMorty
//
//  Created by Javier Fernández Martínez on 13/10/25.
//  Copyright © 2025 Naihmor Apps. All rights reserved.
//
//  This code is the property of Naihmor Apps. Unauthorized distribution, 
//  modification, or use of this code, in whole or in part, is strictly prohibited.
//

import Foundation

struct InfoDTO: Decodable {
	let count: Int
	let pages: Int
	let next: String?
	let prev: String?
    
//    enum CodingKeys: CodingKey {
//        case count
//        case pages
//        case next
//        case prev
//    }
//    
//    init(from decoder: any Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.count = try container.decode(Int.self, forKey: .count)
//        self.pages = try container.decode(Int.self, forKey: .pages)
//        self.next = try container.decodeIfPresent(String.self, forKey: .next)
//        self.prev = try container.decodeIfPresent(String.self, forKey: .prev)
//    }
}
