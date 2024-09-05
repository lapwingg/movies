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
            List(viewModel.movies) {
                Text($0.title)
            }
        }
        .task {
            await viewModel.loadMovies()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView(viewModel: MoviesListViewModel(networkManager: NetworkManager()))
    }
}
