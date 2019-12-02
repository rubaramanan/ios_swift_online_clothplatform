//
//  item.swift
//  Catwalk.lk
//
//  Created by Wins Thevaa on 11/8/19.
//  Copyright © 2019 Wins Thevaa. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON


class items{
    let Items: [item]
    
    init(items: [item] ) {
        self.Items = items
    }
}


class item{

    let category: String
    let image: String
    let link: String
    let price: Double
    let shop: String
    let title: String
   
    
    init(itemJson: JSON) {
        self.category = itemJson["category"].stringValue
        self.image = itemJson["image"].stringValue
        self.link = itemJson["link"].stringValue
        self.price = itemJson["price"].doubleValue
        self.shop = itemJson["shop"].stringValue
        self.title = itemJson["title"].stringValue
        
    }
}
