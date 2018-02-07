//
//  OrderCell.swift
//  Cinematic
//
//  Created by Khant Zaw Ko on 7/2/18.
//  Copyright © 2018 Khant Zaw Ko. All rights reserved.
//

import UIKit

class OrderCell: UITableViewCell {
    
    let screenSize = UIScreen.main.bounds
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var movieImage: UIImageView!
    var movieName: UILabel!
    var ticketInfo: UILabel!
    var purchasedDate: UILabel!
    var receiptCode: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryType = .disclosureIndicator
        
        let movieImageWidth: CGFloat = 80
        let movieImageHeight: CGFloat = 120
        let movieImageOffsetX: CGFloat = 15
        let movieImageOffsetY: CGFloat = 8
        
        movieImage = UIImageView()
        movieImage.frame = CGRect(x: movieImageOffsetX, y: movieImageOffsetY, width: movieImageWidth, height: movieImageHeight)
        movieImage.layer.cornerRadius = 5
        movieImage.clipsToBounds = true
        movieImage.image = UIImage(named: "loading")
        contentView.addSubview(movieImage)
        
        let movieNameWidth: CGFloat = screenWidth - (movieImage.frame.maxX + (2 * movieImageOffsetX))
        let movieNameHeight: CGFloat = 25
        let movieNameOffsetX: CGFloat = movieImage.frame.maxX + movieImageOffsetX
        let movieNameOffsetY: CGFloat = movieImageOffsetY + 2
        
        movieName = UILabel()
        movieName.frame = CGRect(x: movieNameOffsetX, y: movieNameOffsetY, width: movieNameWidth, height: movieNameHeight)
        movieName.font = UIFont.boldSystemFont(ofSize: 18)
//        movieName.backgroundColor = .orange
        contentView.addSubview(movieName)
        
        let ticketInfoWidth: CGFloat = screenWidth - (movieImage.frame.maxX + (2 * movieImageOffsetX))
        let ticketInfoHeight: CGFloat = 25
        let ticketInfoOffsetX: CGFloat = movieImage.frame.maxX + movieImageOffsetX
        let ticketInfoOffsetY: CGFloat = movieName.frame.maxY + 5
        
        ticketInfo = UILabel()
        ticketInfo.frame = CGRect(x: ticketInfoOffsetX, y: ticketInfoOffsetY, width: ticketInfoWidth, height: ticketInfoHeight)
        ticketInfo.font = UIFont.italicSystemFont(ofSize: 14)
//        ticketInfo.backgroundColor = .orange
        contentView.addSubview(ticketInfo)
        
        let purchasedDateWidth: CGFloat = screenWidth - (movieImage.frame.maxX + (2 * movieImageOffsetX))
        let purchasedDateHeight: CGFloat = 25
        let purchasedDateOffsetX: CGFloat = movieImage.frame.maxX + movieImageOffsetX
        let purchasedDateOffsetY: CGFloat = ticketInfo.frame.maxY + 5
        
        purchasedDate = UILabel()
        purchasedDate.frame = CGRect(x: purchasedDateOffsetX, y: purchasedDateOffsetY, width: purchasedDateWidth, height: purchasedDateHeight)
        purchasedDate.font = UIFont.italicSystemFont(ofSize: 14)
//        purchasedDate.backgroundColor = .orange
        contentView.addSubview(purchasedDate)
        
        let receiptCodeWidth: CGFloat = screenWidth - (movieImage.frame.maxX + (2 * movieImageOffsetX))
        let receiptCodeHeight: CGFloat = 25
        let receiptCodeOffsetX: CGFloat = movieImage.frame.maxX + movieImageOffsetX
        let receiptCodeOffsetY: CGFloat = purchasedDate.frame.maxY + 5
        
        receiptCode = UILabel()
        receiptCode.frame = CGRect(x: receiptCodeOffsetX, y: receiptCodeOffsetY, width: receiptCodeWidth, height: receiptCodeHeight)
        receiptCode.font = UIFont.italicSystemFont(ofSize: 14)
//        receiptCode.backgroundColor = .orange
        contentView.addSubview(receiptCode)
    }
}

