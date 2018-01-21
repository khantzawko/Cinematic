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
    
    var headingTicketInfoLabel: UILabel!
    
    var screenSize = UIScreen.main.bounds
    var screenWidth = UIScreen.main.bounds.width
    var screenHeight = UIScreen.main.bounds.height
    let totalButton = UIButton()

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        if reuseIdentifier == "TicketInfoCell" {

            let headingOffsetX: CGFloat = 15
            let headingOffsetY: CGFloat = 4
            let headingWidth: CGFloat = screenWidth - (2 * headingOffsetX)
            let headingHeight: CGFloat = 20
            let headingVerticalTotalSpacing: CGFloat = headingHeight + (2 * headingOffsetY)
            
            headingTicketInfoLabel = UILabel()
            headingTicketInfoLabel.frame = CGRect(x: headingOffsetX, y: headingOffsetY, width: headingWidth, height: headingHeight)
            headingTicketInfoLabel.textColor = UIColor.black
            headingTicketInfoLabel.font = UIFont.boldSystemFont(ofSize: 16)
            contentView.addSubview(headingTicketInfoLabel)
            
            let ticketLabelOffsetX: CGFloat = headingOffsetX + 4
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
                ticketLabel.frame = CGRect(x: ticketLabelOffsetX, y: headingVerticalTotalSpacing + (CGFloat(index-1) * ticketLabelVerticalTotalSpacing), width: ticketLabelWidth, height: ticketLabelHeight)
                ticketLabel.text = selectedTicketLabelArray[index-1]
                ticketLabel.textColor = .gray
                ticketLabel.font = UIFont.boldSystemFont(ofSize: 14)
                contentView.addSubview(ticketLabel)
                
            }
            
            for index in 1...selectedTicketInfoArray.count {
                let ticketInfo = UILabel()
                ticketInfo.frame = CGRect(x: ticketInfoOffsetX, y: headingVerticalTotalSpacing + (CGFloat(index-1) * ticketInfoVerticalTotalSpacing), width: ticketInfoWidth, height: ticketInfoHeight)
                ticketInfo.text = selectedTicketInfoArray[index-1]
                ticketInfo.font = UIFont.boldSystemFont(ofSize: 14)
                contentView.addSubview(ticketInfo)
            }
            
        } else if reuseIdentifier == "TicketPriceCell" {

            let headingOffsetX: CGFloat = 15
            let headingOffsetY: CGFloat = 4
            let headingWidth: CGFloat = screenWidth - (2 * headingOffsetX)
            let headingHeight: CGFloat = 20
            let headingVerticalTotalSpacing: CGFloat = headingHeight + (2 * headingOffsetY)
            
            headingTicketInfoLabel = UILabel()
            headingTicketInfoLabel.frame = CGRect(x: headingOffsetX, y: headingOffsetY, width: headingWidth, height: headingHeight)
            headingTicketInfoLabel.textColor = UIColor.black
            headingTicketInfoLabel.font = UIFont.boldSystemFont(ofSize: 16)
            contentView.addSubview(headingTicketInfoLabel)
            
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
                seatInfoLabel.frame = CGRect(x: seatInfoOffsetX, y: headingVerticalTotalSpacing + (CGFloat(index-1) * seatInfoVerticalTotalSpacing), width: seatInfoWidth, height: seatInfoHeight)
                seatInfoLabel.textColor = UIColor.black
                seatInfoLabel.font = UIFont.boldSystemFont(ofSize: 14)
                seatInfoLabel.text =  "Seat: " + selectedSeatInfoArray[index-1]
                contentView.addSubview(seatInfoLabel)
            }
            
            for index in 1...selectedSeatPriceArray.count {
                let seatPriceLabel = UILabel()
                seatPriceLabel.frame = CGRect(x: seatPriceOffsetX, y: headingVerticalTotalSpacing + seatPriceVerticalTotalSpacing - 4, width: seatPriceWidth, height: seatPriceHeight)
                seatPriceLabel.textColor = .gray
                seatPriceLabel.font = UIFont.boldSystemFont(ofSize: 12)
                seatPriceLabel.text = selectedSeatPriceArray[index-1]
                contentView.addSubview(seatPriceLabel)
                
                let seatAccumulatePrice = UILabel()
                seatAccumulatePrice.frame = CGRect(x: seatAccumulatePriceOffsetX, y: headingVerticalTotalSpacing + seatAccumulatePriceVerticalTotalSpacing - 4, width: seatAccumulatePriceWidth, height: seatAccumulatePriceHeight)
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
