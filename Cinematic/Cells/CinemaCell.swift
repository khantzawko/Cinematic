//
//  CinemaCell.swift
//  Cinematic
//
//  Created by Khant Zaw Ko on 19/12/17.
//  Copyright © 2017 Khant Zaw Ko. All rights reserved.
//

import UIKit

class CinemaCell: UITableViewCell {

    @IBOutlet weak var cinemaName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}