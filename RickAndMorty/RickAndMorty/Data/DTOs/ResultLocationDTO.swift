// 
//  ResultLocationDTO.swift
//  RickAndMorty
//
//  Created by Javier Fernández Martínez on 15/10/25.
//  Copyright © 2025 Naihmor Apps. All rights reserved.
//
//  This code is the property of Naihmor Apps. Unauthorized distribution, 
//  modification, or use of this code, in whole or in part, is strictly prohibited.
//

import Foundation

struct ResultLocationDTO: APIResult, Decodable {
    let info: InfoDTO
    let results: [LocationDTO]
}
