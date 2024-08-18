//
//  ImageViewCell.swift
//  Mobile Up Gallery
//
//  Created by Ivan Elonov on 17.08.2024.
//

import UIKit

class ImageViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.clipsToBounds = false
        
        containerView.clipsToBounds = true
        imageButton.translatesAutoresizingMaskIntoConstraints = false
        imageButton.clipsToBounds = true

    }
    
    static func nib() -> UINib {
        return UINib(nibName: "ImageViewCell", bundle: nil)
    }
}
