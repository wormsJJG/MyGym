//
//  gymListCollectionViewCell.swift
//  MyGym
//
//  Created by 정재근 on 2022/06/19.
//

import UIKit

class gymListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var gymTitleLabel: UILabel!
    @IBOutlet weak var gymImage: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        gymTitleLabel.text = nil
        gymImage.image = nil
    }
}
