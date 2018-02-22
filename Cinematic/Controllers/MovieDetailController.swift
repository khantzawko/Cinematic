//
//  MovieDetailController.swift
//  Cinematic
//
//  Created by Khant Zaw Ko on 20/2/18.
//  Copyright © 2018 Khant Zaw Ko. All rights reserved.
//

import UIKit
import Firebase

private var selectedIndexPath: IndexPath?
private var filteredCinemas = [Cinema]()

class MovieDetailController: UITableViewController {
    
    var selectedMovie = Movie()
    var cinemas = [Cinema]()
    var theatres = [Theatre]()
    var filteredTheatres = [Theatre]()
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "The Movie - "
        let rightBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "movie-ticket"), style: .plain, target: self, action: #selector(pressedRightBarButton))
        navigationItem.rightBarButtonItem = rightBarButton
        tableView.register(MovieDetailCell.self, forCellReuseIdentifier: "MovieDetail")
//        tableView.separatorStyle = .none
        
        getMovieData()
        selectedIndexPath = IndexPath(row: 0, section: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.theatres.isEmpty {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    
    @objc private func pressedRightBarButton() {
        let mdtc = MovieDateTimeController()
        mdtc.selectedMovie = selectedMovie
        mdtc.selectedCinema = filteredCinemas[(selectedIndexPath?.row)!]
        mdtc.selectedTheatre = filteredTheatres[(selectedIndexPath?.row)!]
        navigationController?.pushViewController(mdtc, animated: true)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if segue.identifier == "ToPurchaseTicket" {
//            let ptv: PurchaseTicketController = segue.destination as! PurchaseTicketController
//            ptv.selectedMovie = selectedMovie
//            ptv.selectedCinema = cinemas[(selectedIndexPath?.row)!]
//            ptv.selectedTheatre = theatres[(selectedIndexPath?.row)!]
//        }
//    }
    
    func getMovieData() {
        filteredCinemas.removeAll()
        filteredTheatres.removeAll()
        ref = Database.database().reference().child("movies/\(selectedMovie.key!)/theatres")
        let theatreRef = Database.database().reference().child("theatres")
        let cinemaRef = Database.database().reference().child("cinema")
        ref.observe(DataEventType.childAdded, with: {(mSnap) in
            var movieDict = mSnap.value as! [String:AnyObject]
            if  let cinemaKey = movieDict["cinemaID"],
                let theatreKey = movieDict["theatreID"] {
                
                theatreRef.child(theatreKey as! String).observe(DataEventType.value, with: {(tSnap) in
                    var theatreDict = tSnap.value as! [String:AnyObject]
                    if let theatreName = theatreDict["name"],
                        let theatreShowtimes = theatreDict["showtimes"],
                        let theatreType = theatreDict["theatreTypeID"] {
                        var movieDict = tSnap.childSnapshot(forPath: "movies/\(self.selectedMovie.key!)").value as! [String:AnyObject]
                        if  let startDate = movieDict["startDate"],
                            let weeksInTheatre = movieDict["weeksInTheatre"] {
                            
                            self.theatres.append(Theatre(key: theatreKey as? String,
                                                         name: theatreName as? String,
                                                         showtimes: theatreShowtimes as? [String],
                                                         theatreType: theatreType as? String,
                                                         startDate: startDate as? String,
                                                         weeksInTheatre: weeksInTheatre as? Int,
                                                         cinemaKey: cinemaKey as? String))
                        }
                    }
                })
                
                cinemaRef.child(cinemaKey as! String).observe(DataEventType.value, with: {(cSnap) in
                    var cinemaDict = cSnap.value as! [String:AnyObject]
                    if  let cinemaName = cinemaDict["name"],
                        let cinemaLocation = cinemaDict["location"],
                        let cinemaPhone = cinemaDict["phone"] {
                        let cinema = Cinema(key: (cinemaKey as! String),
                                            name: (cinemaName as! String),
                                            location: (cinemaLocation as! String),
                                            phone: (cinemaPhone as! String))
                        self.cinemas.append(cinema)
                    }
                    
                    for theatre in self.theatres {
                        if !self.theatres.isEmpty {
                            if Date().isEndDateMoreThanToday(startDate: theatre.startDate!, numOfWeek: theatre.weeksInTheatre!) {
                                for cinema in self.cinemas {
                                    if !self.cinemas.isEmpty {
                                        if cinema.key == theatre.cinemaKey {
                                            
                                            if !filteredCinemas.contains(where: {$0.key == cinema.key}) {
                                                filteredCinemas.append(cinema)
                                            }
                                            
                                            if !self.filteredTheatres.contains(where: {$0.key == theatre.key}) {
                                                self.filteredTheatres.append(theatre)
                                            }
                                        }
                                    }
                                }
                            } else {
                                
                            }
                        }
                    }
                    
                    self.tableView.reloadData()
                    self.reloadCollectionView()
                })
            }
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
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
        } else if indexPath.row == 2 {
            let cell = MovieDetailCell.init(style: .default, reuseIdentifier: "Cinema")
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 136
        } else {
            return UITableViewAutomaticDimension
        }
    }
    
    func reloadCollectionView() {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "MovieDetail") as! MovieDetailCell
        cell.cinemaCollectionView.reloadData()
        
        if filteredCinemas.isEmpty {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
}

extension MovieDetailCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredCinemas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CinemaCollectionCell", for: indexPath) as! CinemaCollectionCell
        cell.cinemaName.text = filteredCinemas[indexPath.row].name
        
        if indexPath == selectedIndexPath && selectedIndexPath != nil {
            cell.layer.backgroundColor = UIColor(red:1.00, green:0.14, blue:0.40, alpha:1.0).cgColor
            cell.cinemaName.textColor = .white
        } else {
            cell.layer.backgroundColor = UIColor.white.cgColor
            cell.cinemaName.textColor = UIColor(red:1.00, green:0.14, blue:0.40, alpha:1.0)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedIndexPath = indexPath
        
        guard collectionView.cellForItem(at: indexPath) != nil else {
            return
        }
        
        let cell = collectionView.cellForItem(at: indexPath) as! CinemaCollectionCell
        cell.layer.backgroundColor = UIColor(red:1.00, green:0.14, blue:0.40, alpha:1.0).cgColor
        cell.cinemaName.textColor = .white
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        selectedIndexPath = nil
        
        guard collectionView.cellForItem(at: indexPath) != nil else {
            return
        }
        
        let cell = collectionView.cellForItem(at: indexPath) as! CinemaCollectionCell
        cell.layer.backgroundColor = UIColor.white.cgColor
        cell.cinemaName.textColor = UIColor(red:1.00, green:0.14, blue:0.40, alpha:1.0)
    }
}
