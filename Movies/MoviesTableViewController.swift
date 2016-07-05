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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Movie.latestMovies.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Movie Cell", forIndexPath: indexPath)
        let movie = Movie.latestMovies[indexPath.row]
        cell.textLabel?.text = movie.name
        cell.textLabel?.numberOfLines = 0
        cell.imageView?.image = movie.image

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let movie = Movie.latestMovies[indexPath.row]
        // TODO: fill the identifier here
        self.performSegueWithIdentifier("", sender: movie)
    }
}
