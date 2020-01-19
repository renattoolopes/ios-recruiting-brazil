//
//  MovieService.swift
//  TheMovieDB
//
//  Created by Renato Lopes on 19/01/20.
//  Copyright © 2020 renato. All rights reserved.
//

import Foundation

class MovieService {
    private var pathMoviesURL: String {
        get {
            return  "\(ServiceAPIManager.PathsAPI.rootAPI)\(ServiceAPIManager.PathsAPI.versionAPI)\(ServiceAPIManager.PathsAPI.MovieAPI.movie)"
        }
    }
    
    public func fetchMovies(resultMovies: @escaping (_ result: [Movie]) -> Void) {
        guard var components = URLComponents.init(string: pathMoviesURL) else { return }
        components.queryItems = [
            URLQueryItem.init(name: ServiceAPIManager.PathsAPI.apiKey, value: ServiceAPIManager.PathsAPI.key),
            URLQueryItem.init(name: ServiceAPIManager.PathsAPI.page, value: "1")
        ]
        guard let url = components.url else { return }
        ServiceAPIManager.get(url: url) { (data, error)  in
            guard let resultData = data else { return }
            do {
                let movies = try JSONDecoder().decode(PopularMoviesAPI.self, from: resultData)
                resultMovies(movies.movies)
            } catch { }
        }
    }
    
}
