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
                
        selectedIndexPathDate = IndexPath(row: 0, section: 0)
        selectedIndexPathTime = IndexPath(row: 0, section: 0)
        showtimes = selectedTheatre.showtimes!
        
        dates = Date().daysFromStartDate(startDate: selectedTheatre.startDate!, numberOfWeeks: selectedTheatre.weeksInTheatre!)
        self.reloadCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if dates.isEmpty {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    
    func reloadCollectionView() {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TicketCell") as! TicketCell
//        cell.collectionView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
        
//        if indexPath.row == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "LabelTitleCell", for: indexPath) as! LabelTitleCell
//            cell.ticketShowTimesTitle.text = " Tickets & Showtimes"
//            return cell
//        } else if indexPath.row == 1 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "TicketCell", for: indexPath) as! TicketCell
//            cell.ticketContentTitle.text = "Select Date"
//            return cell
//        } else if indexPath.row == 2 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "TicketCell", for: indexPath) as! TicketCell
//            cell.ticketContentTitle.text = "Select Time"
//            return cell
//        } else {
//            return UITableViewCell()
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToCart" {
            let coc: CartController = segue.destination as! CartController
            coc.selectedMovie = selectedMovie
            coc.selectedCinema = selectedCinema
            coc.selectedTheatre = selectedTheatre
            coc.selectedDate = dates[(selectedIndexPathDate?.row)!]
            coc.selectedTime = showtimes[(selectedIndexPathTime?.row)!]
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
            cell.ticketContentLabel.text = Date().dayAndMonthFormat(date: dates[indexPath.row])
            
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

