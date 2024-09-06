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
            VStack {
                Spacer(minLength: 16.0)
                GeometryReader { geometry in
                    ScrollView {
                        VStack(spacing: 16.0) {
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
                            .frame(height: geometry.size.height * 0.6)
                            
                            VStack(spacing: 16.0) {
                                Text(viewModel.title)
                                    .font(.largeTitle)
                                    .bold()
                                    .foregroundColor(.primary)
                                
                                Text(viewModel.overview)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding()
                                    .foregroundColor(.secondary)
                                
                                Text("Release date: \(viewModel.releaseDate)")
                                    .bold()
                                    .foregroundColor(.brown)
                            }
                            .frame(width: geometry.size.width - 32.0, alignment: .center)
                        }
                        .frame(width: geometry.size.width)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack(alignment: .firstTextBaseline, spacing: 4.0) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        
                        Text("\(viewModel.rating)")
                            .bold()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
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
}
