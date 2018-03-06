//
//  QRCodeController.swift
//  Cinematic
//
//  Created by Khant Zaw Ko on 6/2/18.
//  Copyright © 2018 Khant Zaw Ko. All rights reserved.
//

import UIKit

class QRCodeController: UIViewController {
    
    var QRString = String()
    var movieName = String()
    
    private let movieNameAndCode: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.isUserInteractionEnabled = false
        textView.isSelectable = false
        textView.isEditable = false
        textView.font = UIFont.boldSystemFont(ofSize: 20)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        return textView
    }()
    
    private let QRImageView: UIImageView = {
        let imageView = UIImageView(image:#imageLiteral(resourceName: "loading"))
        imageView.backgroundColor = .orange
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private func setupLayout() {
        QRImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        QRImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        QRImageView.widthAnchor.constraint(equalToConstant: view.frame.size.width * 0.6).isActive = true
        QRImageView.heightAnchor.constraint(equalToConstant: view.frame.size.width * 0.6).isActive = true
        
        movieNameAndCode.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        movieNameAndCode.topAnchor.constraint(equalTo: QRImageView.topAnchor, constant: -60).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "QRCode"
        view.backgroundColor = .white

        let image = generateQRCode(from: QRString)
        QRImageView.image = image
        movieNameAndCode.text = "\(movieName)\n\(QRString)"
        view.addSubview(movieNameAndCode)
        view.addSubview(QRImageView)
        setupLayout()
    }
    
    private func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            
            guard let qrCodeImage = filter.outputImage else {return nil}
            
            let scaleX = (view.frame.size.width * 0.6) / qrCodeImage.extent.size.width
            let scaleY = (view.frame.size.width * 0.6) / qrCodeImage.extent.size.height
            
            let transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
}
