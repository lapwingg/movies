//
//  MoviesListViewModel.swift
//  Movies
//
//  Created by Kamil Czajka on 05/09/2024.
//

import SwiftUI

class MoviesListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    let networkManager: NetworkManagerType
    
    init(networkManager: NetworkManagerType) {
        self.networkManager = networkManager
    }
    
    func loadMovies() async {
        let queryItems: [URLQueryItem] = [
          URLQueryItem(name: "language", value: "en-US"),
          URLQueryItem(name: "page", value: "1"),
        ]
        
        let request = URLRequestBuilder()
            .requestKind(.nowPlayingMovies)
            .queryItems(queryItems)
            .build()
        
        if let request = request {
            do {
                let response = try await networkManager.request(request, of: NowPlayingMoviesResponse.self)
                await MainActor.run {
                    movies = response.results
                }
            } catch {
                
            }
        }
    }
}
