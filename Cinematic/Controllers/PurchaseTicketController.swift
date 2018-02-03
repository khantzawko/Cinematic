//
//  PurchaseTicketViewController.swift
//  Cinematic
//
//  Created by Khant Zaw Ko on 22/12/17.
//  Copyright © 2017 Khant Zaw Ko. All rights reserved.
//

import UIKit

private var selectedIndexPathDate: IndexPath?
private var selectedIndexPathTime: IndexPath?
private var dates = [String]()
private var showtimes = [String]()

class PurchaseTicketController: UITableViewController, UIPopoverPresentationControllerDelegate {
    
    var selectedMovie = Movie()
    var selectedCinema = Cinema()
    var selectedTheatre = Theatre()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showtimes = selectedTheatre.showtimes!
        
        dates = Date().daysFromStartDate(startDate: selectedTheatre.startDate!, numberOfWeeks: selectedTheatre.weeksInTheatre!)
        self.reloadCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        selectedIndexPathDate = IndexPath(row: 0, section: 0)
        selectedIndexPathTime = IndexPath(row: 0, section: 0)
    }
    
    func reloadCollectionView() {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TicketCell") as! TicketCell
        cell.collectionView.reloadData()
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
            cell.purchaseSelectedMovieTitle.text = selectedMovie.name
            cell.selectedMovieTheatre.text = selectedCinema.name! + " - " + selectedTheatre.name!
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LabelTitleCell", for: indexPath) as! LabelTitleCell
            cell.ticketShowTimesTitle.text = " Tickets & Showtimes"
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TicketCell", for: indexPath) as! TicketCell
            cell.ticketContentTitle.text = "Select Date"
            return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TicketCell", for: indexPath) as! TicketCell
            cell.ticketContentTitle.text = "Select Time"
            return cell
        } else if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SeatCell", for: indexPath) as! SeatCell
            cell.chooseSeatButton.layer.cornerRadius = 20
            cell.seatTitle.text = "Select Seats"
            cell.chooseSeatButton.titleLabel?.text = "View Seats"
            cell.chooseSeatButton.backgroundColor = UIColor(red:1.00, green:0.14, blue:0.40, alpha:1.0)
            return cell
        } else {
            return UITableViewCell()
        }
    }

}

extension TicketCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.ticketContentTitle.text == "Select Date" {
            return dates.count
        } else if self.ticketContentTitle.text == "Select Time" {
            return showtimes.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if self.ticketContentTitle.text == "Select Date" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionHorizontalCell", for: indexPath) as! CollectionHorizontalCell
            cell.layer.cornerRadius = 20
            cell.layer.borderWidth = 2
            cell.layer.borderColor = UIColor(red:0.01, green:0.54, blue:0.91, alpha:1.0).cgColor
            cell.ticketContentLabel.text = dates[indexPath.row]
            
            if indexPath == selectedIndexPathDate && selectedIndexPathDate != nil {
                cell.layer.backgroundColor = UIColor(red:0.01, green:0.54, blue:0.91, alpha:1.0).cgColor
                cell.ticketContentLabel.textColor = .white
            } else {
                cell.layer.backgroundColor = UIColor.white.cgColor
                cell.ticketContentLabel.textColor = UIColor(red:0.01, green:0.54, blue:0.91, alpha:1.0)
            }
            
            return cell
        } else if self.ticketContentTitle.text == "Select Time" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionHorizontalCell", for: indexPath) as! CollectionHorizontalCell
            cell.layer.cornerRadius = 20
            cell.layer.borderWidth = 2
            cell.layer.borderColor = UIColor(red:0.01, green:0.54, blue:0.91, alpha:1.0).cgColor
            cell.ticketContentLabel.text = showtimes[indexPath.row]
            
            if indexPath == selectedIndexPathTime && selectedIndexPathTime != nil {
                cell.layer.backgroundColor = UIColor(red:0.01, green:0.54, blue:0.91, alpha:1.0).cgColor
                cell.ticketContentLabel.textColor = .white
            } else {
                cell.layer.backgroundColor = UIColor.white.cgColor
                cell.ticketContentLabel.textColor = UIColor(red:0.01, green:0.54, blue:0.91, alpha:1.0)
            }
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if self.ticketContentTitle.text == "Select Date" {
            selectedIndexPathDate = indexPath
        } else if self.ticketContentTitle.text == "Select Time" {
            selectedIndexPathTime = indexPath
        } else {
            return
        }
                
        guard collectionView.cellForItem(at: indexPath) != nil else {
            return
        }
        
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionHorizontalCell
        cell.layer.backgroundColor = UIColor(red:0.01, green:0.54, blue:0.91, alpha:1.0).cgColor
        cell.ticketContentLabel.textColor = .white
        
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if self.ticketContentTitle.text == "Select Date" {
            selectedIndexPathDate = nil
        } else if self.ticketContentTitle.text == "Select Time" {
            selectedIndexPathTime = nil
        } else {
            return
        }
        
        guard collectionView.cellForItem(at: indexPath) != nil else {
            return
        }
        
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionHorizontalCell
        cell.layer.backgroundColor = UIColor.white.cgColor
        cell.ticketContentLabel.textColor = UIColor(red:0.01, green:0.54, blue:0.91, alpha:1.0)
    }

}
