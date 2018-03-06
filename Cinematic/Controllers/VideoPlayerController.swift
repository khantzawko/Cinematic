//
//  VideoPlayerController.swift
//  Cinematic
//
//  Created by Khant Zaw Ko on 24/2/18.
//  Copyright © 2018 Khant Zaw Ko. All rights reserved.
//

import UIKit

class VideoPlayerController: UIViewController {
    
    var trailerURL: String? {
        didSet {
            guard let urlString = trailerURL else { return }
            guard let url = URL(string: urlString) else { return }
            let requestURL = NSURLRequest(url: url)
            trailerWebView.loadRequest(requestURL as URLRequest)
        }
    }
    
    private let closeButton: UIButton = {
       let button = UIButton()
        button.setTitle("✕", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.backgroundColor = UIColor.black.cgColor
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(pressedCloseButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let trailerWebView: UIWebView = {
        let webView = UIWebView()
        webView.layer.backgroundColor = UIColor.black.cgColor
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    private func setupLayout() {
        closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        trailerWebView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        trailerWebView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        trailerWebView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        trailerWebView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        trailerWebView.heightAnchor.constraint(equalToConstant: view.frame.width*9/12).isActive = true
    }
    
    @objc private func pressedCloseButton() {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        view.addSubview(trailerWebView)
        view.addSubview(closeButton)
        setupLayout()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
