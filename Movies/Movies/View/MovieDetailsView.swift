//
//  MovieDetailsView.swift
//  Movies
//
//  Created by Kamil Czajka on 05/09/2024.
//

import SwiftUI

struct MovieDetailsView: View {
    @ObservedObject var viewModel: MovieDetailsViewModel
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    VStack {
                        AsyncImage(url: viewModel.imageURL) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFit()
                                
                            } else if phase.error != nil {
                                Text("There was an error loading the image.")
                            } else {
                                ProgressView()
                            }
                        }
                    }
                    .frame(height: geometry.size.height * 0.6)
                    
                    VStack {
                        Text(viewModel.title)
                            .font(.largeTitle)
                            .foregroundColor(.primary)
                        
                        Text(viewModel.overview)
                            .foregroundColor(.secondary)
                        
                        Text(viewModel.releaseDate)
                        Text(viewModel.rating)
                    }
                    .frame(height: geometry.size.height * 0.4)
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
            .toolbar {
                Button(action: {
                    viewModel.set(isFavourite: !viewModel.isFavourite)
                }, label: {
                    Image(systemName: viewModel.isFavourite ? "heart.fill" : "heart")
                        .foregroundColor(.red)
                })
            }
        }
    }
}
