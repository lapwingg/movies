//
//  MovieDetailsViewModel.swift
//  Movies
//
//  Created by Kamil Czajka on 05/09/2024.
//

import Foundation

class MovieDetailsViewModel {
    private let movie: Movie
    private let baseURL: String
    
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
    
    init(movie: Movie, baseURL: String = "https://image.tmdb.org/t/p/w500") {
        self.movie = movie
        self.baseURL = baseURL
    }
}
