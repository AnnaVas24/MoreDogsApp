//
//  PhotosViewController.swift
//  MoreDogsApp
//
//  Created by Vasichko Anna on 22.01.2022.
//

import UIKit



class PhotosViewController: UICollectionViewController {

    private var dogs: Dogs?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDogs()
        
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dogs?.message.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCell
        if let dog = dogs?.message[indexPath.item] {
        cell.configure(with: dog)
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let photoVC = segue.destination as? PhotoViewController else {return}
        guard let cell = sender as? PhotoCell else { return }
        photoVC.image = cell.dogImage.image
    }

    private func fetchDogs() {
        NetworkManager.shared.fetchData { result in
            switch result {
            case .success(let newDogs):
                self.dogs = newDogs
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func repeatButton(_ sender: UIBarButtonItem) {
        fetchDogs()
    }
    
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 2
        let paddingWidth = 20 * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow

        return CGSize(width: widthPerItem, height: widthPerItem)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
}
