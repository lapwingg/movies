//
//  MovieCellView.swift
//  Movies
//
//  Created by Kamil Czajka on 06/09/2024.
//

import SwiftUI

struct MovieCellView: View {
    @ObservedObject var viewModel: MoviesListViewModel
    let movie: Movie
    
    var body: some View {
        HStack(alignment: .center, spacing: 12.0) {
            Image(systemName: viewModel.isFavourite(movie: movie) ? "heart.fill" : "heart")
                .resizable()
                .scaledToFit()
                .frame(width: 20.0, height: 20.0)
                .foregroundColor(.red)
                .onTapGesture {
                    viewModel.set(isFavourite: !viewModel.isFavourite(movie: movie), movie: movie)
                }
            
            VStack(alignment: .leading, spacing: 8.0) {
                Text(movie.title)
                    .bold()
                    .onAppear {
                        Task {
                            await viewModel.loadMoreMovies(id: movie.id)
                        }
                    }
                
                HStack(alignment: .firstTextBaseline, spacing: 4.0) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    
                    Text(String(format: "%0.1f", movie.voteAverage))
                    Text("(\(movie.voteCount))")
                        .foregroundColor(.gray)
                }
            }
        }
    }
}
