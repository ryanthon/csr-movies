//
//  ViewController.swift
//  CSRMovies
//
//  Created by Ryan Khalili on 3/5/15.
//  Copyright (c) 2015 CSR. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var movies: [Movie] = [Movie]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let movie = Movie( title: "Godfather", director: "", rating: "", url: "" )
        movies.append( movie )
        
        let url = "https://csr-movies.herokuapp.com"
        let urlRequest = NSURLRequest( URL: NSURL( string: url )! )
        
        NSURLSession.sharedSession().dataTaskWithRequest( urlRequest, completionHandler:
        {
            data, response, error in
            
            if error != nil {
                return
            }
            
            let json = NSJSONSerialization.JSONObjectWithData( data, options: nil, error: nil ) as? NSDictionary
            
            if json != nil {
                if let movies = json!.objectForKey( "movies" ) as? NSArray {
                    
                    var movieArray = [Movie]()
                    
                    for movie in movies {
                        let title = movie["title"] as String
                        let director = movie["director"] as String
                        let rating = movie["rating"] as String
                        let url = movie["url"] as String
                        
                        let newMovie = Movie( title: title, director: director, rating: rating, url: url )
                        movieArray.append( newMovie )
                    }
                    
                    self.movies = movieArray
                    
                    dispatch_async( dispatch_get_main_queue(), {
                        self.tableView.reloadData()
                    })
                }
            }
        }).resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier( "movieCell" ) as MovieTableViewCell
        
        let index = indexPath.row
        let movie = movies[index]
        
        cell.movieLabel.text = movie.title
        cell.directorLabel.text = movie.director
        cell.ratingLabel.text = movie.rating
        
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let movie = movies[indexPath.row]
        performSegueWithIdentifier( "movieSegue", sender: movie )
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "movieSegue" {
            
            let movie = sender as Movie
            let destination = segue.destinationViewController as MoviePageViewController
            destination.movieURL = movie.url
        }
    }
}







