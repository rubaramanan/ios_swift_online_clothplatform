//
//  ArticleTableViewCell.swift
//  Catwalk.lk
//
//  Created by Wins Thevaa on 11/2/19.
//  Copyright © 2019 Wins Thevaa. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var contentLittle: UILabel!
    @IBOutlet weak var dateTime: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        articleImage.layer.cornerRadius=10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
