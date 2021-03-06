//
//  ProfileViewController.swift
//  Cinematic
//
//  Created by Khant Zaw Ko on 12/1/18.
//  Copyright © 2018 Khant Zaw Ko. All rights reserved.
//

import UIKit
import Firebase

class ProfileController: UITableViewController {
    
    private let imageView = UIImageView(image: UIImage(named: "image.png"))
    var ref: DatabaseReference!
    var receipts = [Receipt]()
    var cinemas = [Cinema]()
    var movies = [Movie]()
    
    var customView: UIView!
    var labelsArray:[UILabel] = []
    var isAnimating = false
    var currentColorIndex = 0
    var currentLabelIndex = 0
    var timer: Timer!
    
    private struct Const {
        static let ImageSizeForLargeState: CGFloat = 40
        static let ImageRightMargin: CGFloat = 16
        static let ImageBottomMarginForLargeState: CGFloat = 8
        static let ImageBottomMarginForSmallState: CGFloat = 2
        static let ImageSizeForSmallState: CGFloat = 32
        static let NavBarHeightSmallState: CGFloat = 44
        static let NavBarHeightLargeState: CGFloat = 96.5
    }
    
    private func moveAndResizeImage(for height: CGFloat) {
        let coeff: CGFloat = {
            let delta = height - Const.NavBarHeightSmallState
            let heightDifferenceBetweenStates = (Const.NavBarHeightLargeState - Const.NavBarHeightSmallState)
            return delta / heightDifferenceBetweenStates
        }()
        
        let factor = Const.ImageSizeForSmallState / Const.ImageSizeForLargeState
        
        let scale: CGFloat = {
            let sizeAddendumFactor = coeff * (1.0 - factor)
            return min(1.0, sizeAddendumFactor + factor)
        }()
        
        // Value of difference between icons for large and small states
        let sizeDiff = Const.ImageSizeForLargeState * (1.0 - factor) // 8.0
        
        let yTranslation: CGFloat = {
            /// This value = 14. It equals to difference of 12 and 6 (bottom margin for large and small states). Also it adds 8.0 (size difference when the image gets smaller size)
            let maxYTranslation = Const.ImageBottomMarginForLargeState - Const.ImageBottomMarginForSmallState + sizeDiff
            return max(0, min(maxYTranslation, (maxYTranslation - coeff * (Const.ImageBottomMarginForSmallState + sizeDiff))))
        }()
        
        let xTranslation = max(0, sizeDiff - coeff * sizeDiff)
        
        imageView.transform = CGAffineTransform.identity
            .scaledBy(x: scale, y: scale)
            .translatedBy(x: xTranslation, y: yTranslation)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let height = navigationController?.navigationBar.frame.height else { return }
        moveAndResizeImage(for: height)
    }
    
