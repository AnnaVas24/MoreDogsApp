//
//  PhotoCell.swift
//  MoreDogsApp
//
//  Created by Vasichko Anna on 22.01.2022.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var dogImage: UIImageView! 
    
    

    func configure(with image: String?) {
            guard let stringUrl = image else { return }
            guard let imageUrl = URL(string: stringUrl) else { return }
           getImage(from: imageUrl) { result in
                switch result {
                case .success(let image):
                    self.dogImage.image = image
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func getImage(from url: URL, completion: @escaping(Result<UIImage, Error>) -> Void) {
        if let cachedImage = ImageCache.shared.object(forKey: url.lastPathComponent as NSString) {
            completion(.success(cachedImage))
            return
        }
        
        NetworkManager.shared.fetchImage(from: url) { result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else {return}
                ImageCache.shared.setObject(image, forKey: url.lastPathComponent as NSString)
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
