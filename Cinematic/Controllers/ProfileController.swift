//
//  ProfileViewController.swift
//  Cinematic
//
//  Created by Khant Zaw Ko on 12/1/18.
//  Copyright © 2018 Khant Zaw Ko. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {

    @IBOutlet weak var QRImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true

        let image = generateQRCode(from: "Hacking with Swift is the best iOS coding tutorial I've ever read!")
        QRImage.image = image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            
            guard let qrCodeImage = filter.outputImage else {return nil}
            
            let scaleX = QRImage.frame.size.width / qrCodeImage.extent.size.width
            let scaleY = QRImage.frame.size.height / qrCodeImage.extent.size.height
            
            
            let transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
    

}
