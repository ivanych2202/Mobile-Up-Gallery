//
//  MainViewController.swift
//  Mobile Up Gallery
//
//  Created by Ivan Elonov on 15.08.2024.
//

import UIKit
import SDWebImage

class MainViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    var images: [Image] = []
    var videos: [Video] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "MobileUp Gallery"

        let exitButton = UIBarButtonItem(title: "Выход", style: .plain, target: self, action: #selector(exitButtonPressed))
        exitButton.tintColor = .black
        navigationItem.rightBarButtonItem = exitButton

        collectionView.dataSource = self
        collectionView.delegate = self
     
        collectionView.register(ImageViewCell.nib(), forCellWithReuseIdentifier: "ImageViewCell")
        collectionView.register(VideoViewCell.nib(), forCellWithReuseIdentifier: "VideoViewCell")

        loadVideos()
        loadImages()
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MainToPhoto" {
            if let destinationVC = segue.destination as? PhotoViewController {
                if let imageIndex = sender as? Int {
                    let urlString = images[imageIndex].imageUrl
                    let date = images[imageIndex].date
                    destinationVC.date = date
                    destinationVC.urlString = urlString
                }
            }
        }
    }

    
    @IBAction func segmentedControlToggled(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            loadImages()
            collectionView.reloadData()
            break
        case 1:
            loadVideos()
            collectionView.reloadData()
            break
        default:
            break
        }

    }
    
    @objc func exitButtonPressed() {
        self.dismiss(animated: true)
    }

    @objc func imageButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        if segmentedControl.selectedSegmentIndex == 0 {
            performSegue(withIdentifier: "MainToPhoto", sender: index)
        }
    }

    private func loadImages() {
        ApiManager.shared.getImages { [weak self] images in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.images = images
                self.collectionView.reloadData()
            }
        }
    }

    private func loadVideos() {
        ApiManager.shared.getVideos { [weak self] videos in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.videos = videos
                self.collectionView.reloadData()
            }
        }
    }
}



extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if segmentedControl.selectedSegmentIndex == 0 {
            return images.count
        } else {
            return videos.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageViewCell", for: indexPath) as! ImageViewCell
            let image = images[indexPath.item]

            if let urlString = image.imageUrl,
               let url = URL(string: urlString) {
                cell.imageButton.sd_setImage(with: url, for: .normal, placeholderImage: UIImage(named: "placeholder"))
            }
            cell.imageButton.tag = indexPath.item
            cell.imageButton.addTarget(self, action: #selector(imageButtonTapped(_:)), for: .touchUpInside)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoViewCell", for: indexPath) as! VideoViewCell
            if indexPath.item < videos.count {
                let video = videos[indexPath.item]
                cell.videoDescriptionLabel.text = video.title
                if let urlString = video.imageUrl,
                   let url = URL(string: urlString) {
                    cell.imageButton.sd_setImage(with: url, for: .normal, placeholderImage: UIImage(named: "placeholder"))
                }
                cell.imageButton.tag = indexPath.item
                cell.imageButton.addTarget(self, action: #selector(imageButtonTapped(_:)), for: .touchUpInside)
            }
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if segmentedControl.selectedSegmentIndex == 0 {
            let width = collectionView.bounds.width / 2 - 10
            let height = width
            return CGSize(width: width, height: height)
        } else {
            
            let width = collectionView.bounds.width
            let height = width / 2
 
            return CGSize(width: width, height: height)
        }
    }
}






