//
//  MoviesTableViewController.swift
//  Movies
//
//  Created by Brian Hu on 7/5/16.
//  Copyright © 2016 AlphaCamp. All rights reserved.
//

import UIKit

class MoviesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "MyMovieTableViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "My Movie Cell")
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        print("print: \(self.tableView.frame)")
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("My Movie Cell", forIndexPath: indexPath) as! MyMovieTableViewCell
        let movie = Movie.latestMovies[indexPath.row%3]

        cell.movieImageView.image = movie.image
        cell.nameLabel.text = movie.name
        cell.descriptionLabel.text = movie.description
        
//        cell.textLabel?.text = movie.name
//        cell.textLabel?.numberOfLines = 0
//        cell.imageView?.image = movie.image

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let movie = Movie.latestMovies[indexPath.row]
        self.performSegueWithIdentifier("Movies Table To Detail", sender: movie)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Movies Table To Detail" {
            let detailVC = segue.destinationViewController as! DetailViewController
            detailVC.movie = sender as? Movie
        }
    }
}
