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
}

