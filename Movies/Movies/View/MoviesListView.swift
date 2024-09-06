//
//  MoviesListView.swift
//  Movies
//
//  Created by Kamil Czajka on 05/09/2024.
//

import SwiftUI

struct MoviesListView: View {
    @ObservedObject var viewModel: MoviesListViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.movies) { movie in
                NavigationLink {
                    MovieDetailsView(viewModel: MovieDetailsViewModel(movie: movie))
                } label: {
                    Text(movie.title)
                        .onAppear {
                            Task {
                                await viewModel.loadMoreMovies(id: movie.id)
                            }
                        }
                }
            }
            .navigationTitle("Now Playing")
        }
        .task {
            await viewModel.loadMovies()
        }
    }
}
