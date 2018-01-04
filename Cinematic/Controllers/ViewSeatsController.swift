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
    let numbersOfSeatsInARowArray = [7,8,9,10,11,12]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
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
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowsInAlphabeticalOrder.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        numbersOfSeatsInARow = numbersOfSeatsInARowArray[indexPath.row]
        
        let cell = SeatsPlanCell(style: .default, reuseIdentifier: "SeatsPlanCell")
        cell.label1.text = rowsInAlphabeticalOrder[indexPath.row]
        cell.label2.text = rowsInAlphabeticalOrder[indexPath.row]
        return cell
    }
}
