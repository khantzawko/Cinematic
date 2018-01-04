//
//  SeatsPlanCell.swift
//  Cinematic
//
//  Created by Khant Zaw Ko on 31/12/17.
//  Copyright © 2017 Khant Zaw Ko. All rights reserved.
//

import UIKit

var selectedSeats = [String]()
var numbersOfSeatsInARow: Int?

class SeatsPlanCell: UITableViewCell {

    var label1: UILabel!
    var label2: UILabel!
    var testNumber = 10
    
    let screenSize = UIScreen.main.bounds
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectedSeats.removeAll()
                
        print(testNumber)
        
        let labelWidth: CGFloat = 30
        let labelHeight: CGFloat = 30
        let labelOffsetX: CGFloat = 6
        let labelOffsetY: CGFloat = 6
        let seatWidth: CGFloat = 30
        let seatHeight: CGFloat = 30
        let spacingBetweenLabelAndSeat: CGFloat = 10
        let spacingBetweenSeats: CGFloat = 3
        let spacingBeforeAndAfterSeats: CGFloat = labelWidth + labelOffsetX + spacingBetweenLabelAndSeat
        let spacingWidthLeftForSeats = screenWidth - (2 * spacingBeforeAndAfterSeats) // 571
        let seatsPerRow: CGFloat = CGFloat(numbersOfSeatsInARow!)
        let startingPointX = spacingBeforeAndAfterSeats + (spacingWidthLeftForSeats - (spacingBetweenSeats * (seatsPerRow - 1)) - (seatWidth * seatsPerRow))/2
        
        label1 = UILabel()
        label1.frame = CGRect(x: labelOffsetX, y: labelOffsetY, width: labelWidth, height: labelHeight)
        label1.textColor = UIColor.white
        label1.backgroundColor = UIColor.black
        label1.textAlignment = .center
        label1.layer.cornerRadius = 5
        label1.layer.masksToBounds = true
        contentView.addSubview(label1)
        
        label2 = UILabel()
        label2.frame = CGRect(x: screenWidth-labelWidth-labelOffsetX, y: labelOffsetY, width: labelWidth, height: labelHeight)
        label2.textColor = UIColor.white
        label2.backgroundColor = UIColor.black
        label2.textAlignment = .center
        label2.layer.masksToBounds = true
        label2.layer.cornerRadius = 5
        contentView.addSubview(label2)
        
        for index in 1...numbersOfSeatsInARow! {
            let seatButton = UIButton()
            seatButton.frame = CGRect(x: startingPointX + ((seatWidth + spacingBetweenSeats) * CGFloat(index-1)), y: labelOffsetY, width: seatWidth, height: seatHeight)
            seatButton.setTitle("\(index)", for: .normal)
            seatButton.backgroundColor = UIColor.green
            seatButton.titleLabel?.textAlignment = .center
            seatButton.layer.cornerRadius = 5
            seatButton.layer.masksToBounds = true
            seatButton.addTarget(self, action: #selector(self.pressedButton(_:)), for: .touchUpInside)
            contentView.addSubview(seatButton)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func pressedButton(_ sender: UIButton){
        
        let currentlySelectedSeat: String = label1.text! + (sender.titleLabel?.text)!

        if sender.backgroundColor == UIColor.green {
            sender.backgroundColor = UIColor.blue
            selectedSeats.append(currentlySelectedSeat)
        } else if sender.backgroundColor == UIColor.blue {
            sender.backgroundColor = UIColor.green
            if let i = selectedSeats.index(of: currentlySelectedSeat) {
                selectedSeats.remove(at: i)
            }
        } else {
            // red/reserve and do nth
        }

    }
}
