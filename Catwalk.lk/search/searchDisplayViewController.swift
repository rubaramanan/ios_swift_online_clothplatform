//
//  searchDisplayViewController.swift
//  Catwalk.lk
//
//  Created by Wins Thevaa on 11/9/19.
//  Copyright © 2019 Wins Thevaa. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import PolioPager

class searchDisplayViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
   
    let api = "http://catwalk.cypercode.com/trends/"
    @IBOutlet weak var collectionview: UICollectionView!
    private let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    @IBOutlet weak var label: UILabel!
    var collectionViewlayout: UICollectionViewFlowLayout!
    var searchKey = String()
    var items = [item]()
    override func viewDidLoad() {
        super.viewDidLoad()

       // label.text = searchKey
        collectionview.delegate = self
        collectionview.dataSource = self
               downloadJson()
       
        view.backgroundColor = UIColor.white
        view.addSubview(activityIndicator)
        activityIndicator.frame = view.bounds
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.4)
        makeServiceCall()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionviewitemsize()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: "productCollectionViewCell", for: indexPath) as! productCollectionViewCell
               
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
       


        func downloadJson(){
            
            let baseUrl = NSURL(string: api)
            let components = NSURLComponents()
            components.path = searchKey
            let itemapi = components.url(relativeTo: baseUrl as URL?)
               //let itemapi =  "http://catwalk.cypercode.com/trends/fashion"
            //let boo=verifyUrl(urlString: itemapi)
            
            Alamofire.request(itemapi!).responseJSON{response in
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
                //                           print(self.items)
                //                           print("//////")
                                       
                                       })
                                       self.collectionview.reloadData()
                                       self.navigationItem.title = "\(self.items.count) results found"
                                       
                                   case .failure(let error):
                                       print("\(error.localizedDescription)")
                                       break
                                   }
                               }
            
            
           }
    
    func verifyUrl (urlString: String?) -> Bool {
        //Check for nil
        if let urlString = urlString {
            // create NSURL instance
            if let url = NSURL(string: urlString) {
                // check if your application can open the NSURL instance
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
    private func makeServiceCall() {
       activityIndicator.startAnimating()
       DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(10)) {
          self.activityIndicator.stopAnimating()
       }
    }
    
   
}
