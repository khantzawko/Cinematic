//
//  MovieDetailCell.swift
//  Cinematic
//
//  Created by Khant Zaw Ko on 20/2/18.
//  Copyright © 2018 Khant Zaw Ko. All rights reserved.
//

import UIKit

class MovieDetailCell: UITableViewCell {
    
    var movie: Movie? {
        didSet {
            guard let unwrappedMovie = movie else { return }
//            movieImageView.downloadedFrom(link: unwrappedMovie.image)
            movieImageView.loadImage(urlString: unwrappedMovie.image!)

            movieName.text = unwrappedMovie.name
            
            let headerStyle = NSMutableParagraphStyle()
            headerStyle.lineSpacing = 8
            
            let bodyStyle = NSMutableParagraphStyle()
            bodyStyle.lineSpacing = 2
            
            let attributedText = NSMutableAttributedString(string: "Plot", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedStringKey.paragraphStyle: headerStyle])
            attributedText.append(NSAttributedString(string: "\n\(unwrappedMovie.info!)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15), NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.paragraphStyle: bodyStyle]))
            
            moviePlot.attributedText = attributedText
            
            unwrappedMovie.trailer == "nil" ? (movieTrailer.isHidden = true) : (movieTrailer.isHidden = false)
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
    
    private let movieName: UILabel = {
        let label = UILabel()
        label.text = "Movie Name"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var movieTrailer: UIButton = {
        let button = UIButton()
        button.setTitle("Trailer", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.backgroundColor = UIColor(red:1.00, green:0.14, blue:0.40, alpha:1.0)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(pressedTrailer(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let moviePlot: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.isSelectable = false
        textView.isUserInteractionEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let cinemaLabel: UILabel = {
        let label = UILabel()
        label.text = "Cinemas"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var cinemaCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
        layout.itemSize = CGSize(width: 150, height: 50)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    @objc private func pressedTrailer(_ sender: UIButton) {
        guard let unwrappedMovie = movie else { return }
        let videoPlayerController = VideoPlayerController()
        videoPlayerController.trailerURL = unwrappedMovie.trailer
        window?.rootViewController?.present(videoPlayerController, animated: true, completion: nil)
    }
    
    private func setupLayout() {
        movieImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        movieImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        movieImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        
        movieName.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 10).isActive = true
        movieName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        movieName.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        movieTrailer.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 10).isActive = true
        movieTrailer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        movieTrailer.widthAnchor.constraint(equalToConstant: 80).isActive = true
        movieTrailer.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func setupInfoLayout() {
        moviePlot.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        moviePlot.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        moviePlot.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        moviePlot.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
    
    private func setupCinemaLayout() {
        cinemaLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18).isActive = true
        cinemaLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        cinemaLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        cinemaLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        cinemaCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        cinemaCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        cinemaCollectionView.topAnchor.constraint(equalTo: cinemaLabel.bottomAnchor, constant: 0).isActive = true
        cinemaCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        cinemaCollectionView.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        if reuseIdentifier == "Header" {
            addSubview(movieImageView)
            addSubview(movieName)
            addSubview(movieTrailer)
            setupLayout()
        } else if reuseIdentifier == "Plot" {
            addSubview(moviePlot)
            setupInfoLayout()
        } else if reuseIdentifier == "Cinema" {
            addSubview(cinemaLabel)
            addSubview(cinemaCollectionView)
            cinemaCollectionView.showsHorizontalScrollIndicator = false
            cinemaCollectionView.showsVerticalScrollIndicator = false
            cinemaCollectionView.delegate = self
            cinemaCollectionView.dataSource = self
            cinemaCollectionView.register(CinemaCollectionCell.self, forCellWithReuseIdentifier: "CinemaCollectionCell")
            setupCinemaLayout()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
