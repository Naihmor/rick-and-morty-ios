// 
//  Episode.swift
//  RickAndMorty
//
//  Created by Javier Fernández Martínez on 13/10/25.
//  Copyright © 2025 Naihmor Apps. All rights reserved.
//
//  This code is the property of Naihmor Apps. Unauthorized distribution, 
//  modification, or use of this code, in whole or in part, is strictly prohibited.
//

import Foundation

struct Episode: Identifiable, Hashable {
	let id: Int
	let name: String
	let airDate: String
	let episode: String
	let characters: [URL?]
	let url: URL?
	let created: Date
}
