//
//  FavouriteItem.swift
//  Catwalk.lk
//
//  Created by Wins Thevaa on 11/12/19.
//  Copyright © 2019 Wins Thevaa. All rights reserved.
//

import Foundation
import UIKit

class Favouriteitems {

    let FavouriteItems: [favouriteitem]

        init(favouriteitems: [favouriteitem]) {
            self.FavouriteItems = favouriteitems
    }
}

class favouriteitem {

    let image: String
    let url: String
    let price: Int
    let shop: String
    let title: String

    init(map: NSDictionary){
        self.image = map["image"] as! String
        self.price = map["price"] as! Int
        self.shop = map["shop"] as! String
        self.title = map["title"] as! String
        self.url = map["url"] as! String
    }

}
