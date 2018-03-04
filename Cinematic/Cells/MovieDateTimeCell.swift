//
//  MovieDateTimeCell.swift
//  Cinematic
//
//  Created by Khant Zaw Ko on 21/2/18.
//  Copyright © 2018 Khant Zaw Ko. All rights reserved.
//

import UIKit

class MovieDateTimeCell: UITableViewCell {
    
    private let attributedText = NSMutableAttributedString(string: "Select Seats:", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16)])
    
    var movie: Movie? {
        didSet {
            guard let unwrappedMovie = movie else { return }
            movieImage.downloadedFrom(link: unwrappedMovie.image!)
            movieName.text = unwrappedMovie.name
        }
    }
    
    var selectedTickets: String? {
        didSet {
            attributedText.append(NSAttributedString(string: "\n\nSeats: \(selectedTickets!)", attributes: [NSAttributedStringKey.font: UIFont.italicSystemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.gray]))
        }
    }
    var selectedTicketsPrice: CGFloat? {
        didSet {
            attributedText.append(NSAttributedString(string: "\nTotal: $\(selectedTicketsPrice!/100)", attributes: [NSAttributedStringKey.font: UIFont.italicSystemFont(ofSize: 15), NSAttributedStringKey.foregroundColor: UIColor.gray]))
            selectSeatInfo.attributedText = attributedText
        }
    }
    
    private let movieImage: UIImageView = {
        let imageView = UIImageView(image:#imageLiteral(resourceName: "loading"))
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

    private let movieDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Select Date:"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var movieDateCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
        layout.itemSize = CGSize(width: 100, height: 50)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let movieTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Select Time:"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var movieTimeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
        layout.itemSize = CGSize(width: 100, height: 50)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var selectSeatInfo: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "Select Seats:", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16)])
        textView.attributedText = attributedText
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.isSelectable = false
        textView.isUserInteractionEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    lazy var selectSeatButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.titleEdgeInsets.top = -4
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.backgroundColor = UIColor(red:1.00, green:0.14, blue:0.40, alpha:1.0)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(pressedSelectSeat), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func pressedSelectSeat() {
        let seatsPlanController = SeatsPlanController()
        window?.rootViewController?.present(seatsPlanController, animated: true, completion: nil)
    }
    
    private func setupLayout() {
        movieImage.widthAnchor.constraint(equalToConstant: 80).isActive = true
        movieImage.heightAnchor.constraint(equalToConstant: 120).isActive = true
        movieImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        movieImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        
        movieName.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 10).isActive = true
        movieName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        movieName.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func setupDateLayout() {
        movieDateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18).isActive = true
        movieDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        movieDateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        movieDateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        movieDateCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        movieDateCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        movieDateCollectionView.topAnchor.constraint(equalTo: movieDateLabel.bottomAnchor, constant: 0).isActive = true
        movieDateCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        movieDateCollectionView.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    private func setupTimeLayout() {
        movieTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18).isActive = true
        movieTimeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        movieTimeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        movieTimeLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        movieTimeCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        movieTimeCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        movieTimeCollectionView.topAnchor.constraint(equalTo: movieTimeLabel.bottomAnchor, constant: 0).isActive = true
        movieTimeCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        movieTimeCollectionView.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    private func setupSelectSeatLayout() {
        selectSeatButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        selectSeatButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        selectSeatButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        selectSeatButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        
        selectSeatInfo.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        selectSeatInfo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14).isActive = true
        selectSeatInfo.trailingAnchor.constraint(equalTo: selectSeatButton.leadingAnchor, constant: -10).isActive = true
        selectSeatInfo.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        if reuseIdentifier == "Movie" {
            addSubview(movieImage)
            addSubview(movieName)
            setupLayout()
        } else if reuseIdentifier == "Date" {
            addSubview(movieDateLabel)
            addSubview(movieDateCollectionView)
            
            movieDateCollectionView.delegate = self
            movieDateCollectionView.dataSource = self
            movieDateCollectionView.showsHorizontalScrollIndicator = false
            movieDateCollectionView.showsVerticalScrollIndicator = false
            movieDateCollectionView.register(MovieDateCollectionCell.self, forCellWithReuseIdentifier: "MovieDateCollectionCell")
            
            setupDateLayout()
        } else if reuseIdentifier == "Time" {
            addSubview(movieTimeLabel)
            addSubview(movieTimeCollectionView)
            
            movieTimeCollectionView.delegate = self
            movieTimeCollectionView.dataSource = self
            movieTimeCollectionView.showsHorizontalScrollIndicator = false
            movieTimeCollectionView.showsVerticalScrollIndicator = false
            movieTimeCollectionView.register(MovieTimeCollectionCell.self, forCellWithReuseIdentifier: "MovieTimeCollectionCell")

            setupTimeLayout()
        } else if reuseIdentifier == "Seat" {
            addSubview(selectSeatInfo)
            addSubview(selectSeatButton)
            setupSelectSeatLayout()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
