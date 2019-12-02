//
//  articleCollectionViewCell.swift
//  Catwalk.lk
//
//  Created by Wins Thevaa on 11/8/19.
//  Copyright © 2019 Wins Thevaa. All rights reserved.
//

import UIKit

class articleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var dateTime: UILabel!
    
    var image : UIImage! {
        
       didSet{
            self.articleImage.image = image
             //imageView.layer.cornerRadius = 12
        }
    }
}
