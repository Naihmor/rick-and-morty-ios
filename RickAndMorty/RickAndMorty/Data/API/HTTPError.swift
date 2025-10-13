// 
//  HTTPError.swift
//  RickAndMorty
//
//  Created by Javier Fernández Martínez on 13/10/25.
//  Copyright © 2025 Naihmor Apps. All rights reserved.
//
//  This code is the property of Naihmor Apps. Unauthorized distribution, 
//  modification, or use of this code, in whole or in part, is strictly prohibited.
//

import Foundation

/// Represents network-level errors for HTTP requests.
///
/// - `invalidURL`: The URL could not be formed or is malformed.
/// - `network`: A generic network connectivity issue occurred (e.g., no internet, timeout).
/// - `decoding`: The response body could not be decoded into the expected model.
/// - `server`: The server responded with a non-success status code (4xx/5xx).
/// - `unknown`: Any unexpected or unmapped error.
enum HTTPError: Error {
	case invalidURL
	case network(Error)
	case decoding(Error)
	case server(statusCode: Int, message: String?)
	case unknown
}
