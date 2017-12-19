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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        cell.movieTitle.text = movieTitles[indexPath.row]
        cell.movieYear.text = ""
        cell.movieDuration.text = movieDurations[indexPath.row] + " mins"
        cell.movieGenre.text = ""
        cell.movieRating.text = movieRatings[indexPath.row]

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
