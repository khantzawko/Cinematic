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

class CartCell: UITableViewCell {
    
    var headingTicketInfoLabel: UILabel!
    
    var screenSize = UIScreen.main.bounds
    var screenWidth = UIScreen.main.bounds.width
    var screenHeight = UIScreen.main.bounds.height

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let headingOffsetX: CGFloat = 15
        let headingOffsetY: CGFloat = 4
        let headingWidth: CGFloat = screenWidth - (2 * headingOffsetX)
        let headingHeight: CGFloat = 20
        let headingVerticalTotalSpacing: CGFloat = headingHeight + (2 * headingOffsetY)
        
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

        headingTicketInfoLabel = UILabel()
        headingTicketInfoLabel.frame = CGRect(x: headingOffsetX, y: headingOffsetY, width: headingWidth, height: headingHeight)
        headingTicketInfoLabel.textColor = UIColor.black
        headingTicketInfoLabel.font = UIFont.boldSystemFont(ofSize: 18)
        contentView.addSubview(headingTicketInfoLabel)
    
        for index in 1...selectedTicketLabelArray.count {
            let ticketLabel = UILabel()
            ticketLabel.frame = CGRect(x: ticketLabelOffsetX, y: headingVerticalTotalSpacing + (CGFloat(index-1) * ticketLabelVerticalTotalSpacing), width: ticketLabelWidth, height: ticketLabelHeight)
            ticketLabel.backgroundColor = .orange
            ticketLabel.text = selectedTicketLabelArray[index-1]
            contentView.addSubview(ticketLabel)
            
        }
        
        for index in 1...selectedTicketInfoArray.count {
            let ticketInfo = UILabel()
            ticketInfo.frame = CGRect(x: ticketInfoOffsetX, y: headingVerticalTotalSpacing + (CGFloat(index-1) * ticketInfoVerticalTotalSpacing), width: ticketInfoWidth, height: ticketInfoHeight)
            ticketInfo.backgroundColor = .green
            ticketInfo.text = selectedTicketInfoArray[index-1]
            contentView.addSubview(ticketInfo)
            
        }
        
    }
    

    
}
