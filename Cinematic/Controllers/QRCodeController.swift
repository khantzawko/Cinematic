//
//  QRCodeController.swift
//  Cinematic
//
//  Created by Khant Zaw Ko on 6/2/18.
//  Copyright © 2018 Khant Zaw Ko. All rights reserved.
//

import UIKit

class QRCodeController: UIViewController {

    @IBOutlet weak var QRImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = generateQRCode(from: "Hacking with Swift is the best iOS coding tutorial I've ever read!")
        QRImage.image = image
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