    private func getUserNameAndEmail() {
        
        let alertController = UIAlertController(title: "Welcome to Cinematic!", message: "Please enter your info:", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: {
            alert -> Void in
            
            let name = alertController.textFields![0] as UITextField
            let email = alertController.textFields![1] as UITextField
            
            if name.text != "" || email.text != "" {
                UserDefaults.standard.set(name.text, forKey: "name") //setObject
                UserDefaults.standard.set(email.text, forKey: "email") //setObject
                self.navigationItem.title = name.text
                self.getReceiptData(email: email.text!)
            } else {

            }
            
        })

        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Name"
        }
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Email Address"
        }
            
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc private func pressedProfileImage() {
        
        var alertMessage = String()
        var isSignIn = Bool()
        
        if let user = UserDefaults.standard.string(forKey: "name") {
            alertMessage = "Sign Out as \(user)?"
            isSignIn = false
        } else {
            alertMessage = "Do you want to Sign in?"
            isSignIn = true
        }
        
        let alertController = UIAlertController(title: "Confirm?", message: alertMessage, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let signOutAction = UIAlertAction(title: isSignIn == true ? "Sign In" : "Sign Out", style: .default, handler: {
            alert -> Void in

            if isSignIn {
                self.getUserNameAndEmail()
            } else {
                UserDefaults.standard.removeObject(forKey: "name")
                UserDefaults.standard.removeObject(forKey: "email")
                self.navigationItem.title = "Profile"
                self.cinemas.removeAll()
                self.receipts.removeAll()
                self.movies.removeAll()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
        })
        alertController.addAction(cancelAction)
        alertController.addAction(signOutAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Profile"
        tableView.register(ProfileCell.self, forCellReuseIdentifier: "ProfileCell")

        if let user = UserDefaults.standard.string(forKey: "name") {
            navigationItem.title = user
            getReceiptData(email: UserDefaults.standard.string(forKey: "email")!)
        } else {
            getUserNameAndEmail()
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(pressedProfileImage))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
        
        // Initial setup for image for Large NavBar state since the the screen always has Large NavBar once it gets opened
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.addSubview(imageView)
        imageView.layer.cornerRadius = Const.ImageSizeForLargeState / 2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.rightAnchor.constraint(equalTo: navigationBar.rightAnchor,
                                             constant: -Const.ImageRightMargin),
            imageView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor,
                                              constant: -Const.ImageBottomMarginForLargeState),
            imageView.heightAnchor.constraint(equalToConstant: Const.ImageSizeForLargeState),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
            ])
        
        refreshControl = UIRefreshControl()
        refreshControl?.backgroundColor = .clear
        refreshControl?.tintColor = .clear
        loadCustomRefreshContents()
    }
    
    private func loadCustomRefreshContents() {
        let refreshContents = Bundle.main.loadNibNamed("CustomView", owner: self, options: nil)!
        
        customView = refreshContents[0] as! UIView
        customView.frame = (refreshControl?.bounds)!
        
        for i in 0..<customView.subviews.count {
            labelsArray.append(customView.viewWithTag(i + 1) as! UILabel)
        }
        
        refreshControl?.addSubview(customView)
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (refreshControl?.isRefreshing)! {
            if !isAnimating {
                doSomething()
                
//                LEFT TO LOAD DATA FROM PULL TO REFRESH
                
//                if let email = UserDefaults.standard.string(forKey: "email") {
//                    getReceiptData(email: email)
//                }
//
                animateRefreshStep1()
            }
        }
    }
    
    private func animateRefreshStep1() {
        isAnimating = true
        
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveLinear, animations: {() -> Void in
            
            self.labelsArray[self.currentLabelIndex].transform = CGAffineTransform(rotationAngle: CGFloat.pi / 4)
            self.labelsArray[self.currentLabelIndex].textColor = self.getNextColor()
            
        }, completion: {(finished) -> Void in
            
            UIView.animate(withDuration: 0.05, delay: 0.0, options: .curveLinear, animations: {() -> Void in
                
                self.labelsArray[self.currentLabelIndex].transform = CGAffineTransform.identity
                self.labelsArray[self.currentLabelIndex].textColor = .black
                
            }, completion: {(finished) -> Void in
                
                self.currentLabelIndex = self.currentLabelIndex + 1
                
                if self.currentLabelIndex < self.labelsArray.count {
                    self.animateRefreshStep1()
                } else {
                    self.animateRefreshStep2()
                }
            })
        })
    }
    
    private func animateRefreshStep2() {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveLinear, animations: { () -> Void in
            
            for i in 0..<self.labelsArray.count {
                self.labelsArray[i].transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }
            
        }, completion: { (finished) -> Void in
            UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveLinear, animations: { () -> Void in
                
                for i in 0..<self.labelsArray.count {
                    self.labelsArray[i].transform = CGAffineTransform.identity
                }
                
            }, completion: { (finished) -> Void in
                if (self.refreshControl?.isRefreshing)! {
                    self.currentLabelIndex = 0
                    self.animateRefreshStep1()
                }
                else {
                    self.isAnimating = false
                    self.currentLabelIndex = 0
                    
                    for i in 0..<self.labelsArray.count {
                        self.labelsArray[i].textColor = .black
                        self.labelsArray[i].transform = .identity
                    }
                }
            })
        })
    }
    
    private func getNextColor() -> UIColor {
        var colorsArray: [UIColor] = [.magenta, .brown, .yellow, .red, .green, .blue, .orange, .yellow, .cyan]
        
        if currentColorIndex == colorsArray.count {
            currentColorIndex = 0
        }
        
        let returnColor = colorsArray[currentColorIndex]
        currentColorIndex = currentColorIndex + 1
        
        return returnColor
    }
    
    private func doSomething() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(endOfWork), userInfo: nil, repeats: true)
    }
    
    @objc private func endOfWork() {
        refreshControl?.endRefreshing()
        
        timer.invalidate()
        timer = nil
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    private func getReceiptData(email: String) {
        ref = Database.database().reference().child("receipts")
        
        let movieRef = Database.database().reference().child("movies")
        let cinemaRef = Database.database().reference().child("cinema")
                
        ref.queryOrdered(byChild: "email").queryEqual(toValue: email).observe(DataEventType.childAdded, with: {(snapshot) in
            var postDict = snapshot.value as! [String : AnyObject]
            
            if let receiptAmount = postDict["amount"],
                let receiptEmail = postDict["email"],
                let receiptPurchasedDate = postDict["purchasedDate"],
                let receiptCode = postDict["receiptCode"],
                let receiptTicketInfo = postDict["ticketInfo"],
                let receiptSeatInfo = postDict["seatInfo"],
                let movieTime = postDict["movieTime"],
                let movieKey = postDict["movieID"],
                let cinemaKey = postDict["cinemaID"] {
                
                self.receipts.append(Receipt(key: snapshot.key,
                                             amount: receiptAmount as! Int,
                                             email: receiptEmail as! String,
                                             purchasedDate: receiptPurchasedDate as! String,
                                             receiptCode: receiptCode as! String,
                                             ticketInfo: receiptTicketInfo as! String,
                                             seatInfo: receiptSeatInfo as! String,
                                             movieTime: movieTime as! String,
                                             movieID: movieKey as! String,
                                             cinemaID: cinemaKey as! String))
                
                cinemaRef.child(cinemaKey as! String).observe(DataEventType.value, with: {(cSnap) in
                    var cinemaDict = cSnap.value as! [String:AnyObject]
                    if  let cinemaName = cinemaDict["name"],
                        let cinemaLocation = cinemaDict["location"],
                        let cinemaPhone = cinemaDict["phone"] {
                        let cinema = Cinema(key: (cinemaKey as! String),
                                            name: (cinemaName as! String),
                                            location: (cinemaLocation as! String),
                                            phone: (cinemaPhone as! String))
                        self.cinemas.append(cinema)
                    }
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                })
                
                movieRef.child(movieKey as! String).observe(DataEventType.value, with: {(mSnap) in
                    var movieDict = mSnap.value as! [String:AnyObject]
                    if let movieName = movieDict["name"],
                        let movieGenre = movieDict["genre"],
                        let movieDuration = movieDict["duration"],
                        let movieRating = movieDict["rating"],
                        let movieImage = movieDict["image"],
                        let movieInfo = movieDict["info"],
                        let movieTrailer = movieDict["trailer"],
                        let movieStartDate = movieDict["startDate"],
                        let movieEndDate = movieDict["endDate"] {
                        
                        let movie = Movie(key: snapshot.key,
                                                 name: (movieName as! String),
                                                 genre: (movieGenre as! String),
                                                 info: (movieInfo as! String),
                                                 image: (movieImage as! String),
                                                 duration: (movieDuration as! Int),
                                                 rating: (movieRating as! Double),
                                                 trailer: (movieTrailer as! String),
                                                 startDate: (movieStartDate as! String),
                                                 endDate: (movieEndDate as! String))
                        self.movies.append(movie)
                    }
                })
            }
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cinemas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
        cell.movie = movies[indexPath.row]
        cell.movieInfoText = "\nCinema: \(cinemas[indexPath.row].name ?? "Cinema")\nSeats: \(receipts[indexPath.row].seatInfo)\nShowtime: \(receipts[indexPath.row].movieTime)\nPurchasedDate: \(Date().fullDateFromString(date: receipts[indexPath.row].purchasedDate))\nReceiptCode#: \(receipts[indexPath.row].receiptCode)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 136
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let qrc = QRCodeController()
        qrc.QRString = receipts[indexPath.row].receiptCode
        qrc.movieName = movies[indexPath.row].name!
        navigationController?.pushViewController(qrc, animated: true)
    }
}
