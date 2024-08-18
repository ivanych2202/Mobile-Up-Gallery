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
    
    var images: [Image] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        title = "MobileUp Gallery"
        
        let exitButton = UIBarButtonItem(title: "Выход", style: .plain, target: self, action: #selector(exitButtonPressed))
        exitButton.tintColor = .black
        navigationItem.rightBarButtonItem = exitButton
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImageViewCell.nib(), forCellWithReuseIdentifier: "ImageViewCell")

        
        loadImages()
    }


    @objc func exitButtonPressed() {
        self.dismiss(animated: true)
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
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
 

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageViewCell", for: indexPath) as! ImageViewCell
        let image = images[indexPath.item]

        if let urlString = image.mediumImageUrl,
           let url = URL(string: urlString) {
            cell.imageButton.sd_setImage(with: url, for: .normal, placeholderImage: UIImage(named: "placeholder"))
        }
        cell.imageButton.tag = indexPath.item
        cell.imageButton.addTarget(self, action: #selector(imageButtonTapped(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width / 2 - 10
        let height = width
      
        return CGSize(width: width, height: height)
        
    }
    
    
    

    @objc func imageButtonTapped(_ sender: UIButton) {
        let imageIndex = sender.tag
        let selectedImage = images[imageIndex]
        print("Изображение выбрано: \(selectedImage)")
        
    }
}


