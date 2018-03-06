//
//  CinemaCollectionCell.swift
//  Cinematic
//
//  Created by Khant Zaw Ko on 20/2/18.
//  Copyright © 2018 Khant Zaw Ko. All rights reserved.
//

import UIKit

class CinemaCollectionCell: UICollectionViewCell {
    
    let cinemaName: UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor(red:1.00, green:0.14, blue:0.40, alpha:1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupLayout() {
        cinemaName.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        cinemaName.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 15
        layer.borderWidth = 2
        layer.borderColor = UIColor.cinematicPink
        layer.backgroundColor = UIColor.white.cgColor
        addSubview(cinemaName)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
