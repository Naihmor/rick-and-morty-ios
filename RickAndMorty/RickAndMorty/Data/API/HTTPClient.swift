//
//  HTTPClient.swift
//  RickAndMorty
//
//  Created by Javier Fernández Martínez on 13/10/25.
//  Copyright © 2025 Naihmor Apps. All rights reserved.
//
//  This code is the property of Naihmor Apps. Unauthorized distribution, 
//  modification, or use of this code, in whole or in part, is strictly prohibited.
//

import Foundation

/// Default, concrete implementation of `HTTPClientProtocol`.
///
/// Uses a shared `URLSession` configured through `AppConfig`.
final class HTTPClient: HTTPClientProtocol {
	
	private let session: URLSession
	
	/// Initializes a new client with an optional custom `URLSession`.
	/// - Parameter session: Allows injecting a mock `URLSession` for testing.
	init(session: URLSession = URLSession(configuration: AppConfig.makeURLSessionConfiguration())) {
		self.session = session
	}
	
	/// Performs a request using `URLSession`, decoding the response into the provided type.
	///
	/// This is a stub to be implemented in the next step.
	func request<T>(_ endpoint: Endpoint) async throws -> T where T : Decodable {
		let request = createGetRequest(from: endpoint.url())
		do {
			let (data, response) = try await session.data(for: request)
			guard let http = response as? HTTPURLResponse else { throw HTTPError.unknown }
			guard (200...299).contains(http.statusCode) else {
				throw HTTPError.server(statusCode: http.statusCode, message: try decodeJSONData(data: data))
			}
			return try decodeJSONData(data: data)
		} catch {
			throw HTTPError.unknown
		}
	}
}

private extension HTTPClient {
	
	func createGetRequest(from url: URL) -> URLRequest {
		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		request.setValue("application/json", forHTTPHeaderField: "Accept")
		return request
	}
	
	func decodeJSONData<T: Decodable>(data: Data) throws -> T {
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		decoder.dateDecodingStrategy = .iso8601
		do {
			return try decoder.decode(T.self, from: data)
		} catch {
			throw HTTPError.decoding(error)
		}
	}
}
