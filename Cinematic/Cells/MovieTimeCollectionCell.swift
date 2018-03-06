//
//  MovieTimeCollectionCell.swift
//  Cinematic
//
//  Created by Khant Zaw Ko on 21/2/18.
//  Copyright © 2018 Khant Zaw Ko. All rights reserved.
//

import UIKit

class MovieTimeCollectionCell: UICollectionViewCell {
    
    let movieTime: UILabel = {
        let label = UILabel()
        label.text = "Time"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor(red:1.00, green:0.14, blue:0.40, alpha:1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupLayout() {
        movieTime.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        movieTime.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 15
        layer.borderWidth = 2
        layer.borderColor = UIColor.cinematicPink
        layer.backgroundColor = UIColor.white.cgColor
        addSubview(movieTime)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
