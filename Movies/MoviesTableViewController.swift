//
//  MoviesTableViewController.swift
//  Movies
//
//  Created by Brian Hu on 7/5/16.
//  Copyright © 2016 AlphaCamp. All rights reserved.
//

import UIKit
import Firebase

class MoviesTableViewController: UITableViewController {
    
    var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "MyMovieTableViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "My Movie Cell")
        
        tableView.estimatedRowHeight = 80
    }
    
    func configureDatabase() {
        ref = FIRDatabase.database().reference()
        // Listen for new messages in the Firebase database
        _refHandle = self.ref.child("messages").observeEventType(.ChildAdded, withBlock: { (snapshot) -> Void in
            self.messages.append(snapshot)
            self.clientTable.insertRowsAtIndexPaths([NSIndexPath(forRow: self.messages.count-1, inSection: 0)], withRowAnimation: .Automatic)
        })
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
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Movie.latestMovies.count
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 1:
            return UITableViewAutomaticDimension
        default:
            return 60
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = UIView()
        
        let screenRect = UIScreen.mainScreen().bounds
        let screenWidth = screenRect.width

        let label = UILabel(frame: CGRectMake(0, 0, screenWidth, 35))
        header.backgroundColor = UIColor.lightGrayColor()
        
        if section == 0 {
            label.text = "Standard Cells"
        } else if section == 1 {
            label.text = "Custom Cells"
        }

        header.addSubview(label)
        return header
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let movie = Movie.latestMovies[indexPath.row]
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("Movie Cell", forIndexPath: indexPath)
            
            cell.textLabel?.text = movie.name
            cell.textLabel?.numberOfLines = 0
            cell.imageView?.image = movie.image
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("My Movie Cell", forIndexPath: indexPath) as! MyMovieTableViewCell
            
            cell.movieImageView.image = movie.image
            cell.nameLabel.text = movie.name
            cell.descriptionLabel.text = movie.description
            return cell
        default:
            return UITableViewCell()
        }
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
