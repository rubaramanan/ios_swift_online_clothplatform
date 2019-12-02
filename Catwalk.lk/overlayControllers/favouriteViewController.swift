//
//  favouriteViewController.swift
//  Catwalk.lk
//
//  Created by Wins Thevaa on 11/7/19.
//  Copyright © 2019 Wins Thevaa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import Alamofire

class favouriteViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var db: Firestore!
    var Items = [String:AnyObject]()
    var itemi = [String]()
    var FavouriteItem = [favouriteitem]()
    @IBOutlet weak var collectionview: UICollectionView!
    var collectionViewlayout: UICollectionViewFlowLayout!
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionviewitemsize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        db = Firestore.firestore()
        collectionview.delegate = self
        collectionview.dataSource = self
        getitemArray()
        // Do any additional setup after loading the view.
    }
    

    private func collectionviewitemsize(){
       
        if collectionViewlayout == nil{
               let numofitemsperRaw: CGFloat = 2
               let linespacing: CGFloat = 9
               let interItemspacing: CGFloat = 7

               let width = (collectionview.frame.width-(numofitemsperRaw-1)*interItemspacing)/numofitemsperRaw

        let height = collectionview.frame.height/2.3

             //  collectionViewlayout.scrollDirection = .horizontal
               collectionViewlayout = UICollectionViewFlowLayout()
               collectionViewlayout.itemSize = CGSize(width: width, height: height)
               collectionViewlayout.sectionInset = UIEdgeInsets.zero
               collectionViewlayout.minimumLineSpacing = linespacing
               collectionViewlayout.minimumInteritemSpacing = interItemspacing
               

               collectionview.setCollectionViewLayout(collectionViewlayout, animated: true)
           }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FavouriteItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCollectionViewCell1", for: indexPath) as! productCollectionViewCell
        cell.name.text = FavouriteItem[indexPath.row].title
        cell.Price.text = "\(FavouriteItem[indexPath.row].price)"
        cell.shop.text = FavouriteItem[indexPath.row].shop
        
        Alamofire.request(FavouriteItem[indexPath.row].image).responseData { (response) in
                                      if response.error == nil {
                                          print(response.result)
        
                                          // Show the downloaded image:
                                          if let data = response.data {
                                            cell.imageView.image = UIImage(data: data)!
                                          }
                                      }
                                  }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           let url = NSURL(string: FavouriteItem[indexPath.row].url)
           if url != nil{
              // UIApplication.shared.openURL(url! as URL)
               UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
           }
       }
    
    func getitemArray(){
            let docRef = db.collection("user").document((Auth.auth().currentUser?.email)!)
            
            docRef.getDocument{ (document, error) in
                if let document = document, document.exists {
                    
                    let items = document.data()!["FavItems"] as! NSArray
                    print(items)
                    
                    for article in items{
                        self.FavouriteItem.append(favouriteitem(map: article as! NSDictionary))
                    }
                    
                    print(self.FavouriteItem.count)
                    self.collectionview.reloadData()
    //               let dataDescription = document.data()//.map(String.init(describing:)) ?? "nil"
    //
    //                Articles.append(description["ArticleBookmark"] as! NSArray)
    //                //print("Document data: \(dataDescription)")
                } else {
                    print("Document does not exist")
                }
            }
            
        }

}
