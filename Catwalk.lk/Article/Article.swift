//
//  Article.swift
//  Catwalk.lk
//
//  Created by Wins Thevaa on 11/3/19.
//  Copyright © 2019 Wins Thevaa. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class Articles{
    let articles: [Article]
    
    init(articles: [Article] ) {
        self.articles=articles
    }
}


class Article{

    let content: String
    let author: String
    let poster: String
    let date: String
    let source: String
    let title: String
   // let content: String
    let images: [String]
   // var imageArr: [UIImage]
    
    init(articleJson: JSON) {
        self.content=articleJson["Content"].stringValue
        self.author=articleJson["author"].stringValue
        self.poster=articleJson["poster"].stringValue
        self.date=articleJson["publishedDate"].stringValue
        self.source=articleJson["source"].stringValue
        self.title=articleJson["title"].stringValue
        self.images=[articleJson["images"].stringValue]
        
    }
}


