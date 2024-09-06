//
//  URLRequestBuilder.swift
//  Movies
//
//  Created by Kamil Czajka on 05/09/2024.
//

import Foundation
import Keys

enum HTTPMethod: String {
    case GET
}

enum RequestKind: RawRepresentable {
    case nowPlayingMovies
    case searchMovies
    case unknown
    
    var rawValue: String {
        switch self {
        case .nowPlayingMovies:
            return "/movie/now_playing"
            
        case .searchMovies:
            return "/search/movie"
            
        case .unknown:
            return ""
        }
    }
    
    init?(rawValue: String) {
        if rawValue == "/movie/now_playing" {
            self = .nowPlayingMovies
        } else if rawValue == "/search/movie" {
            self = .searchMovies
        } else {
            self = .unknown
        }
    }
}

protocol URLRequestBuilderType {
    func requestKind(_ kind: RequestKind) -> URLRequestBuilder
    func queryItems(_ items: [URLQueryItem]) -> URLRequestBuilder
    func build(with method: HTTPMethod, timeout: TimeInterval) -> URLRequest?
}

class URLRequestBuilder: URLRequestBuilderType {
    private var components: URLComponents?
    
    private let baseURL: String
    private let keys: MoviesKeys
    
    init(
        baseURL: String = "https://api.themoviedb.org/3",
        keys: MoviesKeys = MoviesKeys()
    ) {
        self.baseURL = baseURL
        self.keys = keys
        self.components = URLComponents()
    }
    
    func requestKind(_ kind: RequestKind) -> URLRequestBuilder {
        if let url = URL(string: baseURL + kind.rawValue) {
            components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        }
        
        return self
    }
    
    func queryItems(_ items: [URLQueryItem]) -> URLRequestBuilder {
        components?.queryItems = items
        
        return self
    }
    
    func build(
        with method: HTTPMethod = .GET,
        timeout: TimeInterval = 10
    ) -> URLRequest? {
        if let url = components?.url {
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            request.timeoutInterval = timeout
            request.allHTTPHeaderFields = [
                "accept": "application/json",
                "Authorization": "Bearer \(keys.authKey)"
            ]
            
            return request
        }
        
        return nil
    }
}
