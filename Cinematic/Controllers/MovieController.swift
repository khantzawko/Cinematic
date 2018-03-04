//
//  MovieViewController.swift
//  Cinematic
//
//  Created by Khant Zaw Ko on 12/12/17.
//  Copyright © 2017 Khant Zaw Ko. All rights reserved.
//

import UIKit
import Firebase

class MovieController: UITableViewController {
    
    var movies = [Movie]()
    var filteredMovies = [Movie]()
    var ref: DatabaseReference!
    
    var customView: UIView!
    var labelsArray:[UILabel] = []
    var isAnimating = false
    var currentColorIndex = 0
    var currentLabelIndex = 0
    var timer: Timer!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(MovieCell.self, forCellReuseIdentifier: "MovieCell")
        
        refreshControl = UIRefreshControl()
        refreshControl?.backgroundColor = .clear
        refreshControl?.tintColor = .clear
        loadCustomRefreshContents()
        getMovieData()
    }
    
    func loadCustomRefreshContents() {
        let refreshContents = Bundle.main.loadNibNamed("CustomView", owner: self, options: nil)!

        customView = refreshContents[0] as! UIView
        customView.frame = (refreshControl?.bounds)!
        
        for i in 0..<customView.subviews.count {
            labelsArray.append(customView.viewWithTag(i + 1) as! UILabel)
        }
        
        refreshControl?.addSubview(customView)
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (refreshControl?.isRefreshing)! {
            if !isAnimating {
                doSomething()
                getMovieData()
                animateRefreshStep1()
            }
        }
    }
    
    func animateRefreshStep1() {
        isAnimating = true
        
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveLinear, animations: {() -> Void in
            
            self.labelsArray[self.currentLabelIndex].transform = CGAffineTransform(rotationAngle: CGFloat.pi / 4)
            self.labelsArray[self.currentLabelIndex].textColor = self.getNextColor()
            
        }, completion: {(finished) -> Void in
            
            UIView.animate(withDuration: 0.05, delay: 0.0, options: .curveLinear, animations: {() -> Void in
            
            self.labelsArray[self.currentLabelIndex].transform = CGAffineTransform.identity
            self.labelsArray[self.currentLabelIndex].textColor = .black
            
            }, completion: {(finished) -> Void in
            
                self.currentLabelIndex = self.currentLabelIndex + 1
                
                if self.currentLabelIndex < self.labelsArray.count {
                    self.animateRefreshStep1()
                } else {
                    self.animateRefreshStep2()
                }
            })
        })
    }
    
    func animateRefreshStep2() {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveLinear, animations: { () -> Void in
            
            for i in 0..<self.labelsArray.count {
                self.labelsArray[i].transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }
            
        }, completion: { (finished) -> Void in
            UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveLinear, animations: { () -> Void in
                
                for i in 0..<self.labelsArray.count {
                    self.labelsArray[i].transform = CGAffineTransform.identity
                }
                
            }, completion: { (finished) -> Void in
                if (self.refreshControl?.isRefreshing)! {
                    self.currentLabelIndex = 0
                    self.animateRefreshStep1()
                }
                else {
                    self.isAnimating = false
                    self.currentLabelIndex = 0
                    
                    for i in 0..<self.labelsArray.count {
                        self.labelsArray[i].textColor = .black
                        self.labelsArray[i].transform = .identity
                    }
                }
            })
        })
    }
    
    func getNextColor() -> UIColor {
        var colorsArray: [UIColor] = [.magenta, .brown, .yellow, .red, .green, .blue, .orange, .yellow, .cyan]
        
        if currentColorIndex == colorsArray.count {
            currentColorIndex = 0
        }
        
        let returnColor = colorsArray[currentColorIndex]
        currentColorIndex = currentColorIndex + 1
        
        return returnColor
    }
    
    func doSomething() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(endOfWork), userInfo: nil, repeats: true)
    }
    
    @objc func endOfWork() {
        refreshControl?.endRefreshing()
        
        timer.invalidate()
        timer = nil
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
                        if Date().isTodayInBetweenStartDateAndEndDate(startDate: movie.startDate!, endDate: movie.endDate!) {
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 136
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        ratings = filteredMovies[indexPath.row].rating!
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = filteredMovies[indexPath.row]
        cell.movie = movie
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let mdc = MovieDetailController()
        mdc.selectedMovie = filteredMovies[indexPath.row]
        navigationController?.pushViewController(mdc, animated: true)
    }
}


