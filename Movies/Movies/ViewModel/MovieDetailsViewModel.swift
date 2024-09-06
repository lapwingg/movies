//
//  MovieDetailsViewModel.swift
//  Movies
//
//  Created by Kamil Czajka on 05/09/2024.
//

import Foundation

class MovieDetailsViewModel: ObservableObject {
    private let movie: Movie
    private let baseURL: String
    private let favouritesMovies: FavouriteMoviesType
    
    @Published var isFavourite: Bool
    
    var imageURL: URL? {
        if let url = URL(string: baseURL + movie.posterPath) {
            return url
        }
        
        return URL(string: "")
    }
    
    var title: String {
        return movie.title
    }
    
    var releaseDate: String {
        return movie.releaseDate
    }
    
    var overview: String {
        return movie.overview
    }
    
    var rating: String {
        return "\(movie.voteAverage) (\(movie.voteCount))"
    }
    
    init(
        movie: Movie,
        baseURL: String = "https://image.tmdb.org/t/p/w500",
        favouritesMovies: FavouriteMoviesType
    ) {
        self.movie = movie
        self.baseURL = baseURL
        self.favouritesMovies = favouritesMovies
        self.isFavourite = self.favouritesMovies.isFavouriteMovie(id: movie.id)
    }
    
    func set(isFavourite: Bool) {
        self.favouritesMovies.set(isFavourite: isFavourite, for: movie.id)
        self.isFavourite = isFavourite
    }
}
