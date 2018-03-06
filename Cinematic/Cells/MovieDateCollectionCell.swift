//
//  MovieDateCollectionCell.swift
//  Cinematic
//
//  Created by Khant Zaw Ko on 21/2/18.
//  Copyright © 2018 Khant Zaw Ko. All rights reserved.
//

import UIKit

class MovieDateCollectionCell: UICollectionViewCell {
    let movieDate: UILabel = {
        let label = UILabel()
        label.text = "Date"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor(red:1.00, green:0.14, blue:0.40, alpha:1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupLayout() {
        movieDate.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        movieDate.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 15
        layer.borderWidth = 2
        layer.borderColor = UIColor.cinematicPink
        layer.backgroundColor = UIColor.white.cgColor
        addSubview(movieDate)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
