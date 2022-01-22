//
//  PhotoCell.swift
//  MoreDogsApp
//
//  Created by Vasichko Anna on 22.01.2022.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var dogImage: UIImageView! {
        didSet {
            dogImage.layer.cornerRadius = 15
        }
    }
    
    func configure(with image: String?) {
        DispatchQueue.global().async {
            guard let stringUrl = image else { return }
            guard let imageUrl = URL(string: stringUrl) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            DispatchQueue.main.async {
                self.dogImage.image = UIImage(data: imageData)
            }
        }
    }
}
