//
//  MovieBCell.swift
//  Cinematic
//
//  Created by Khant Zaw Ko on 13/1/18.
//  Copyright © 2018 Khant Zaw Ko. All rights reserved.
//

import UIKit

class MovieBCell: UITableViewCell {
    
//    @IBOutlet weak var infoMovieImage: UIImageView!
//    @IBOutlet weak var infoMovieTitle: UILabel!
    
    @IBOutlet weak var infoImage: UIImageView!
    @IBOutlet weak var infoTitle: UILabel!
    
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
