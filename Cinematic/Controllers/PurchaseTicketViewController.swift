//
//  PurchaseTicketViewController.swift
//  Cinematic
//
//  Created by Khant Zaw Ko on 22/12/17.
//  Copyright © 2017 Khant Zaw Ko. All rights reserved.
//

import UIKit

class PurchaseTicketViewController: UITableViewController, UIPopoverPresentationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func pressedViewSeats(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PopoverController") as! ViewSeatsController
        present(vc, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieBCell", for: indexPath) as! MovieBCell
            cell.selectedMovie.text = " Selected Movie"
            cell.purchaseSelectedMovieTitle.text = "Coco"
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LabelTitleCell", for: indexPath) as! LabelTitleCell
            cell.ticketShowTimesTitle.text = " Tickets & Showtimes"
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TicketCell", for: indexPath) as! TicketCell
            cell.ticketContentTitle.text = "Choose Date"
            return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TicketCell", for: indexPath) as! TicketCell
            cell.ticketContentTitle.text = "Choose Time"
            return cell
        } else if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SeatCell", for: indexPath) as! SeatCell
            cell.chooseSeatButton.layer.cornerRadius = 10
            cell.chooseSeatButton.titleLabel?.text = "View Seats"
            return cell
        } else {
            return UITableViewCell()
        }
    }

}

extension TicketCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if self.ticketContentTitle.text == "Choose Date" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionHorizontalCell", for: indexPath) as! CollectionHorizontalCell
            cell.layer.cornerRadius = 20
            cell.layer.borderWidth = 2
            cell.layer.borderColor = UIColor(red:0.01, green:0.54, blue:0.91, alpha:1.0).cgColor
            cell.ticketContentLabel.textColor = UIColor(red:0.01, green:0.54, blue:0.91, alpha:1.0)
            cell.ticketContentLabel.text = "12 Dec"
            return cell
        } else if self.ticketContentTitle.text == "Choose Time" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionHorizontalCell", for: indexPath) as! CollectionHorizontalCell
            cell.layer.borderWidth = 2
            cell.layer.borderColor = UIColor(red:0.01, green:0.54, blue:0.91, alpha:1.0).cgColor
            cell.layer.cornerRadius = 20
            cell.ticketContentLabel.textColor = UIColor(red:0.01, green:0.54, blue:0.91, alpha:1.0)
            cell.ticketContentLabel.text = "10:40 am"
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionHorizontalCell
        cell.layer.backgroundColor = UIColor(red:0.01, green:0.54, blue:0.91, alpha:1.0).cgColor
        cell.ticketContentLabel.textColor = .white
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionHorizontalCell
        cell.layer.backgroundColor = UIColor.white.cgColor
        cell.ticketContentLabel.textColor = UIColor(red:0.01, green:0.54, blue:0.91, alpha:1.0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.ticketContentTitle.text == "Choose Date" {
            return 4
        } else if self.ticketContentTitle.text == "Choose Time" {
            return 5
        } else {
            return 0
        }
    }

}
