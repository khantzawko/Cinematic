//
//  ViewSeatsController.swift
//  Cinematic
//
//  Created by Khant Zaw Ko on 31/12/17.
//  Copyright © 2017 Khant Zaw Ko. All rights reserved.
//

import UIKit

class ViewSeatsController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let rowsInAlphabeticalOrder = ["A", "B", "C", "D", "E", "F"]
    let numbersOfSeatsInARowArray = [12,12,12,12,12,12]
    @IBOutlet weak var screenLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        screenLabel.layer.cornerRadius = 10
        screenLabel.clipsToBounds = true
        
        let value = UIInterfaceOrientation.landscapeRight.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    
    private func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscapeRight
    }
    
    private func shouldAutorotate() -> Bool {
        return true
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmButton(_ sender: Any) {
    
        let alertController = UIAlertController(title: "Confirm", message: "Number of Seats Selected: \(selectedSeats.count)\nSelected seat no. \(selectedSeats)", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        let confirmAction = UIAlertAction(title: "Ok", style: .default, handler: nil)

        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)

        self.present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowsInAlphabeticalOrder.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        numbersOfSeatsInARow = numbersOfSeatsInARowArray[indexPath.row]
        
        let cell = SeatsPlanCell(style: .default, reuseIdentifier: "SeatsPlanCell")
        cell.leftLabel.text = rowsInAlphabeticalOrder[indexPath.row]
        cell.rightLabel.text = rowsInAlphabeticalOrder[indexPath.row]
        return cell
    }
}
