//
//  VideoViewController.swift
//  Mobile Up Gallery
//
//  Created by Ivan Elonov on 15.08.2024.
//

import UIKit
import WebKit

class VideoViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    var urlString: String?
    var videoTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        
        setupWebView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        exitFullScreen()
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    func setupWebView() {
        if let videoTitle = videoTitle {
            title = videoTitle
        }
        if let urlString = urlString,
           let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
}


extension VideoViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    }
    
    func enterFullScreen() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func exitFullScreen() {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

