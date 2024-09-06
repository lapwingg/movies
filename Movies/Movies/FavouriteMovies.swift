//
//  FavouriteMovies.swift
//  Movies
//
//  Created by Kamil Czajka on 06/09/2024.
//

import Foundation

protocol FavouriteMoviesType {
    func isFavouriteMovie(id: Int) -> Bool
    func set(isFavourite: Bool, for id: Int)
}

class FavouriteMovies: FavouriteMoviesType {
    private let userDefaults: UserDefaults
    private var favouriteIDs: [Int]
    private let favouriteIDKey = "favouriteIDs"
    
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
        self.favouriteIDs = self.userDefaults.array(forKey: favouriteIDKey) as? [Int] ?? []
    }
    
    func isFavouriteMovie(id: Int) -> Bool {
        return self.favouriteIDs.contains(id)
    }
    
    func set(isFavourite: Bool, for id: Int) {
        if let favouriteIDIndex = favouriteIDs.firstIndex(where: { favId in favId == id }) {
            if !isFavourite {
                favouriteIDs.remove(at: favouriteIDIndex)
            }
        } else {
            if isFavourite {
                favouriteIDs.append(id)
            }
        }
        
        self.userDefaults.set(favouriteIDs, forKey: favouriteIDKey)
    }
}
