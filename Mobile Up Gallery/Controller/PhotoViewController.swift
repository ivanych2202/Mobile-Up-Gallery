//
//  PhotoViewController.swift
//  Mobile Up Gallery
//
//  Created by Ivan Elonov on 15.08.2024.
//

import UIKit
import SDWebImage

class PhotoViewController: UIViewController {

    @IBOutlet weak var backButton: UINavigationItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    
    var urlString: String?
    var date: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let urlString = urlString,
           let url = URL(string: urlString) {
            imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
            
            if let date = date {
                let timestamp = TimeInterval(date)
                let date = Date(timeIntervalSince1970: timestamp)
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "d MMMM yyyy"
                let readableDate = dateFormatter.string(from: date)
                
                title = readableDate
            }
        }
        
        shareButton.target = self
        shareButton.action = #selector(shareButtonPressed)
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func shareButtonPressed(_ sender: UIBarButtonItem) {
        guard let image = imageView.image else { return }
        
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityViewController.popoverPresentationController?.barButtonItem = shareButton
        
        present(activityViewController, animated: true) {
            
        }
        
        activityViewController.completionWithItemsHandler = { activityType, completed, returnedItems, error in
            if completed, activityType == UIActivity.ActivityType.saveToCameraRoll {
                let alert = UIAlertController(title: "Success", message: "Image saved to gallery", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
}
