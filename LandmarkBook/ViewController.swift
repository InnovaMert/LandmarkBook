//
//  ViewController.swift
//  LandmarkBook
//
//  Created by Appcent on 7.01.2022.
//

import UIKit
import ReactiveKit
import Bond

class ViewController: UIViewController,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var lblPageTitle: UILabel!
    @IBOutlet weak var landmarkCollectionView: UICollectionView! {
        didSet {
            landmarkCollectionView.register(LandmarkCell.self, forCellWithReuseIdentifier: "LandmarkCell")
        }
    }

    var landmarkArray = MutableObservableArray<ArrayModel>()
    var landArray : [ArrayModel] = [ArrayModel(image: UIImage(named: "collesium"), name: "Collesium"),
                                    ArrayModel(image: UIImage(named: "eiffel"), name: "Eiffel Tower"),
                                    ArrayModel(image: UIImage(named: "stonehenge"), name: "Stonehenge"),
                                    ArrayModel(image: UIImage(named: "tajmahal"), name: "Taj Mahal")]

    var chosenImage = UIImage()
    var chosenName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        landmarkCollectionView.delegate = self
        landmarkArray.replace(with: landArray)
        bind()

        self.navigationItem.leftBarButtonItem = editButtonItem
    }

    func bind() {

        landmarkArray.bind(to: landmarkCollectionView, cellType: LandmarkCell.self) { cell, land in
            cell.landImageView.image = land.image
            cell.lblLandName.text = land.name
            cell.isUserInteractionEnabled = true
            cell.delegate = self
        }

    }

    func collectionView(_ collectionView: UICollectionView,
                        layout _: UICollectionViewLayout,
                        sizeForItemAt _: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width / 2, height: 140)
    }

    func collectionView(_: UICollectionView,
                        layout _: UICollectionViewLayout,
                        insetForSectionAt _: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    }

    func collectionView(_: UICollectionView,
                        layout _: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt _: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        chosenImage = landArray[indexPath.row].image!
        chosenName = landArray[indexPath.row].name

        performSegue(withIdentifier: "toDetails", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetails" {
            let vc = segue.destination as! DetailsViewController
            vc.selectedName = chosenName
            vc.selectedImage = chosenImage
        }
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        let indexPaths = landmarkCollectionView.indexPathsForVisibleItems
        for indexPath in indexPaths {
            if let cell = landmarkCollectionView.cellForItem(at: indexPath) as? LandmarkCell {
                cell.isEditing = editing
            }
        }
    }
}


extension ViewController: LandmarkCellDelegate {
    func delete(cell: LandmarkCell) {
        if let indexPath = landmarkCollectionView.indexPath(for: cell) {
            landmarkArray.remove(at: indexPath.item)
            landArray.remove(at: indexPath.item)
            landmarkCollectionView.deleteItems(at: [indexPath])
        }
    }

}
