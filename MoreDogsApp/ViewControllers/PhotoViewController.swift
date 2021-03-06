//
//  PhotoViewController.swift
//  MoreDogsApp
//
//  Created by Vasichko Anna on 24.01.2022.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photoImageView.image = image
    }
    

    @IBAction func shareButton(_ sender: UIButton) {
      showShareSheet()
  
}
    
    private func showShareSheet() {
        let shareSheet = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
        present(shareSheet, animated: true, completion: nil)
    }
}
