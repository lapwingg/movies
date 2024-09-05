//
//  MoviesApp.swift
//  Movies
//
//  Created by Kamil Czajka on 05/09/2024.
//

import SwiftUI

@main
struct MoviesApp: App {
    var body: some Scene {
        WindowGroup {
            MoviesListView(
                viewModel: MoviesListViewModel(networkManager: NetworkManager())
            )
        }
    }
}
