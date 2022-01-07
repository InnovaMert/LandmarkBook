//
//  DetailsViewController.swift
//  LandmarkBook
//
//  Created by Appcent on 7.01.2022.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var landmarkImage: UIImageView!
    @IBOutlet weak var landmarkName: UILabel!

    var selectedImage = UIImage()
    var selectedName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        landmarkImage.image = selectedImage
        landmarkName.text = selectedName

    }




}
