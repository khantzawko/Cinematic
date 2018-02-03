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
    
    var testArray = ["Movie Name:", "Movie Date:", "Movie Time:", "Cinema:"]
    var testArray2 = ["Justice League", "12 Dec 2017", "10:40 am", "Mingalar Sanpya"]
    var testArray3 = ["a1, a2, a3"]
    var testArray4 = ["3 * 5500"]
    var testArray5 = [128,200]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        selectedTicketLabelArray = testArray
        selectedTicketInfoArray = testArray2
        selectedSeatInfoArray = testArray3
        selectedSeatPriceArray = testArray4
        
        totalButton.layer.cornerRadius = 20
        totalButton.setTitle("Total: 16,500", for: .normal)
        totalButton.titleLabel?.textAlignment = .center
        totalButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        totalButton.backgroundColor = UIColor(red:1.00, green:0.14, blue:0.40, alpha:1.0)
        totalButton.addTarget(self, action: #selector(self.checkoutCart), for: .touchUpInside)
    }

    func clearCart() {
        self.testArray.removeAll()
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(testArray5[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArray5.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = CartCell(style: .default, reuseIdentifier: "TicketInfoCell")
            cell.headingTicketInfoLabel.text = "Ticket Info: "
            return cell
        } else if indexPath.row == 1 {
            let cell = CartCell(style: .default, reuseIdentifier: "TicketPriceCell")
            cell.headingTicketInfoLabel.text = "Ticket Price: "
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    @objc func checkoutCart() {
        print("checkout!")
    }
}
