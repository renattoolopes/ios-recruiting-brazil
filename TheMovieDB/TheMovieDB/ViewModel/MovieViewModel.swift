//
//  MovieViewModel.swift
//  TheMovieDB
//
//  Created by Renato Lopes on 11/01/20.
//  Copyright © 2020 renato. All rights reserved.
//

import Foundation
import UIKit

class MovieViewModel {
    public static let shared = MovieViewModel.init()
    public var movies: [Movie] = [] {
        didSet {
            NotificationCenter.default.post(.moviesUpdated)
        }
    }
    public var selectedMovie: Movie?
    
    private var pathURLMovies: String {
        get {
            return  "\(ServiceAPIManager.PathsAPI.https)\(ServiceAPIManager.PathsAPI.rootAPI)\(ServiceAPIManager.PathsAPI.versionAPI)\(ServiceAPIManager.PathsAPI.MovieAPI.movie)\(ServiceAPIManager.PathsAPI.MovieAPI.popular)"
        }
    }
    
    private init() { }
    
    public func selectMovie(index: Int) {
        guard index >= 0 else { return }
        self.selectedMovie = movies[index]

    }
    
    public func changeFavorite() {
        guard let movie = selectedMovie else { return }
        movie.isFavorite = !movie.isFavorite
    }
    
    public func fetchMovies() {
        let path = pathURLMovies
        guard var components = URLComponents.init(string: path) else { return }
        components.queryItems = [
            URLQueryItem.init(name: ServiceAPIManager.PathsAPI.apiKey, value: ServiceAPIManager.PathsAPI.key),
            URLQueryItem.init(name: ServiceAPIManager.PathsAPI.page, value: "1")
        ]
        guard let url = components.url else { return }
        ServiceAPIManager.get(url: url) { (data, error)  in
            guard let result = data else { return }
            do {
                let moviesDecode = try JSONDecoder().decode(PopularMoviesAPI.self, from: result)
                self.movies = moviesDecode.movies
            } catch { }
        }
    }
}
