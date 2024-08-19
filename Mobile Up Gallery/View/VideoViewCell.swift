//
//  VideoViewCell.swift
//  Mobile Up Gallery
//
//  Created by Ivan Elonov on 18.08.2024.
//

import UIKit

class VideoViewCell: UICollectionViewCell {
    

    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var videoDescriptionLabel: UILabel!
    @IBOutlet weak var containerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.clipsToBounds = false
        
        containerView.clipsToBounds = true
        imageButton.translatesAutoresizingMaskIntoConstraints = false
        imageButton.clipsToBounds = true
        
        videoDescriptionLabel.layer.cornerRadius = 20
        videoDescriptionLabel.clipsToBounds = true

    }
    
    static func nib() -> UINib {
        return UINib(nibName: "VideoViewCell", bundle: nil)
    }
}
