//
//  MovieInfoViewController.swift
//  Cinematic
//
//  Created by Khant Zaw Ko on 17/12/17.
//  Copyright © 2017 Khant Zaw Ko. All rights reserved.
//

import UIKit
import Firebase

private var selectedIndexPath: IndexPath?
private var cinemaNames = [String]()

class MovieInfoController: UITableViewController {
        
    var selectedMovie = Movie()
    var cinemas = [Cinema]()
    var theatres = [Theatre]()
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovieData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        selectedIndexPath = IndexPath(row: 0, section: 0)
        
        if self.theatres.isEmpty {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        if indexPath.row == 0 {            
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieBCell", for: indexPath) as! MovieBCell
            cell.infoTitle.text = selectedMovie.name!
            cell.infoImage.downloadedFrom(link: selectedMovie.image!)
            cell.infoImage.layer.cornerRadius = 5
            cell.infoImage.clipsToBounds = true
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieInfoCell", for: indexPath) as! MovieInfoCell
            cell.movieInfoTitle.text = " Movie Info"
            cell.movieInfoDescription.text = selectedMovie.info
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CinemaCell", for: indexPath) as! CinemaCell
            cell.cinemaTitle.text = " Cinemas"
            return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TrailerCell", for: indexPath) as! TrailerCell
            cell.trailerTitle.text = " Trailers"
            cell.webView.loadHTMLString("<iframe width=\"100%\" height=\"100%\" src=\"\(selectedMovie.trailer!)\" frameborder=\"0\" gesture=\"media\" allow=\"encrypted-media\" allowfullscreen></iframe>", baseURL: nil)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ToPurchaseTicket" {
            let ptv: PurchaseTicketController = segue.destination as! PurchaseTicketController
            ptv.selectedMovie = selectedMovie
            ptv.selectedCinema = cinemas[(selectedIndexPath?.row)!]
            ptv.selectedTheatre = theatres[(selectedIndexPath?.row)!]
        }
    }
    
    func getMovieData() {
        cinemaNames.removeAll()
        ref = Database.database().reference().child("movies/\(selectedMovie.key!)/theatres")
        let theatreRef = Database.database().reference().child("theatres")
        let cinemaRef = Database.database().reference().child("cinema")
        ref.observe(DataEventType.childAdded, with: {(mSnap) in
            var movieDict = mSnap.value as! [String:AnyObject]
            if  let cinemaKey = movieDict["cinemaID"],
                let theatreKey = movieDict["theatreID"] {
                cinemaRef.child(cinemaKey as! String).observe(DataEventType.value, with: {(cSnap) in
                    var cinemaDict = cSnap.value as! [String:AnyObject]
                    if  let cinemaName = cinemaDict["name"],
                        let cinemaLocation = cinemaDict["location"],
                        let cinemaPhone = cinemaDict["phone"] {
                        cinemaNames.append(cinemaName as! String)
                        let cinema = Cinema(key: (cinemaKey as! String),
                                            name: (cinemaName as! String),
                                            location: (cinemaLocation as! String),
                                            phone: (cinemaPhone as! String))
                        self.cinemas.append(cinema)
                    }
                    self.tableView.reloadData()
                    self.reloadCollectionView()
                })
                
                
                theatreRef.child(theatreKey as! String).observe(DataEventType.value, with: {(tSnap) in
                    var theatreDict = tSnap.value as! [String:AnyObject]
                    if let theatreName = theatreDict["name"], let theatreShowtimes = theatreDict["showtimes"], let theatreType = theatreDict["theatreTypeID"] {

                        var movieDict = tSnap.childSnapshot(forPath: "movies/\(self.selectedMovie.key!)").value as! [String:AnyObject]
                        if  let startDate = movieDict["startDate"],
                            let weeksInTheatre = movieDict["weeksInTheatre"] {
                            let theatre = Theatre(key: theatreKey as? String,
                                                  name: theatreName as? String,
                                                  showtimes: theatreShowtimes as? [String],
                                                  theatreType: theatreType as? String,
                                                  startDate: startDate as? String,
                                                  weeksInTheatre: weeksInTheatre as? Int)
                            self.theatres.append(theatre)
                        }

                    }
                })
            }
        })
    }
    
    func reloadCollectionView() {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "CinemaCell") as! CinemaCell
        cell.collectionView.reloadData()
        
        if cinemas.isEmpty {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
}

extension CinemaCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cinemaNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionHorizontalCell", for: indexPath) as! CollectionHorizontalCell
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor(red:1.00, green:0.14, blue:0.40, alpha:1.0).cgColor
        cell.layer.cornerRadius = 20
        cell.cinemaName.text = cinemaNames[indexPath.row]

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

        let cell = collectionView.cellForItem(at: indexPath) as! CollectionHorizontalCell
        cell.layer.backgroundColor = UIColor(red:1.00, green:0.14, blue:0.40, alpha:1.0).cgColor
        cell.cinemaName.textColor = .white
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        selectedIndexPath = nil

        guard collectionView.cellForItem(at: indexPath) != nil else {
            return
        }

        let cell = collectionView.cellForItem(at: indexPath) as! CollectionHorizontalCell
        cell.layer.backgroundColor = UIColor.white.cgColor
        cell.cinemaName.textColor = UIColor(red:1.00, green:0.14, blue:0.40, alpha:1.0)
    }
}
