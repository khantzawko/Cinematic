//
//  MovieCell.swift
//  Cinematic
//
//  Created by Khant Zaw Ko on 12/12/17.
//  Copyright © 2017 Khant Zaw Ko. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieDuration: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    
    @IBOutlet weak var infoMovieImage: UIImageView!
    @IBOutlet weak var infoMovieTitle: UILabel!
    
    @IBOutlet weak var selectedMovie: UILabel!
    @IBOutlet weak var purchaseSelectedMovieTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
