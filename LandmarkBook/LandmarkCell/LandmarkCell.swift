//
//  LandmarkCell.swift
//  LandmarkBook
//
//  Created by Appcent on 7.01.2022.
//

import UIKit

protocol LandmarkCellDelegate: class {

    func delete(cell: LandmarkCell)

}

class LandmarkCell: UICollectionViewCell {

    @IBOutlet weak var landImageView: UIImageView!
    @IBOutlet weak var lblLandName: UILabel!
    @IBOutlet weak var generalView: UIView!
    @IBOutlet weak var deleteButton: UIButton!

    weak var delegate: LandmarkCellDelegate?

    var isEditing: Bool = false {
        didSet {
            deleteButton.isHidden = !isEditing
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        deleteButton.isHidden = true
        layer.masksToBounds = false
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 5

        generalView.layer.masksToBounds = true
        generalView.layer.cornerRadius = 10
        landImageView.layer.masksToBounds = true
        landImageView.layer.cornerRadius = 10

    }

    override func prepareForReuse() {
        super.prepareForReuse()
        landImageView.image = UIImage(named: "")
        lblLandName.text = ""
    }
    @IBAction func deleteButtopTapped(_ sender: Any) {
        delegate?.delete(cell: self)
    }

}
