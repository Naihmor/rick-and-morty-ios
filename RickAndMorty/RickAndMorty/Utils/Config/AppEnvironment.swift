// 
//  AppEnvironment.swift
//  RickAndMorty
//
//  Created by Javier Fernández Martínez on 13/10/25.
//  Copyright © 2025 Naihmor Apps. All rights reserved.
//
//  This code is the property of Naihmor Apps. Unauthorized distribution, 
//  modification, or use of this code, in whole or in part, is strictly prohibited.
//

import Foundation

/// High-level environment flags for toggling base behavior if needed.
enum AppEnvironment: String {
	case dev
	case staging
	case prod
}
