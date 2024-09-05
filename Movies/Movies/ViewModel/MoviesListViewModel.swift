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
    
    private var canLoadNextPage: Bool = true
    private var currentPage = 0

    init(networkManager: NetworkManagerType) {
        self.networkManager = networkManager
    }
    
    func loadMoreMovies(id: Int) async {
        if id == movies.last?.id && canLoadNextPage {
            canLoadNextPage = false
            await loadMovies()
        }
    }
    
    func loadMovies() async {
        currentPage += 1
        let queryItems: [URLQueryItem] = [
          URLQueryItem(name: "language", value: "en-US"),
          URLQueryItem(name: "page", value: "\(currentPage)"),
        ]
        
        let request = URLRequestBuilder()
            .requestKind(.nowPlayingMovies)
            .queryItems(queryItems)
            .build()
        
        if let request = request {
            do {
                let response = try await networkManager.request(request, of: NowPlayingMoviesResponse.self)
                await MainActor.run {
                    movies += response.results
                    canLoadNextPage = response.page < response.totalPages
                }
            } catch {
                
            }
        }
    }
}
