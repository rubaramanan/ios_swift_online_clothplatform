//
//  Articlefromfire.swift
//  Catwalk.lk
//
//  Created by Wins Thevaa on 11/11/19.
//  Copyright © 2019 Wins Thevaa. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore

class Articles1{
    let articles1: [Article1]
    
    init(articles1: [Article1] ) {
        self.articles1=articles1
    }
}


class Article1{

    let content: String
   // let author: String
    let poster: String
   // let date: Timestamp
    
    let title: String
    let contentlitle: String
   // let images: [String]
   // var imageArr: [UIImage]
    
    init(articleJson1: QueryDocumentSnapshot) {
        self.content = articleJson1["article"] as! String
        self.poster = articleJson1["image"] as! String
        self.title = articleJson1["name"] as! String
        self.contentlitle = articleJson1["shortdescription"] as! String
      //  self.date = articleJson1["time"] as! Timestamp
       // self.date = articleJson1["time"] as!
        
    }
}
