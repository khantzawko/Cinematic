//
//  MovieCell.swift
//  Cinematic
//
//  Created by Khant Zaw Ko on 14/2/18.
//  Copyright © 2018 Khant Zaw Ko. All rights reserved.
//

import UIKit

var ratings = Double()

class MovieCell: UITableViewCell {
    
    var movie: Movie? {
        didSet {
            guard let unwrappedMovie = movie else { return }
//            movieImageView.downloadedFrom(link: unwrappedMovie.image)
            movieImageView.image = #imageLiteral(resourceName: "loading")
            movieImageView.loadImage(urlString: unwrappedMovie.image!)
            
            let attributedText = NSMutableAttributedString(string: unwrappedMovie.name!, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18)])
            attributedText.append(NSAttributedString(string: "\n\(unwrappedMovie.duration!) mins", attributes: [NSAttributedStringKey.font: UIFont.italicSystemFont(ofSize: 13), NSAttributedStringKey.foregroundColor: UIColor.gray]))
            
            movieName.attributedText = attributedText
            movieGenre.text = unwrappedMovie.genre
        }
    }
    
    private let movieImageView: CachedImageView = {
        let imageView = CachedImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let movieName: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "Movie Name", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18)])
        attributedText.append(NSAttributedString(string: "0 min", attributes: [NSAttributedStringKey.font: UIFont.italicSystemFont(ofSize: 13), NSAttributedStringKey.foregroundColor: UIColor.gray]))
        textView.attributedText = attributedText
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.isSelectable = false
        textView.isUserInteractionEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let movieGenre: UILabel = {
        let label = UILabel()
        label.text = "Movie Genre"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private func setupLayout() {
        movieImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        movieImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        movieImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        
        movieName.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 5).isActive = true
        movieName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        movieName.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        movieGenre.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 10).isActive = true
        movieGenre.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        movieGenre.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
    }
    
    private func setupMovieRatingLayout() {
        
        if isHalfStar(num: ratings) {
            ratings += 1
        }
        
        for rating in 0..<Int(ratings) {
            let movieRatingStar = UIImageView()
            movieRatingStar.translatesAutoresizingMaskIntoConstraints = false
            movieRatingStar.tintColor = .orange
            
            addSubview(movieRatingStar)
            
            movieRatingStar.widthAnchor.constraint(equalToConstant: 15).isActive = true
            movieRatingStar.heightAnchor.constraint(equalToConstant: 15).isActive = true
            movieRatingStar.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: CGFloat(10 + ((15 + 2) * rating))).isActive = true
            movieRatingStar.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
            movieRatingStar.image = UIImage(named: "star.png")?.withRenderingMode(.alwaysTemplate)
            
            if rating == Int(ratings-1) && isHalfStar(num: ratings) {
                
                movieRatingStar.image = UIImage(named: "halfstar.png")?.withRenderingMode(.alwaysTemplate)
                
                let label = UILabel()
                label.text = "(\(ratings-1) stars)"
                label.font = UIFont.italicSystemFont(ofSize: 13)
                label.textColor = .gray
                label.translatesAutoresizingMaskIntoConstraints = false
                addSubview(label)
                
                label.heightAnchor.constraint(equalToConstant: 15).isActive = true
                label.leadingAnchor.constraint(equalTo: movieRatingStar.trailingAnchor, constant: -5).isActive = true
                label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
                label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
            } else if rating == Int(ratings-1) {
                let label = UILabel()
                label.text = "(\(ratings) stars)"
                label.font = UIFont.italicSystemFont(ofSize: 13)
                label.textColor = .gray
                label.translatesAutoresizingMaskIntoConstraints = false
                addSubview(label)
                
                label.heightAnchor.constraint(equalToConstant: 15).isActive = true
                label.leadingAnchor.constraint(equalTo: movieRatingStar.trailingAnchor, constant: 2).isActive = true
                label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
                label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
            }
        }
    }
    
    private func isHalfStar(num: Double) -> Bool {
        if num.truncatingRemainder(dividingBy: 1) < 0.5 {
            return false
        } else {
            return true
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
        addSubview(movieImageView)
        addSubview(movieName)
        addSubview(movieGenre)
        
        setupLayout()
        setupMovieRatingLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

