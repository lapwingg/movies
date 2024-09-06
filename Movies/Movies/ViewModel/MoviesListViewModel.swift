//
//  MoviesListViewModel.swift
//  Movies
//
//  Created by Kamil Czajka on 05/09/2024.
//

import SwiftUI

class MoviesListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var searchResults: [Movie] = []
    @Published var searchText: String = "" {
        didSet {
            if searchText.isEmpty {
                currentRunningTask = Task {
                    await loadMovies()
                }
            } else {
                currentRunningTask = Task {
                    await searchMovies()
                }
            }
        }
    }
    @Published var updateUI: Bool = false

    let networkManager: NetworkManagerType
    let favouritesMovies: FavouriteMoviesType
    
    private var currentRunningTask: Task<Void, Error>?
    private var canLoadNextPage: Bool = true
    private var currentPage = 0

    init(networkManager: NetworkManagerType, favouritesMovies: FavouriteMoviesType) {
        self.networkManager = networkManager
        self.favouritesMovies = favouritesMovies
    }
    
    func onAppear() {
        self.updateUI = true
    }
    
    func loadMoreMovies(id: Int) async {
        if id == movies.last?.id && canLoadNextPage {
            canLoadNextPage = false
            await loadMovies()
        }
    }
    
    func loadMovies() async {
        guard searchText.isEmpty else {
            return
        }
        
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
                let response = try await networkManager.request(request, of: MoviesResponse.self)
                await MainActor.run {
                    if currentPage == 1 {
                        movies = response.results
                    } else {
                        movies += response.results
                    }
                    canLoadNextPage = response.page < response.totalPages
                }
            } catch {
                
            }
        }
    }
    
    func searchMovies() async {
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "query", value: searchText),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "include_adult", value: "false"),
            URLQueryItem(name: "page", value: "1")
        ]
        
        let request = URLRequestBuilder()
            .requestKind(.searchMovies)
            .queryItems(queryItems)
            .build()
        
        if let request = request {
            do {
                let response = try await networkManager.request(request, of: MoviesResponse.self)
                await MainActor.run {
                    searchResults = response.results
                }
            } catch {
                
            }
        }
    }
    
    func hideSuggestions() {
        currentRunningTask?.cancel()
        if let movie = searchResults.first(where: { movie in movie.title == searchText }) {
            movies = [movie]
        }
        searchResults = []
        currentPage = 0
    }
    
    func isFavourite(movie: Movie) -> Bool {
        return self.favouritesMovies.isFavouriteMovie(id: movie.id)
    }
    
    func set(isFavourite: Bool, movie: Movie) {
        self.favouritesMovies.set(isFavourite: isFavourite, for: movie.id)
        self.updateUI = true
    }
}
