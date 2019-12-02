//
//  itemTableViewController.swift
//  Catwalk.lk
//
//  Created by Wins Thevaa on 11/8/19.
//  Copyright © 2019 Wins Thevaa. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class itemTableViewController: UITableViewController,UICollectionViewDelegate,UICollectionViewDataSource {
   
    var collectionViewlayout: UICollectionViewFlowLayout!
    let itemapi = "http://catwalk.cypercode.com/trends"
    var items = [item]()

    let imageArr1 = [UIImage(named: "Saree"),UIImage(named: "Salwar"),UIImage(named: "Shirt"),UIImage(named: "T-shirt"),UIImage(named: "Salwar"),UIImage(named: "Saree"),]
    
    let Caption = ["What is fashion design?","how do you think fashion design?","are you like fashion design?","What is fashion design?","how do you think fashion design?","are you like fashion design?",]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 260
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        if row==0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemFromApiTableViewCell", for: indexPath) as! itemFromApiTableViewCell
            
            cell.collectionview2.delegate = self
            cell.collectionview2.dataSource = self
            cell.collectionview2.tag = indexPath.row
            
            
            if collectionViewlayout == nil{
                      // let numofitemsperRaw: CGFloat = 2
                       let linespacing: CGFloat = 7
                       let interItemspacing: CGFloat = 15

                let height = (cell.collectionview2.frame.height)

                let width = cell.collectionview2.frame.width/2

                collectionViewlayout = UICollectionViewFlowLayout()
                collectionViewlayout.itemSize = CGSize(width: width, height: height)
                collectionViewlayout.sectionInset = UIEdgeInsets.zero
                collectionViewlayout.scrollDirection = .horizontal
                collectionViewlayout.minimumLineSpacing = linespacing
                collectionViewlayout.minimumInteritemSpacing = interItemspacing
                       

                cell.collectionview2.setCollectionViewLayout(collectionViewlayout, animated: true)
                   }
            
            cell.collectionview2.reloadData()
            
            return cell
        }
        if row==1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemFromApiTableViewCell", for: indexPath) as! itemFromApiTableViewCell
            
            cell.collectionview2.delegate = self
            cell.collectionview2.dataSource = self
            
            if collectionViewlayout == nil{
                let numofitemsperRaw: CGFloat = 2
                let linespacing: CGFloat = 9
                let interItemspacing: CGFloat = 7

                let width = (cell.collectionview2.frame.width-(numofitemsperRaw-1)*interItemspacing)/numofitemsperRaw

                let height = cell.collectionview2.frame.height/2.4

                collectionViewlayout = UICollectionViewFlowLayout()
                collectionViewlayout.itemSize = CGSize(width: width, height: height)
                collectionViewlayout.sectionInset = UIEdgeInsets.zero
                collectionViewlayout.minimumLineSpacing = linespacing
                collectionViewlayout.minimumInteritemSpacing = interItemspacing
                

                cell.collectionview2.setCollectionViewLayout(collectionViewlayout, animated: true)
            }
            
            return cell
        }
        
        return UITableViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCollectionViewCell", for: indexPath) as! productCollectionViewCell
            
            Alamofire.request(items[indexPath.row].image).responseData { (response) in
                         if response.error == nil {
                             print(response.result)
            
                             // Show the downloaded image:
                             if let data = response.data {
                                cell.imageView.image = UIImage(data: data)
                             }
                         }
                     }
            
            cell.category.text = items[indexPath.row].category
            cell.shop.text = items[indexPath.row].shop
            cell.Price.text = "\(items[indexPath.row].price)"
            cell.name.text = items[indexPath.row].title
            cell.Price.textColor = .red
            
            return cell
        
        
        //return UICollectionViewCell()
       }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let url = NSURL(string: items[indexPath.row].link)
        if url != nil{
           // UIApplication.shared.openURL(url! as URL)
            UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
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
                  
                    
                   // self.collectionView2.reloadData()
                    
                    
                    
                case .failure(let error):
                    print("\(error.localizedDescription)")
                    break
                }
            }
        }
}
