//
//  MovieViewController.swift
//  Cinematic
//
//  Created by Khant Zaw Ko on 12/12/17.
//  Copyright © 2017 Khant Zaw Ko. All rights reserved.
//

import UIKit

class MovieViewController: UITableViewController {
    
    var movieImages = [String]()
    var movieTitles = [String]()
    var movieYears = [String]()
    var movieDurations = [String]()
    var movieGenres = [String]()
    var movieRatings = [String]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieImages = ["coco.jpg", "justiceleague.jpg", "wonder.jpg", "thedisasterartist.jpg", "thorragnarok.jpg"]
        movieTitles = ["Coco", "Justice League", "Wonder", "The Disaster Artist", "Thor: Ragnark"]
        movieYears = ["2017","2016","2015","2014","2013"]
        movieDurations = ["109","108","107","106","99"]
        movieGenres = ["Animation", "Action, Adventure, Fantasy", "Drama, Family", "Biography, Comedy, Drama", "Action, Adventure, Comedy"]
        movieRatings = ["4.6 out of 5", "3.6 out of 5", "4.6 out of 5", "4.1 out of 5", "4.1 out of 5"]
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movieTitles.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MovieCell
        
        cell.movieImage.image = UIImage(named: movieImages[indexPath.row])
        cell.movieImage.layer.cornerRadius = 5
        cell.movieImage.clipsToBounds = true
        cell.movieTitle.text = movieTitles[indexPath.row]
        cell.movieYear.text = ""
        cell.movieDuration.text = movieDurations[indexPath.row] + " mins"
        cell.movieGenre.text = ""
        cell.movieRating.text = movieRatings[indexPath.row]

        return cell
    }
}
