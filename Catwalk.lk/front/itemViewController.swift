//
//  itemViewController.swift
//  Catwalk.lk
//
//  Created by Wins Thevaa on 10/31/19.
//  Copyright © 2019 Wins Thevaa. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Firebase
import FirebaseFirestore


class itemViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    var collectionViewlayout: UICollectionViewFlowLayout!
    
    let itemapi = "http://catwalk.cypercode.com/trends"
    var items = [item]()
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        db=Firestore.firestore()
      //  self.view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        downloadJson()
        
        view.backgroundColor = UIColor.white
        view.addSubview(activityIndicator)
        activityIndicator.frame = view.bounds
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.4)
        makeServiceCall()

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionviewitemsize()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: "productCollectionViewCell", for: indexPath) as! productCollectionViewCell
        //cellA.delegate = self
        
                   Alamofire.request(items[indexPath.row].image).responseData { (response) in
                                if response.error == nil {
                                    print(response.result)
                   
                                    // Show the downloaded image:
                                    if let data = response.data {
                                       cellA.imageView.image = UIImage(data: data)
                                    }
                                }
                            }
                   cellA.name.text = items[indexPath.row].title
                  
                   cellA.Price.text = "\(items[indexPath.row].price)"
                   cellA.Price.textColor = .red
                   
                   cellA.shop.text = items[indexPath.row].shop
                   cellA.category.text = items[indexPath.row].category
                   cellA.layer.cornerRadius=10
                   cellA.imageView?.layer.cornerRadius=12
                   cellA.layer.borderWidth=0.5
       
//          cellA.like.addTarget(self, action: #selector(favourite_update), for: UIControl.Event.touchUpInside)
        if cellA.like.tag==0{
            cellA.like.setImage(UIImage(named: "heart"), for: .normal)
                    cellA.like.tag=1
                    cellA.like.tintColor = .red
                
            }else if cellA.like.tag==1{
                cellA.like.tintColor = .red
            let washingtonRef = db.collection("user").document((Auth.auth().currentUser?.email)!)
                                 
                                              washingtonRef.updateData([
                                                  "FavItems": FieldValue.arrayUnion([[
                                                   "image": items[indexPath.row].image,
                                                   "price": items[indexPath.row].price,
                                                   "title": items[indexPath.row].title,
                                                   "shop": items[indexPath.row].shop,
                                                   "url": items[indexPath.row].link
                                                      ]])
                                              ])
                               cellA.like.setImage(UIImage(named: "clickheart"), for: .normal)
                               cellA.like.tag=0
                               
                
                   
                
            }
        
        
                   return cellA
        
        
        
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let url = NSURL(string: items[indexPath.row].link)
        if url != nil{
           // UIApplication.shared.openURL(url! as URL)
            UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
        }
    }
    
    private func collectionviewitemsize(){
       
        if collectionViewlayout == nil{
               let numofitemsperRaw: CGFloat = 2
               let linespacing: CGFloat = 9
               let interItemspacing: CGFloat = 7

               let width = (collectionView.frame.width-(numofitemsperRaw-1)*interItemspacing)/numofitemsperRaw

        let height = collectionView.frame.height/2.2

             //  collectionViewlayout.scrollDirection = .horizontal
               collectionViewlayout = UICollectionViewFlowLayout()
               collectionViewlayout.itemSize = CGSize(width: width, height: height)
               collectionViewlayout.sectionInset = UIEdgeInsets.zero
               collectionViewlayout.minimumLineSpacing = linespacing
               collectionViewlayout.minimumInteritemSpacing = interItemspacing
               

               collectionView.setCollectionViewLayout(collectionViewlayout, animated: true)
           }
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
                   
                    
                    self.collectionView.reloadData()
                    
                    
                case .failure(let error):
                    print("\(error.localizedDescription)")
                    break
                }
            }
        }
   private func makeServiceCall() {
           activityIndicator.startAnimating()
           DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(15)) {
              self.activityIndicator.stopAnimating()
           }
        }
    
    @objc func favourite_update(sender: UIButton!) {
    
//    if Auth.auth().currentUser == nil{
//                alertView(message: "you must login or create account for save whishlist")
//    }
    
}
    

    func alertView(message:String){
        let alert = UIAlertController(title: "Hi User", message:message ,preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            
            
        }
        
        alert.addAction(OKAction)
        
        self.present(alert, animated: true, completion:nil)
    }
    
    
        
        
        //
                

                     // Nor did this
                
    
    
}
