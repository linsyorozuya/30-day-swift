//
//  CollectionViewCell.swift
//  CollectionView
//
//  Created by linsyorozuya on 2017/8/31.
//  Copyright © 2017年 linsyorozuya. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    
    var interest:Interest!{
        didSet {
           self.imageView.image = self.interest.featuredImage
           self.infoLabel.text = self.interest.title
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
}
