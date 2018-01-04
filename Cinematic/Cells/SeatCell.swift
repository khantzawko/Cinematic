//
//  SeatCell.swift
//  Cinematic
//
//  Created by Khant Zaw Ko on 22/12/17.
//  Copyright © 2017 Khant Zaw Ko. All rights reserved.
//

import UIKit

class SeatCell: UITableViewCell {

    @IBOutlet weak var seatTitle: UILabel!
    @IBOutlet weak var chooseSeatButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
