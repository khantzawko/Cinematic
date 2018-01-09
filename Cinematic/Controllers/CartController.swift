//
//  CartController.swift
//  Cinematic
//
//  Created by Khant Zaw Ko on 4/1/18.
//  Copyright © 2018 Khant Zaw Ko. All rights reserved.
//

import UIKit

class CartController: UITableViewController {
    
    let testArray = ["Movie Name:", "Movie Date:", "Movie Time:", "Cinema:"]
    let testArray2 = ["Justice League", "12 Dec 2017", "10:40 am", "Mingalar Sanpya"]
    
    let testArray3 = ["a1, a2, a3"]
    let testArray4 = ["3 * 5500"]
    
    let testArray5 = [128,200,58]


    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedTicketLabelArray = testArray
        selectedTicketInfoArray = testArray2
        
        selectedSeatInfoArray = testArray3
        selectedSeatPriceArray = testArray4
    }
    
    @IBAction func clearButton(_ sender: Any) {
        print("clear arrays!")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return testArray5.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(testArray5[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = CartCell(style: .default, reuseIdentifier: "TicketInfoCell")
            cell.headingTicketInfoLabel.text = "Ticket Info: "
            return cell
        } else if indexPath.row == 1 {
            let cell = CartCell(style: .default, reuseIdentifier: "TicketPriceCell")
            cell.headingTicketInfoLabel.text = "Ticket Price: "
            return cell
        } else if indexPath.row == 2 {
            let cell = CartCell(style: .default, reuseIdentifier: "CheckoutButtonCell")
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
}
