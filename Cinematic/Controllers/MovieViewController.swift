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
    var movieDurations = [String]()
    var movieGenres = [String]()
    var movieRatings = [Double]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieImages = ["coco.jpg", "justiceleague.jpg", "wonder.jpg", "thedisasterartist.jpg", "thorragnarok.jpg"]
        movieTitles = ["Coco", "Justice League", "Wonder", "The Disaster Artist", "Thor: Ragnark"]
        movieDurations = ["109","108","107","106","99"]
        movieGenres = ["Animation", "Action, Adventure, Fantasy", "Drama, Family", "Biography, Comedy, Drama", "Action, Adventure, Comedy"]
//        movieRatings = ["4.6 out of 5", "3.6 out of 5", "4.6 out of 5", "4.1 out of 5", "4.1 out of 5"]
        
       movieRatings = [5,4.2,4.5,3.7,4.8]
        
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
        
        movieRating = movieRatings[indexPath.row]
        
        let cell = MovieCell(style: .default, reuseIdentifier: "MovieCell")
        
        cell.movieImage.image = UIImage(named: movieImages[indexPath.row])
        cell.movieGenre.text = movieGenres[indexPath.row]
        cell.movieTitle.text = movieTitles[indexPath.row]
        cell.movieDuration.text = "(\(movieDurations[indexPath.row]) mins)"
        cell.movieRatingText.text = "(\(movieRatings[indexPath.row]) stars)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "mySegue", sender: cell)
    }

}
