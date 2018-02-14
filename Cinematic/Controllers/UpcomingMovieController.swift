//
//  UpcomingViewController.swift
//  Cinematic
//
//  Created by Khant Zaw Ko on 12/1/18.
//  Copyright © 2018 Khant Zaw Ko. All rights reserved.
//

import UIKit
import Firebase

class UpcomingMovieController: UITableViewController {
    
    var movies = [Movie]()
    var filteredMovies = [Movie]()
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(MovieCell.self, forCellReuseIdentifier: "MovieCell")
        self.navigationController?.navigationBar.prefersLargeTitles = true
        getMovieData()
    }
    
    func getMovieData() {
        
        ref = Database.database().reference().child("movies")
        
        ref.observe(DataEventType.childAdded, with: {(snapshot) in
            var postDict = snapshot.value as! [String : AnyObject]
            
            if let movieName = postDict["name"],
                let movieGenre = postDict["genre"],
                let movieDuration = postDict["duration"],
                let movieRating = postDict["rating"],
                let movieImage = postDict["image"],
                let movieInfo = postDict["info"],
                let movieTrailer = postDict["trailer"],
                let movieStartDate = postDict["startDate"],
                let movieEndDate = postDict["endDate"] {
                
                self.movies.append(Movie(key: snapshot.key,
                                         name: (movieName as! String),
                                         genre: (movieGenre as! String),
                                         info: (movieInfo as! String),
                                         image: (movieImage as! String),
                                         duration: (movieDuration as! Int),
                                         rating: (movieRating as! Double),
                                         trailer: (movieTrailer as! String),
                                         startDate: (movieStartDate as! String),
                                         endDate: (movieEndDate as! String)))
            }
            
            if !self.movies.isEmpty {
                for movie in self.movies {
                    if movie.startDate != "nil" && movie.endDate != "nil" {
                        if Date().isStartDateIsGreaterThanNextFriday(startDate: movie.startDate) {
                            if !self.filteredMovies.contains(where: {$0.key == movie.key}) {
                                self.filteredMovies.append(movie)
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
            } else {
                
            }
        })
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        ratings = filteredMovies[indexPath.row].rating
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = filteredMovies[indexPath.row]
        cell.movie = movie
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "MovieInfo", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MovieInfo" {
            let row = sender as! Int
            let umic: UpcomingMovieInfoController = segue.destination as! UpcomingMovieInfoController
            umic.selectedMovie = filteredMovies[row]
        }
    }
}

