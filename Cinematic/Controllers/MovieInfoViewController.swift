//
//  MovieInfoViewController.swift
//  Cinematic
//
//  Created by Khant Zaw Ko on 17/12/17.
//  Copyright © 2017 Khant Zaw Ko. All rights reserved.
//

import UIKit

class MovieInfoViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        if indexPath.row == 0 {            
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieBCell", for: indexPath) as! MovieBCell
            
            cell.infoTitle.text = "Coco"
            cell.infoImage.image = UIImage(named: "coco.jpg")
            cell.infoImage.layer.cornerRadius = 5
            cell.infoImage.clipsToBounds = true
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieInfoCell", for: indexPath) as! MovieInfoCell
            cell.movieInfoTitle.text = " Movie Info"
            cell.movieInfoDescription.text = "Despite his family's baffling generations-old ban on music, Miguel (voice of newcomer Anthony Gonzalez) dreams of becoming an accomplished musician like his idol, Ernesto de la Cruz (voice of Benjamin Bratt). Desperate to prove his talent, Miguel finds himself in the stunning and colorful Land of the Dead following a mysterious chain of events. Along the way, he meets charming trickster Hector (voice of Gael García Bernal), and together, they set off on an extraordinary journey to unlock the real story behind Miguel's family history."
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewCell
            cell.reviewTitle.text = " Cinemas"
            return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TrailerCell", for: indexPath) as! TrailerCell
            cell.trailerTitle.text = " Trailers"
            cell.webView.loadHTMLString("<iframe width=\"100%\" height=\"100%\" src=\"https://www.youtube.com/embed/zNCz4mQzfEI\" frameborder=\"0\" gesture=\"media\" allow=\"encrypted-media\" allowfullscreen></iframe>", baseURL: nil)
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension ReviewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionHorizontalCell", for: indexPath) as! CollectionHorizontalCell
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor(red:1.00, green:0.14, blue:0.40, alpha:1.0).cgColor
        cell.layer.cornerRadius = 20
        cell.cinemaName.textColor = UIColor(red:1.00, green:0.14, blue:0.40, alpha:1.0)
        cell.cinemaName.text = "CityMall"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionHorizontalCell
        cell.layer.backgroundColor = UIColor(red:1.00, green:0.14, blue:0.40, alpha:1.0).cgColor
        cell.cinemaName.textColor = .white
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionHorizontalCell
        cell.layer.backgroundColor = UIColor.white.cgColor
        cell.cinemaName.textColor = UIColor(red:1.00, green:0.14, blue:0.40, alpha:1.0)
    }
    
}
