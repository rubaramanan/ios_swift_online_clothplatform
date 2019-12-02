//
//  productCollectionViewCell.swift
//  Catwalk.lk
//
//  Created by Wins Thevaa on 10/31/19.
//  Copyright © 2019 Wins Thevaa. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase

protocol favourite {
    func favourite_update()
}

class productCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView : UIImageView!
    
    @IBOutlet weak var likeimageviewconstraint: NSLayoutConstraint!
   
    @IBOutlet weak var likeimageview: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var shop: UILabel!
    @IBOutlet weak var category: UILabel!
    
    @IBOutlet weak var like: UIButton!
    
    var delegate: favourite?
    
    lazy var likeanimate = likeanimator(container: contentView, layoutconstraint: likeimageviewconstraint)
    
    override func awakeFromNib() {
        super.awakeFromNib()
       // imageView.addGestureRecognizer(doubletaprecognizer)
    }
    
    var image : UIImage! {
        
       didSet{
            self.imageView.image = image
             //imageView.layer.cornerRadius = 12
        }
    }
    
    
    
    lazy var doubletaprecognizer: UITapGestureRecognizer = {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tapRecognizer.numberOfTapsRequired = 2
        return tapRecognizer
    }()
    
    @objc func doubleTapped(){
        likeanimate.animate { [weak self] in
            
            self!.like.tintColor = .red
            self!.like.setImage(UIImage(named: "clickheart"), for: .normal)
            self!.like.tag=0
        }
    }
    
    @IBAction func love(_ sender: Any) {
        
//        if Auth.auth().currentUser == nil{
//            alertView(message: "you must login or create account for save whishlist")
//        }
       // delegate?.favourite_update()
        
//        if like.tag==0{
//        like.setImage(UIImage(named: "heart"), for: .normal)
//        like.tag=1
//        like.tintColor = .red
//           }
//           else if like.tag==1{
//               like.tintColor = .red
//               like.setImage(UIImage(named: "clickheart"), for: .normal)
//               like.tag=0
//
//           }
        
    }
    
}


 
