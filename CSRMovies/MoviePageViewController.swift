//
//  MoviePageViewController.swift
//  CSRMovies
//
//  Created by Ryan Khalili on 3/5/15.
//  Copyright (c) 2015 CSR. All rights reserved.
//

import UIKit

class MoviePageViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    var movieURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if movieURL != nil {
            if let url = NSURL( string: movieURL! ) {
                let urlRequest = NSURLRequest( URL: url )
                webView.loadRequest( urlRequest )
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
