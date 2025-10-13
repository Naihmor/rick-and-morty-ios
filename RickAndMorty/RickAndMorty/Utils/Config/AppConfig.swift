// 
//  AppConfig.swift
//  RickAndMorty
//
//  Created by Javier Fernández Martínez on 13/10/25.
//  Copyright © 2025 Naihmor Apps. All rights reserved.
//
//  This code is the property of Naihmor Apps. Unauthorized distribution, 
//  modification, or use of this code, in whole or in part, is strictly prohibited.
//

import Foundation

/// Centralized, app-wide configuration and tunables.
/// Keep this file free of business logic.
enum AppConfig {
	
	/// Current environment. (.prod for the review)
	static let environment: AppEnvironment = .prod
	
	/// API base host.
	static let apiBaseURL: URL = URL(string: "https://rickandmortyapi.com")!
	
	/// Root path for the REST API.
	static let apiRootPath: String = "/api"
	
	/// Per-request timeout. Keep small to surface network issues quickly.
	static let requestTimeout: TimeInterval = 20
	
	/// Overall resource timeout (downloads). Larger than request timeout to allow image transfers.
	static let resourceTimeout: TimeInterval = 60
	
	/// Memory capacity for URLCache (responses), ~32 MB.
	static let urlCacheMemoryCapacity: Int = 32 * 1024 * 1024
	
	/// Disk capacity for URLCache (responses), ~256 MB.
	static let urlCacheDiskCapacity: Int = 256 * 1024 * 1024
	
	/// Shared URLCache instance used by our URLSession configuration.
	static let urlCache: URLCache = {
		URLCache(memoryCapacity: urlCacheMemoryCapacity, diskCapacity: urlCacheDiskCapacity)
	}()
}

// MARK: - URLSession Configuration

extension AppConfig {
	
	/// Creates a preconfigured `URLSessionConfiguration` for API traffic.
	/// - Returns: A `URLSessionConfiguration` using `URLCache`, timeouts and default HTTP headers.
	static func makeURLSessionConfiguration() -> URLSessionConfiguration {
		let config = URLSessionConfiguration.default
		config.timeoutIntervalForRequest = requestTimeout
		config.timeoutIntervalForResource = resourceTimeout
		config.urlCache = urlCache
		config.requestCachePolicy = .useProtocolCachePolicy
		config.httpAdditionalHeaders = ["Accept": "application/json"]
		return config
	}
}
