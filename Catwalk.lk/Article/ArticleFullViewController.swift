//
//  ArticleFullViewController.swift
//  Catwalk.lk
//
//  Created by Wins Thevaa on 11/2/19.
//  Copyright © 2019 Wins Thevaa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class ArticleFullViewController: UIViewController {
    
    var getTitle = String()
    var getPic = UIImage()
    var getArticle = String()
    var getDate = String()
    var getAuthor = String()
    var getimageurl = String()
    var db: Firestore!
   
    @IBOutlet weak var title1: UITextView!
    @IBOutlet weak var scroll: UIScrollView!
    
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var articlepic: UIImageView!
    
    @IBOutlet weak var Author: UILabel!
    @IBOutlet weak var datetime: UILabel!
    @IBOutlet weak var bookmark: UIButton!
    @IBOutlet weak var like: UIButton!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var content: UITextView!
    
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        db = Firestore.firestore()
        title1.text=getTitle
        content.text=getArticle
        articlepic.image=getPic
        datetime.text=getDate
        Author.text=getAuthor
    
        title1.isScrollEnabled=false
        title1.isSelectable = false
        title1.isEditable = false
        content.isScrollEnabled=false
        content.isSelectable = false
        content.isEditable = false
        
        
        if Auth.auth().currentUser == nil{
            bookmark.isHidden = true
            
        }else{
            bookmark.isHidden = false
            
        }
        
    }
    
    @IBAction func touchBookmark(_ sender: Any) {
        
        if bookmark.tag==0{
        bookmark.setImage(UIImage(named: "bookmark"), for: .normal)
        bookmark.tag=1
        bookmark.tintColor = .red
            
            
           }
           else if bookmark.tag==1{
               bookmark.tintColor = .red
               bookmark.setImage(UIImage(named: "clickbookmark"), for: .normal)
               bookmark.tag=0
            
            bookmarkArticle()

           }

    }
    
    
    func bookmarkArticle(){
       // let batch = Firestore.firestore().batch()
        let washingtonRef = db.collection("user").document((Auth.auth().currentUser?.email)!)
//
//
            washingtonRef.updateData([
                "ArticleBookmark": FieldValue.arrayUnion([[
                    "title": getTitle,
                    "Article": getArticle,
                    "poster": getimageurl,
                    "Author": getAuthor,
                    "Date": getDate
                    ]])
            ])
//
        

             // Nor did this
        }
            
    

               
        }
        // Atomically add a new region to the "regions" array field.
//        washingtonRef.updateData([
//            "capital": "true"
//        ]) { err in
//            if let err = err {
//                print("Error updating document: \(err)")
//            } else {
//                print("Document successfully updated")
//            }
//        }
       


