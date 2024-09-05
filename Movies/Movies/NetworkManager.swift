//
//  NetworkManager.swift
//  Movies
//
//  Created by Kamil Czajka on 05/09/2024.
//

import Foundation

protocol NetworkManagerType {
    func request<T: Decodable>(_ request: URLRequest, of type: T.Type) async throws -> T
}

class NetworkManager: NetworkManagerType {
    private let urlSession: URLSession
    private let decoder: JSONDecoder
    
    init(
        urlSession: URLSession = URLSession.shared,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.urlSession = urlSession
        self.decoder = decoder
    }
    
    func request<T: Decodable>(_ request: URLRequest, of type: T.Type) async throws -> T {
        let (data, _) = try await urlSession.data(for: request)
        let decodedData = try decoder.decode(T.self, from: data)
        return decodedData
    }
}
