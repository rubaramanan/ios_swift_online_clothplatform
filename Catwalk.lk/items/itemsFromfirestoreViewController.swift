//
//  itemsFromfirestoreViewController.swift
//  Catwalk.lk
//
//  Created by Wins Thevaa on 11/8/19.
//  Copyright © 2019 Wins Thevaa. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class itemsFromfirestoreViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var collectionViewlayout: UICollectionViewFlowLayout!
    var items = [item]()
    @IBOutlet weak var collectionview: UICollectionView!
    let itemapi = "http://catwalk.cypercode.com/trends"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionview.delegate = self
        collectionview.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func like(_ sender: Any) {
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCollectionViewCell", for: indexPath) as! productCollectionViewCell
        if collectionViewlayout == nil{
                  // let numofitemsperRaw: CGFloat = 2
                   let linespacing: CGFloat = 7
                   let interItemspacing: CGFloat = 15

            let height = (collectionview.frame.height)

            let width = collectionview.frame.width/2

            collectionViewlayout = UICollectionViewFlowLayout()
            collectionViewlayout.itemSize = CGSize(width: width, height: height)
            collectionViewlayout.sectionInset = UIEdgeInsets.zero
            collectionViewlayout.scrollDirection = .horizontal
            collectionViewlayout.minimumLineSpacing = linespacing
            collectionViewlayout.minimumInteritemSpacing = interItemspacing
                   

            collectionview.setCollectionViewLayout(collectionViewlayout, animated: true)
               }
        
        collectionview.reloadData()
        
        return cell
    }
    
    func downloadJson(){
               
               Alamofire.request(itemapi).responseJSON{response in
                   switch response.result{
                   case .success(let value):
                       let json = JSON(value)
                       let data = json["trends"]
                       
       //                if let arti = data.array{
       //                    self.articles = arti.map({Article(articleJson: JSON($0.object))})
       //
       //                }
                       
                       data.array?.forEach({(user) in
                           self.items.append(item(itemJson: user))
                           print(self.items)
                           print("//////")
                       
                       })
                      
                       
                       self.collectionview.reloadData()
                       
                       
                   case .failure(let error):
                       print("\(error.localizedDescription)")
                       break
                   }
               }
           }

}
