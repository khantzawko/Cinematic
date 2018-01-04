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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedTicketLabelArray = testArray
        selectedTicketInfoArray = testArray2
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = CartCell(style: .default, reuseIdentifier: "CartTicketInfoCell")
        cell.headingTicketInfoLabel.text = "Ticket Info: "
        return cell
    }
    
}
