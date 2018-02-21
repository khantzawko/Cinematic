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
    
    var QRString = String()
    var movieName = String()
    
//    private let QRImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.backgroundColor = .orange
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//
//    private func setupLayout() {
//        QRImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        QRImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        QRImageView.widthAnchor.constraint(equalTo: <#T##NSLayoutAnchor<NSLayoutDimension>#>)
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.addSubview(QRImageView)
//        setupLayout()
        
        let image = generateQRCode(from: QRString)
        QRImage.image = image
        title = movieName
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
