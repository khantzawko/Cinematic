//
//  MovieDateTimeController.swift
//  Cinematic
//
//  Created by Khant Zaw Ko on 21/2/18.
//  Copyright © 2018 Khant Zaw Ko. All rights reserved.
//

import UIKit

private var selectedIndexPathDate: IndexPath?
private var selectedIndexPathTime: IndexPath?
private var dates = [String]()
private var showtimes = [String]()
var movieDateTimeSelectedTickets: String = "Press + to select some tickets"
var movieDateTimeSelectedTicketsPrice: CGFloat = 0

class MovieDateTimeController: UITableViewController {
    
    let settingsVC = SettingsViewController()

    var selectedMovie = Movie()
    var selectedCinema = Cinema()
    var selectedTheatre = Theatre()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("did load")
        
        movieDateTimeSelectedTickets = "Press + to select some tickets"
        movieDateTimeSelectedTicketsPrice = 0
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = selectedMovie.name
        let rightBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "cart"), style: .plain, target: self, action: #selector(pressedRightBarButton))
        navigationItem.rightBarButtonItem = rightBarButton
        
        tableView.register(MovieDateTimeCell.self, forCellReuseIdentifier: "MovieDateTimeCell")
        
        selectedIndexPathDate = IndexPath(row: 0, section: 0)
        selectedIndexPathTime = IndexPath(row: 0, section: 0)
        showtimes = selectedTheatre.showtimes!
        dates = Date().daysFromStartDate(startDate: selectedTheatre.startDate!, numberOfWeeks: selectedTheatre.weeksInTheatre!)
        
        self.reloadCollectionView()
    }
    
    @objc private func pressedRightBarButton() {
        let checkoutViewController = CheckoutViewController(ticketInfo: "\(selectedMovie.name!) Ticket",
            seatInfo: movieDateTimeSelectedTickets,
            price: Int(movieDateTimeSelectedTicketsPrice),
            settings: self.settingsVC.settings,
            movie: selectedMovie,
            cinema: selectedCinema,
            date: dates[(selectedIndexPathDate?.row)!],
            time: showtimes[(selectedIndexPathTime?.row)!])
        
        self.navigationController?.pushViewController(checkoutViewController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if dates.isEmpty || movieDateTimeSelectedTicketsPrice <= 0 {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
        tableView.reloadData()
    }
    
    func reloadCollectionView() {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "MovieDateTimeCell") as! MovieDateTimeCell
        cell.movieDateCollectionView.reloadData()
        cell.movieTimeCollectionView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 136
        } else {
            return UITableViewAutomaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = MovieDateTimeCell.init(style: .default, reuseIdentifier: "Movie")
            cell.movie = selectedMovie
            return cell
        } else if indexPath.row == 1 {
            let cell = MovieDateTimeCell.init(style: .default, reuseIdentifier: "Date")
            cell.tag = 99
            return cell
        } else if indexPath.row == 2 {
            let cell = MovieDateTimeCell.init(style: .default, reuseIdentifier: "Time")
            cell.tag = 100
            return cell
        } else if indexPath.row == 3 {
            let cell = MovieDateTimeCell.init(style: .default, reuseIdentifier: "Seat")
            cell.selectedTickets = movieDateTimeSelectedTickets
            cell.selectedTicketsPrice = movieDateTimeSelectedTicketsPrice
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension MovieDateTimeCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if tag == 99 {
            return dates.count
        } else if tag == 100 {
            return showtimes.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                
        if tag == 99 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieDateCollectionCell", for: indexPath) as! MovieDateCollectionCell
            cell.movieDate.text = Date().dayAndMonthFormat(date: dates[indexPath.row])
            
            if indexPath == selectedIndexPathDate && selectedIndexPathDate != nil {
                cell.layer.backgroundColor = UIColor(red:1.00, green:0.14, blue:0.40, alpha:1.0).cgColor
                cell.movieDate.textColor = .white
            } else {
                cell.layer.backgroundColor = UIColor.white.cgColor
                cell.movieDate.textColor = UIColor(red:1.00, green:0.14, blue:0.40, alpha:1.0)
            }
        
            return cell
        } else if tag == 100 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieTimeCollectionCell", for: indexPath) as! MovieTimeCollectionCell
            cell.movieTime.text = showtimes[indexPath.row]
            
            if indexPath == selectedIndexPathTime && selectedIndexPathTime != nil {
                cell.layer.backgroundColor = UIColor(red:1.00, green:0.14, blue:0.40, alpha:1.0).cgColor
                cell.movieTime.textColor = .white
            } else {
                cell.layer.backgroundColor = UIColor.white.cgColor
                cell.movieTime.textColor = UIColor(red:1.00, green:0.14, blue:0.40, alpha:1.0)
            }
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if tag == 99 {
            selectedIndexPathDate = indexPath
        } else if tag == 100 {
            selectedIndexPathTime = indexPath
        } else {
            return
        }
        
        guard collectionView.cellForItem(at: indexPath) != nil else {
            return
        }
        
        if tag == 99 {
            let cell = collectionView.cellForItem(at: indexPath) as! MovieDateCollectionCell
            cell.layer.backgroundColor = UIColor(red:1.00, green:0.14, blue:0.40, alpha:1.0).cgColor
            cell.movieDate.textColor = .white
            collectionView.reloadData()
        }
        
        if tag == 100 {
            let cell = collectionView.cellForItem(at: indexPath) as! MovieTimeCollectionCell
            cell.layer.backgroundColor = UIColor(red:1.00, green:0.14, blue:0.40, alpha:1.0).cgColor
            cell.movieTime.textColor = .white
            collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if tag == 99 {
            selectedIndexPathDate = nil
        } else if tag == 100 {
            selectedIndexPathTime = nil
        } else {
            return
        }
        
        guard collectionView.cellForItem(at: indexPath) != nil else {
            return
        }
        
        if tag == 99 {
            let cell = collectionView.cellForItem(at: indexPath) as! MovieDateCollectionCell
            cell.layer.backgroundColor = UIColor.white.cgColor
            cell.movieDate.textColor = UIColor(red:1.00, green:0.14, blue:0.40, alpha:1.0)
        }
        
        if tag == 100 {
            let cell = collectionView.cellForItem(at: indexPath) as! MovieTimeCollectionCell
            cell.layer.backgroundColor = UIColor.white.cgColor
            cell.movieTime.textColor = UIColor(red:1.00, green:0.14, blue:0.40, alpha:1.0)
        }

    }
}
