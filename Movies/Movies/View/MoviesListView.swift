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
                NavigationLink(
                    destination: MovieDetailsView(
                        viewModel: MovieDetailsViewModel(
                            movie: movie,
                            favouritesMovies: viewModel.favouritesMovies
                        )
                    )
                ) {
                    MovieCellView(viewModel: viewModel, movie: movie)
                }
                .onAppear {
                    viewModel.onAppear()
                }
            }
            .navigationTitle("Now Playing")
            .searchable(text: $viewModel.searchText, prompt: "Find a movie") {
                ForEach(viewModel.searchResults) { result in
                    Text(result.title).searchCompletion(result.title)
                }
                .onSubmit(of: .search) {
                    viewModel.hideSuggestions()
                }
            }

        }
        .task {
            await viewModel.loadMovies()
        }
    }
}
