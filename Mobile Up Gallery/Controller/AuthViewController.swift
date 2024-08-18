//
//  AuthViewController.swift
//  Mobile Up Gallery
//
//  Created by Ivan Elonov on 15.08.2024.
//

import UIKit
import WebKit

class AuthViewController: UIViewController{

    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var webViewAuth: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webViewAuth.navigationDelegate = self
        
        webViewAuth.isHidden = true
        
        
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "oauth.vk.com"
        urlComponent.path = "/authorize"
        
        urlComponent.queryItems = [
            URLQueryItem(name: "client_id", value: "52163510"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "responce_type", value: "token")]
        
        if let url = urlComponent.url {
            let request = URLRequest(url: url)
            webViewAuth.load(request)
        } else {
            showAlert()
        }
        webViewAuth.isHidden = false
        
    }
    
    
    func showAlert() {
        let alert = UIAlertController(title: "Ошибка", message: "Не удалось авторизоваться в ВКонтакте. Попробуйте еще раз.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


extension AuthViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        guard let url = webView.url else { return }
        
        if url.host == "oauth.vk.com" && url.path == "/blank.html" {
            if let fragment = url.fragment {
                if fragment.hasPrefix("code=") {
                    webViewAuth.isHidden = true
                    self.performSegue(withIdentifier: "AuthToMain", sender: self)
                } else {
                    showAlert()
                }
            }
        }
    }
}

