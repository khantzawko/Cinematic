//
//  CartViewController.swift
//  Cinematic
//
//  Created by Khant Zaw Ko on 15/1/18.
//  Copyright © 2018 Khant Zaw Ko. All rights reserved.
//

import UIKit

class CartController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalButton: UIButton!
    
    let settingsVC = SettingsViewController()
    
    var selectedMovie = Movie()
    var selectedCinema = Cinema()
    var selectedTheatre = Theatre()
    var selectedDate = String()
    var selectedTime = String()
    
    var movieLabels = ["Movie Name:", "Movie Date:", "Movie Time:", "Cinema:"]
    var testArray2 = ["Justice League", "12 Dec 2017", "10:40 am", "Mingalar Sanpya"]
    var testArray3 = ["a1, a2, a3"]
    var testArray4 = ["3 * 5500"]
    var testArray5 = [110,60]
    
    var sections = ["Movie Info", "Ticket Info"]
//    var s1Data =
    
    var sectionData: [Int:[String]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        tableView.estimatedSectionHeaderHeight = 30

        selectedTicketLabelArray = movieLabels
        selectedTicketInfoArray = [selectedMovie.name, selectedDate, selectedTime, selectedCinema.name!]
        selectedSeatInfoArray = testArray3
        selectedSeatPriceArray = testArray4
        
        totalButton.layer.cornerRadius = 20
        totalButton.setTitle("Total: 16,500", for: .normal)
        totalButton.titleLabel?.textAlignment = .center
        totalButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        totalButton.backgroundColor = UIColor(red:1.00, green:0.14, blue:0.40, alpha:1.0)
        totalButton.addTarget(self, action: #selector(self.checkoutWithStripe), for: .touchUpInside)
    }

    func clearCart() {
        self.movieLabels.removeAll()
        self.testArray2.removeAll()
        self.testArray3.removeAll()
        self.testArray4.removeAll()
        self.testArray5.removeAll()
        self.tableView.reloadData()
    }
    
    @IBAction func pressedClear(_ sender: Any) {
        print("clear arrays!")
        
        let alertController = UIAlertController(title: "Confirmation!", message: "Do you want to clear?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        let clearAction = UIAlertAction(title: "Clear", style: .default, handler: {action in
            self.clearCart()
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(clearAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .orange
        
        let label: UILabel = UILabel(frame: CGRect(x: 10, y: 5, width: 100, height: 20))
        label.text = sections[section]
        label.font = UIFont.boldSystemFont(ofSize: 15)
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(testArray5[indexPath.section])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = CartCell(style: .default, reuseIdentifier: "MovieInfoCell")
            return cell
        } else if indexPath.section == 1 {
            let cell = CartCell(style: .default, reuseIdentifier: "TicketInfoCell")
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    @objc func pressedViewSeats(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PopoverController") as! ViewSeatsController
        present(vc, animated: true, completion: nil)
    }
    
    @objc func checkoutWithStripe() {        
        let checkoutViewController = CheckoutViewController(product: "\(selectedMovie.name!) ticket",
                                                            price: 1000,
                                                            settings: self.settingsVC.settings)
        self.navigationController?.pushViewController(checkoutViewController, animated: true)
    }
}
