//
//  NetworkingClient.swift
//  MobileTakeHome
//
//  Created by Kawyn Furstoss on 9/4/24.
//

import Foundation
import Dependencies

struct NetworkingClient {
    var send: (_ request: APIEndpoint, _ responseType: any Decodable.Type) async throws -> any Decodable
}

extension NetworkingClient: DependencyKey {
    static var liveValue = Self(
        send: { request, responseType in
            var urlRequest = URLRequest(url: request.url)
            urlRequest.httpMethod = request.method
            if let headers = request.headers {
                for (key, value) in headers {
                    urlRequest.addValue(value, forHTTPHeaderField: key)
                }
            }
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw NetworkingError.invalidResponse
            }
            do {
                return try JSONDecoder().decode(responseType.self, from: data)
            } catch {
                throw NetworkingError.decodingFailed
            }
        }
    )
    static var testValue: NetworkingClient = Self(
        send: unimplemented("NetworkingClient.send")
    )
}

extension DependencyValues {
  var networkingClient: NetworkingClient {
    get { self[NetworkingClient.self] }
    set { self[NetworkingClient.self] = newValue }
  }
}
