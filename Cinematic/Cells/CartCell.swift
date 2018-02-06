//
//  CartCell.swift
//  Cinematic
//
//  Created by Khant Zaw Ko on 4/1/18.
//  Copyright © 2018 Khant Zaw Ko. All rights reserved.
//

import UIKit

var selectedTicketLabelArray = [String]()
var selectedTicketInfoArray = [String]()

var selectedSeatInfoArray = [String]()
var selectedSeatPriceArray = [String]()
var selectedAccumulatedSeatPriceArray = [String]()

class CartCell: UITableViewCell {
    
    var viewSeatButton: UIButton!
    
    var screenSize = UIScreen.main.bounds
    var screenWidth = UIScreen.main.bounds.width
    var screenHeight = UIScreen.main.bounds.height
    let totalButton = UIButton()

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        if reuseIdentifier == "MovieInfoCell" {
            
            let ticketLabelOffsetX: CGFloat = 20
            let ticketLabelOffsetY: CGFloat = 4
            let ticketLabelWidth: CGFloat = (screenWidth * 0.4) - ticketLabelOffsetX
            let ticketLabelHeight: CGFloat = 20
            let ticketLabelVerticalTotalSpacing: CGFloat = ticketLabelHeight + ticketLabelOffsetY
            
            let ticketInfoOffsetX: CGFloat = ticketLabelWidth + 4
            let ticketInfoOffsetY: CGFloat = 4
            let ticketInfoWidth: CGFloat = (screenWidth * 0.6) - 4
            let ticketInfoHeight: CGFloat = 20
            let ticketInfoVerticalTotalSpacing: CGFloat = ticketInfoHeight + ticketInfoOffsetY
            
            for index in 1...selectedTicketLabelArray.count {
                let ticketLabel = UILabel()
                ticketLabel.frame = CGRect(x: ticketLabelOffsetX, y: 10 + (CGFloat(index-1) * ticketLabelVerticalTotalSpacing), width: ticketLabelWidth, height: ticketLabelHeight)
                ticketLabel.text = selectedTicketLabelArray[index-1]
                ticketLabel.textColor = .gray
                ticketLabel.font = UIFont.boldSystemFont(ofSize: 14)
                contentView.addSubview(ticketLabel)
                
            }
            
            for index in 1...selectedTicketInfoArray.count {
                let ticketInfo = UILabel()
                ticketInfo.frame = CGRect(x: ticketInfoOffsetX, y: 10 + (CGFloat(index-1) * ticketInfoVerticalTotalSpacing), width: ticketInfoWidth, height: ticketInfoHeight)
                ticketInfo.text = selectedTicketInfoArray[index-1]
                ticketInfo.font = UIFont.boldSystemFont(ofSize: 14)
                contentView.addSubview(ticketInfo)
            }
            
        } else if reuseIdentifier == "TicketInfoCell" {

//            let viewSeatOffsetX: CGFloat = screenWidth - 15
//            let viewSeatOffsetY: CGFloat = 4
//            let viewSeatWidth: CGFloat = 90
//            let viewSeatHeight: CGFloat = 25
//
//            viewSeatButton = UIButton()
//            viewSeatButton.frame = CGRect(x: viewSeatOffsetX - viewSeatWidth, y: viewSeatOffsetY, width: viewSeatWidth, height: viewSeatHeight)
//            viewSeatButton.backgroundColor = UIColor(red:1.00, green:0.14, blue:0.40, alpha:1.0)
//            viewSeatButton.layer.cornerRadius = 5
//            viewSeatButton.titleEdgeInsets.bottom = 2
//            contentView.addSubview(viewSeatButton)
            
            let seatInfoOffsetX: CGFloat = 20
            let seatInfoOffsetY: CGFloat = 4
            let seatInfoWidth: CGFloat = screenWidth - (2 * seatInfoOffsetX)
            let seatInfoHeight: CGFloat = 20
            let seatInfoVerticalTotalSpacing: CGFloat = seatInfoHeight + seatInfoOffsetY
            
            let seatPriceOffsetX: CGFloat = 20
            let seatPriceOffsetY: CGFloat = 4
            let seatPriceWidth: CGFloat = (screenWidth * 0.5) - seatPriceOffsetX
            let seatPriceHeight: CGFloat = 20
            let seatPriceVerticalTotalSpacing: CGFloat = seatPriceHeight + seatPriceOffsetY
            
            let seatAccumulatePriceOffsetX: CGFloat = seatPriceWidth + 20
            let seatAccumulatePriceOffsetY: CGFloat = 4
            let seatAccumulatePriceWidth: CGFloat = (screenWidth * 0.5) - 20
            let seatAccumulatePriceHeight: CGFloat = 20
            let seatAccumulatePriceVerticalTotalSpacing: CGFloat = seatAccumulatePriceHeight + seatAccumulatePriceOffsetY
            
            for index in 1...selectedSeatInfoArray.count {
                let seatInfoLabel = UILabel()
                seatInfoLabel.frame = CGRect(x: seatInfoOffsetX, y: 10 + (CGFloat(index-1) * seatInfoVerticalTotalSpacing), width: seatInfoWidth, height: seatInfoHeight)
                seatInfoLabel.textColor = UIColor.black
                seatInfoLabel.font = UIFont.boldSystemFont(ofSize: 14)
                seatInfoLabel.text =  "Seat: " + selectedSeatInfoArray[index-1]
                contentView.addSubview(seatInfoLabel)
            }
            
            for index in 1...selectedSeatPriceArray.count {
                let seatPriceLabel = UILabel()
                seatPriceLabel.frame = CGRect(x: seatPriceOffsetX, y: 10 + seatPriceVerticalTotalSpacing - 4, width: seatPriceWidth, height: seatPriceHeight)
                seatPriceLabel.textColor = .gray
                seatPriceLabel.font = UIFont.boldSystemFont(ofSize: 12)
                seatPriceLabel.text = selectedSeatPriceArray[index-1]
                contentView.addSubview(seatPriceLabel)
                
                let seatAccumulatePrice = UILabel()
                seatAccumulatePrice.frame = CGRect(x: seatAccumulatePriceOffsetX, y: 10 + seatAccumulatePriceVerticalTotalSpacing - 4, width: seatAccumulatePriceWidth, height: seatAccumulatePriceHeight)
                seatAccumulatePrice.textColor = .gray
                seatAccumulatePrice.font = UIFont.boldSystemFont(ofSize: 12)
                seatAccumulatePrice.text = "16,500 Kyats"
                seatAccumulatePrice.textAlignment = .right
                contentView.addSubview(seatAccumulatePrice)
            }
            
        } else {
            
        }
    }
}
