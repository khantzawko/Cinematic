//
//  MovieCell.swift
//  Cinematic
//
//  Created by Khant Zaw Ko on 12/12/17.
//  Copyright © 2017 Khant Zaw Ko. All rights reserved.
//

import UIKit

var movieRating: Int!

class MovieCell: UITableViewCell {
    
    let screenSize = UIScreen.main.bounds
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var movieImage: UIImageView!
    var movieTitle: UILabel!
    var movieDuration: UILabel!
    var movieGenre: UILabel!
    
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

        let movieGenreWidth: CGFloat = screenWidth - ((2 * movieImageOffsetX) + movieImageWidth + 10)
        let movieGenreHeight: CGFloat = 20
        let movieGenreOffsetX: CGFloat = movieImageOffsetX + movieImageWidth + 10
        let movieGenreOffsetY: CGFloat = movieImageOffsetY

        let movieTitleWidth: CGFloat = screenWidth - ((2 * movieImageOffsetX) + movieImageWidth + 10)
        let movieTitleHeight: CGFloat = 25
        let movieTitleOffsetX: CGFloat = movieGenreOffsetX
        let movieTitleOffsetY: CGFloat = ((2 * movieImageOffsetY) + movieImageHeight - movieTitleHeight)/2
        
        let movieDurationWidth: CGFloat = 100
        let movieDurationHeight: CGFloat = 12
        let movieDurationOffsetX: CGFloat = movieGenreOffsetX
        let movieDurationOffsetY: CGFloat = (((2 * movieImageOffsetY) + movieImageHeight - movieTitleHeight)/2) + movieTitleHeight
        
        movieImage = UIImageView()
        movieImage.frame = CGRect(x: movieImageOffsetX, y: movieImageOffsetY, width: movieImageWidth, height: movieImageHeight)
        movieImage.layer.cornerRadius = 5
        movieImage.clipsToBounds = true
        contentView.addSubview(movieImage)
        
        movieGenre = UILabel()
        movieGenre.frame = CGRect(x: movieGenreOffsetX, y: movieGenreOffsetY, width: movieGenreWidth, height: movieGenreHeight)
        movieGenre.font = UIFont.boldSystemFont(ofSize: 13)
        contentView.addSubview(movieGenre)
        
        movieTitle = UILabel()
        movieTitle.frame = CGRect(x: movieTitleOffsetX, y: movieTitleOffsetY, width: movieTitleWidth, height: movieTitleHeight)
        movieTitle.font = UIFont.boldSystemFont(ofSize: 20)
        contentView.addSubview(movieTitle)
        
        movieDuration = UILabel()
        movieDuration.frame = CGRect(x: movieDurationOffsetX, y: movieDurationOffsetY, width: movieDurationWidth, height: movieDurationHeight)
        movieDuration.font = UIFont.italicSystemFont(ofSize: 12)
        movieDuration.textColor = .gray
        contentView.addSubview(movieDuration)
                
        for index in 0..<movieRating {
            let ratingImageWidth: CGFloat = 15
            let ratingImageHeight: CGFloat = 15
            let ratingImageSpacingInBetween: CGFloat = 2
            let num: CGFloat = (ratingImageWidth + ratingImageSpacingInBetween) * CGFloat(index)
            let ratingImageOffsetX: CGFloat = movieImageOffsetX + movieImageWidth + 10 + num
            let ratingImageOffsetY: CGFloat = movieImageOffsetY + movieImageHeight - ratingImageHeight - 2
            
            let ratingImageView = UIImageView()
            ratingImageView.frame = CGRect(x: ratingImageOffsetX, y: ratingImageOffsetY, width: ratingImageWidth, height: ratingImageHeight)
            ratingImageView.image = UIImage(named: "star.png")?.withRenderingMode(.alwaysTemplate)
            ratingImageView.tintColor = .orange
            contentView.addSubview(ratingImageView)
        }
        
    }
    

    
}
