//
//  UpcomingMovieInfoController.swift
//  Cinematic
//
//  Created by Khant Zaw Ko on 4/2/18.
//  Copyright © 2018 Khant Zaw Ko. All rights reserved.
//

import UIKit
import Firebase

class UpcomingMovieDetailController: UITableViewController {
    
    var selectedMovie = Movie()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "The Movie - "
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 136
        } else {
            return UITableViewAutomaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = MovieDetailCell.init(style: .default, reuseIdentifier: "Header")
            let movie = selectedMovie
            cell.movie = movie
            return cell
        } else if indexPath.row == 1 {
            let cell = MovieDetailCell.init(style: .default, reuseIdentifier: "Plot")
            let movie = selectedMovie
            cell.movie = movie
            return cell
        }  else {
            return UITableViewCell()
        }
    }
    
//    func getMovieData() {
//        cinemaNames.removeAll()
//        ref = Database.database().reference().child("movies/\(selectedMovie.key!)/theatres")
//        let theatreRef = Database.database().reference().child("theatres")
//        let cinemaRef = Database.database().reference().child("cinema")
//        ref.observe(DataEventType.childAdded, with: {(mSnap) in
//            var movieDict = mSnap.value as! [String:AnyObject]
//            if  let cinemaKey = movieDict["cinemaID"],
//                let theatreKey = movieDict["theatreID"] {
//                cinemaRef.child(cinemaKey as! String).observe(DataEventType.value, with: {(cSnap) in
//                    var cinemaDict = cSnap.value as! [String:AnyObject]
//                    if  let cinemaName = cinemaDict["name"],
//                        let cinemaLocation = cinemaDict["location"],
//                        let cinemaPhone = cinemaDict["phone"] {
//                        cinemaNames.append(cinemaName as! String)
//                        let cinema = Cinema(key: (cinemaKey as! String),
//                                            name: (cinemaName as! String),
//                                            location: (cinemaLocation as! String),
//                                            phone: (cinemaPhone as! String))
//                        self.cinemas.append(cinema)
//                    }
//                    self.tableView.reloadData()
//                })
//
//
//                theatreRef.child(theatreKey as! String).observe(DataEventType.value, with: {(tSnap) in
//                    var theatreDict = tSnap.value as! [String:AnyObject]
//                    if let theatreName = theatreDict["name"], let theatreShowtimes = theatreDict["showtimes"], let theatreType = theatreDict["theatreTypeID"] {
//
//                        var movieDict = tSnap.childSnapshot(forPath: "movies/\(self.selectedMovie.key!)").value as! [String:AnyObject]
//                        if  let startDate = movieDict["startDate"],
//                            let weeksInTheatre = movieDict["weeksInTheatre"] {
//                            let theatre = Theatre(key: theatreKey as? String,
//                                                  name: theatreName as? String,
//                                                  showtimes: theatreShowtimes as? [String],
//                                                  theatreType: theatreType as? String,
//                                                  startDate: startDate as? String,
//                                                  weeksInTheatre: weeksInTheatre as? Int)
//                            self.theatres.append(theatre)
//                        }
//                    }
//                })
//            }
//        })
//    }
}

