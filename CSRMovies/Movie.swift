//
//  Movie.swift
//  CSRMovies
//
//  Created by Ryan Khalili on 3/5/15.
//  Copyright (c) 2015 CSR. All rights reserved.
//

import Foundation

class Movie {
    
    var title: String
    var director: String
    var rating: String
    var url: String
    
    init( title: String, director: String, rating: String, url: String ) {
        
        self.title = title
        self.director = director
        self.rating = rating
        self.url = url
    }
}