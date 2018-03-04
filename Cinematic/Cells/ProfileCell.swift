//
//  ProfileCell.swift
//  Cinematic
//
//  Created by Khant Zaw Ko on 22/2/18.
//  Copyright © 2018 Khant Zaw Ko. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {
    
    private var attributedText: NSMutableAttributedString?
    
    var movie: Movie? {
        didSet {
            guard let unwrappedMovie = movie else {return}
            movieImageView.image = #imageLiteral(resourceName: "loading")
//            movieImageView.downloadedFrom(link: unwrappedMovie.image)
            movieImageView.loadImage(urlString: unwrappedMovie.image!)
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 3
            
            attributedText = NSMutableAttributedString(string: unwrappedMovie.name!, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedStringKey.paragraphStyle: paragraphStyle])
        }
    }
    
    var movieInfoText: String? {
        didSet {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 3
            
            guard let unwrappedMovieInfoText = movieInfoText else {return}
            
            attributedText?.append(NSAttributedString(string: unwrappedMovieInfoText, attributes: [NSAttributedStringKey.font: UIFont.italicSystemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.gray, NSAttributedStringKey.paragraphStyle: paragraphStyle]))
            movieInfoTextView.attributedText = attributedText
        }
    }
    
    private let movieImageView: CachedImageView = {
        let imageView = CachedImageView()
        imageView.image = #imageLiteral(resourceName: "loading")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let movieInfoTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.isSelectable = false
        textView.isUserInteractionEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private func setupLayout() {
        movieImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        movieImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        movieImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        
        movieInfoTextView.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 5).isActive = true
        movieInfoTextView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        movieInfoTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        movieInfoTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        accessoryType = .disclosureIndicator
        addSubview(movieImageView)
        addSubview(movieInfoTextView)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
