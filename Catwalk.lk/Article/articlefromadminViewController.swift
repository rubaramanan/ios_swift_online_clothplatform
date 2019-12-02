//
//  articlefromadminViewController.swift
//  Catwalk.lk
//
//  Created by Wins Thevaa on 11/11/19.
//  Copyright © 2019 Wins Thevaa. All rights reserved.
//

import UIKit
import WebKit
import ARKit
import Firebase
import FirebaseFirestore

class articlefromadminViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    @IBOutlet weak var articlepic: UIImageView!
    @IBOutlet weak var title1: UITextView!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var dateTime: UILabel!
    @IBOutlet weak var bookmark: UIButton!
    @IBOutlet weak var likeCount: UILabel!
    
    @IBOutlet weak var contentview: UIView!
    @IBOutlet weak var like: UIButton!
    
    var getTitle = String()
    var getPic = UIImage()
    var getArticle = String()
    
    var getDate = String()
   // var getAuthor = String()
    
    
    var db: Firestore!
       

    override func viewDidLoad() {
        super.viewDidLoad()

      //  view.bringSubviewToFront(contentview)
        title1.isScrollEnabled=false
        title1.isSelectable = false
        title1.isEditable = false
        
        db=Firestore.firestore()
        
        title1.text = getTitle
        articlepic.image = getPic
        let html = storyboard?.instantiateViewController(withIdentifier: "htmlarticleViewController") as! htmlarticleViewController
        
       // contentview.bringSubviewToFront(html.view)
    }
    
    struct Stroryboard {
        static let html = "htmlarticleViewController"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Stroryboard.html{
            if let imagePageVc = segue.destination as? htmlarticleViewController{
                imagePageVc.htmlString = getArticle
            }
        }
    }

    

}
