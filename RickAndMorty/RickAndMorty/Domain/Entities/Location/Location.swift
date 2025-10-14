// 
//  Location.swift
//  RickAndMorty
//
//  Created by Javier Fernández Martínez on 13/10/25.
//  Copyright © 2025 Naihmor Apps. All rights reserved.
//
//  This code is the property of Naihmor Apps. Unauthorized distribution, 
//  modification, or use of this code, in whole or in part, is strictly prohibited.
//

import Foundation

struct Location: Identifiable, Hashable, Sendable {
	let id: Int
	let name: String
	let type: String
	let dimension: String
	let residents: [URL?]
	let url: URL?
	let created: Date
}
