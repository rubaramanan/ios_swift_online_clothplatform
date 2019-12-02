//
//  likeArticle.swift
//  Catwalk.lk
//
//  Created by Wins Thevaa on 11/13/19.
//  Copyright © 2019 Wins Thevaa. All rights reserved.
//

import Foundation

class Articleslike{
    let articleslike: [Articlelike]
    
    init(articleslike: [Articlelike] ) {
        self.articleslike=articleslike
    }
}


class Articlelike{

    let content: String
   // let author: String
    let poster: String
    let date: String
    
    let title: String
    let Author: String
   // let images: [String]
   // var imageArr: [UIImage]
    
    init(articleJson1: NSDictionary) {
        self.content = articleJson1["Article"] as! String
        self.poster = articleJson1["poster"] as! String
        self.title = articleJson1["title"] as! String
        self.Author = articleJson1["Author"] as! String
        self.date = articleJson1["Date"] as! String
      //  self.date = articleJson1["time"] as! Timestamp
       // self.date = articleJson1["time"] as!
        
    }
}
