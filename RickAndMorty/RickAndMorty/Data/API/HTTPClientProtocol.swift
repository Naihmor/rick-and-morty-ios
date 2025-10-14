// 
//  HTTPClientProtocol.swift
//  RickAndMorty
//
//  Created by Javier Fernández Martínez on 13/10/25.
//  Copyright © 2025 Naihmor Apps. All rights reserved.
//
//  This code is the property of Naihmor Apps. Unauthorized distribution, 
//  modification, or use of this code, in whole or in part, is strictly prohibited.
//

import Foundation

/// Defines the interface for performing HTTP requests in a testable and dependency-injected way.
///
/// Concrete implementations (e.g., `DefaultHTTPClient`) should:
/// - Use `URLSession` with `AppConfig.makeURLSessionConfiguration()`.
/// - Handle JSON decoding generically via `Decodable`.
/// - Surface `HTTPError` instead of raw `URLError` or decoding errors.
protocol HTTPClientProtocol {
	
	/// Performs a request against a given endpoint and decodes the response body.
	///
	/// - Parameters:
	///   - endpoint: The `Endpoint` defining path and query items.
	///   - type: The expected response model conforming to `Decodable`.
	/// - Returns: A decoded model instance of the given type.
	/// - Throws: `HTTPError` if the request fails, the decoding fails, or the server returns an error.
	func request<T>(_ endpoint: Endpoint) async throws -> T where T : Decodable
}
