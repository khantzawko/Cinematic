//
//  SeatsPlanController.swift
//  Cinematic
//
//  Created by Khant Zaw Ko on 25/2/18.
//  Copyright © 2018 Khant Zaw Ko. All rights reserved.
//

import UIKit

private var selectedTickets: [String] = []
private var selectedTicketsPrice: CGFloat = 0

class SeatsPlanController: UIViewController {
    
    private var alphabets = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("✕", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.black
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(pressedCloseButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("Confirm", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.black
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(pressedConfirmButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let seatsScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private func setupLayout() {
        let viewWidth = view.frame.size.height
        let closeButtonXCoord = viewWidth - 10 - 30
        let confirmButtonXCoord = closeButtonXCoord - 10 - 100
        
        closeButton.frame = CGRect(x: closeButtonXCoord, y: 10, width: 30, height: 30)
        confirmButton.frame = CGRect(x: confirmButtonXCoord, y: 10, width: 100, height: 30)
    }
    
    @objc private func pressedCloseButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func pressedConfirmButton() {
        print("Pressed Confirm", "\(selectedTickets)")
        
        var selectedTicketsString = String()
        
        for i in 0..<selectedTickets.count {
            
            if i == 0 {
                selectedTicketsString += selectedTickets[i]
            } else {
                selectedTicketsString += ", \(selectedTickets[i])"
            }
        }
        
        movieDateTimeSelectedTickets = selectedTicketsString
        movieDateTimeSelectedTicketsPrice = selectedTicketsPrice
        dismiss(animated: true, completion: nil)
    }
    
    private func setupSeatsPlan() {
        var seatContentSize = CGSize(width: view.frame.size.height, height: view.frame.size.width - 50)
        let seatContentPoint = CGPoint(x: 0, y: 0)
        var seatFrame = CGRect(origin: seatContentPoint, size: seatContentSize)
        let seatView = SeatView(frame: seatFrame)
        
        seatsScrollView.frame = CGRect(x: 0, y: 50, width: view.frame.size.height, height: view.frame.size.width - 50)
        seatsScrollView.addSubview(seatView)
        seatsScrollView.contentSize = seatContentSize
        
        let seatPattern  =  "__aaaa_aaaaaaa__n" +
                            "__aauu_aaaaaaa__n" +
                            "__aaaa_aauuuaa__n" +
                            "__uuaa_aaaaaaa__n"

        var row = 0
        var column = 0
        var columnForTitle = 1
        let seatWidth = 30
        let seatHeight = 30
        let startingPointYCoord = 80
        
        var contentWidth = view.frame.size.height // height = width in landscape mode
        var contentHeight = view.frame.size.width - 50
        
        var maxWidth: CGFloat = 0.0
        var maxHeight: CGFloat = 0.0
        
        for (_, char) in seatPattern.enumerated() {
            
            let seatPoint = CGPoint(x: (seatWidth + 10) * column, y: startingPointYCoord + (seatHeight + 10) * row)
            let seatSize = CGSize(width: seatWidth, height: seatHeight)
            
            maxWidth = CGFloat((seatWidth + 10) * column)
            maxHeight = CGFloat(startingPointYCoord + (seatHeight + 10) * row)
            
            if maxWidth > contentWidth{
                contentWidth = maxWidth
            }
            
            if maxHeight > contentHeight {
                contentHeight = maxHeight
            }
            
            if char == "_" {
                column += 1
            } else if char == "u" {
                seatView.setUnvailableSeat(origin: seatPoint, size: seatSize, title: "\(alphabets[row])\(columnForTitle)")
                column += 1
                columnForTitle += 1
            } else if char == "a" {
                seatView.setAvailableSeat(origin: seatPoint, size: seatSize, title: "\(alphabets[row])\(columnForTitle)")
                column += 1
                columnForTitle += 1
            } else if char == "n" {
                row += 1
                column = 0
                columnForTitle = 1
            } else {
                
            }
        }

        seatContentSize = CGSize(width: contentWidth, height: contentHeight)
        seatFrame = CGRect(origin: seatContentPoint, size: seatContentSize)
        seatView.frame = seatFrame
        seatsScrollView.contentSize = seatContentSize
        seatView.setScreenLayout(contentWidth: seatContentSize.width)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(closeButton)
        view.addSubview(confirmButton)
        view.addSubview(seatsScrollView)
        setupLayout()
        setupSeatsPlan()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
}

class SeatView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .gray
    }
    
    internal func setScreenLayout(contentWidth: CGFloat) {
        
        let viewWidth = contentWidth
        let cinemaScreenWidth = contentWidth * 0.4
        
        let label = UILabel()
        label.text = "Screen"
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = UIColor(red:1.00, green:0.14, blue:0.40, alpha:1.0)
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.frame = CGRect(x: (viewWidth - cinemaScreenWidth)/2, y: 10, width: cinemaScreenWidth, height: 25)
        addSubview(label)
    }
    
    internal func setAvailableSeat(origin: CGPoint, size: CGSize, title: String) {
        let seatFrame = CGRect(origin: origin, size: size)
        let seat = UIButton()
        seat.backgroundColor = .green
        seat.setTitle(title, for: .normal)
        seat.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        seat.addTarget(self, action: #selector(pressedSeats), for: .touchUpInside)
        seat.layer.cornerRadius = 5
        seat.frame = seatFrame
        addSubview(seat)
    }
    
    @objc private func pressedSeats(_ sender: UIButton) {
        if sender.backgroundColor == .green {
            sender.backgroundColor = .blue
            selectedTickets.append((sender.titleLabel?.text)!)
            selectedTicketsPrice += 1000
        } else {
            sender.backgroundColor = .green
            selectedTickets.remove(at: selectedTickets.index(of: (sender.titleLabel?.text)!)!)
            
            if selectedTicketsPrice > 0 {
                selectedTicketsPrice -= 1000
            }
        }
    }
    
    internal func setUnvailableSeat(origin: CGPoint, size: CGSize, title: String)  {
        let seatFrame = CGRect(origin: origin, size: size)
        let seat = UIButton()
        seat.backgroundColor = .orange
        seat.isEnabled = false
        seat.setTitle(title, for: .normal)
        seat.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        seat.layer.cornerRadius = 5
        seat.frame = seatFrame
        addSubview(seat)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//class Seat: UIButton {
//    var row: Int = 0
//    var column: Int = 0
//    var available: Bool = true
//    var price: Float = 0.0
//}

