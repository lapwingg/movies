//
//  Movie.swift
//  Movies
//
//  Created by Kamil Czajka on 05/09/2024.
//

import Foundation

struct Movie: Identifiable, Codable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String
    let voteAverage: Double
    let voteCount: Int
    let releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case releaseDate = "release_date"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(overview, forKey: .overview)
        try container.encode(posterPath, forKey: .posterPath)
        try container.encode(voteAverage, forKey: .voteAverage)
        try container.encode(voteCount, forKey: .voteCount)
        try container.encode(releaseDate, forKey: .releaseDate)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        overview = try container.decode(String.self, forKey: .overview)
        posterPath = try container.decode(String.self, forKey: .posterPath)
        voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        voteCount = try container.decode(Int.self, forKey: .voteCount)
        releaseDate = try container.decode(String.self, forKey: .releaseDate)
    }
}
