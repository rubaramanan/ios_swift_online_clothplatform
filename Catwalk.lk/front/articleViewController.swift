//
//  articleViewController.swift
//  Catwalk.lk
//
//  Created by Wins Thevaa on 10/31/19.
//  Copyright © 2019 Wins Thevaa. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import FirebaseFirestore

class articleViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate {
    
    lazy var refresher:UIRefreshControl = {
        let refreshcontrol = UIRefreshControl()
        refreshcontrol.tintColor = .blue
        refreshcontrol.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        return refreshcontrol
    }()
    
    var collectionViewlayout: UICollectionViewFlowLayout!
     private let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    
    let articleApi: String = "http://catwalk.cypercode.com/article"
    var content = [String]()
    var imageArr = [UIImage]()
    var articles = [Article]()
    var articles1 = [Article1]()
    
    var images1 = [String]()
     var db: Firestore!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @objc func reloadData(){
           
           print("hello")
           let deadLine = DispatchTime.now() + .milliseconds(600)
           DispatchQueue.main.asyncAfter(deadline: deadLine){
            self.downloadJson()
            self.downloadfireArti()
               self.refresher.endRefreshing()
           }
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db=Firestore.firestore()
        tableView.delegate=self
        tableView.dataSource=self
        view.addSubview(tableView)
        tableView.rowHeight = 160
         downloadJson()
        downloadfireArti()
        
        tableView.refreshControl = refresher
        view.backgroundColor = UIColor.white
        view.addSubview(activityIndicator)
        activityIndicator.frame = view.bounds
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.4)
        makeServiceCall()
        
        
        //getImageArray(urls: images1)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return articles.count+1
        return ((articles.count)+1)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height:CGFloat = CGFloat()
                if indexPath.row == 0 {
                               height = 255
                           }
                           else {
                               height = 160
                           }
        
            

            return height
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        if row==0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "article1TableViewCell", for: indexPath) as! article1TableViewCell
            //tableView.reloadData()
            cell.collectionview.delegate = self
            cell.collectionview.dataSource = self
            cell.collectionview.tag = indexPath.row
            
            
            if collectionViewlayout == nil{
                      // let numofitemsperRaw: CGFloat = 2
                       let linespacing: CGFloat = 7
                       let interItemspacing: CGFloat = 15

                let height = (cell.collectionview.frame.height)

                let width = cell.collectionview.frame.width/2

                collectionViewlayout = UICollectionViewFlowLayout()
                collectionViewlayout.itemSize = CGSize(width: width, height: height)
                collectionViewlayout.sectionInset = UIEdgeInsets.zero
                collectionViewlayout.scrollDirection = .horizontal
                collectionViewlayout.minimumLineSpacing = linespacing
                collectionViewlayout.minimumInteritemSpacing = interItemspacing
                       

                cell.collectionview.setCollectionViewLayout(collectionViewlayout, animated: true)
                   }
            
            cell.collectionview.reloadData()
            return cell
            
        }
        if row>=1{
         
            let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as! ArticleTableViewCell
                let arti = articles[(indexPath.row)-1]
               
                
                Alamofire.request(arti.poster).responseData { (response) in
                             if response.error == nil {
                                 print(response.result)

                                 // Show the downloaded image:
                                 if let data = response.data {
                                    cell.articleImage.image = UIImage(data: data)
                                 }
                             }
                         }
                
                //cell.articleImage.image = imageArr1[row-1]
                cell.Title.text = arti.title
                cell.contentLittle.text = arti.content
                cell.dateTime.text = arti.date


                cell.backgroundColor = UIColor.white
                cell.layer.borderColor = UIColor.black.cgColor
                cell.layer.borderWidth = 2
                cell.layer.cornerRadius = 12
                cell.clipsToBounds = true
            return cell
        }
        
         return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row>=1{
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let article = storyboard.instantiateViewController(withIdentifier: "ArticleFullViewController") as! ArticleFullViewController

                
               let arti = articles[(indexPath.row)-1]
//                 Alamofire.request(arti.poster).responseData { (response) in
//                              if response.error == nil {
//                                  print(response.result)
//
//                                  // Show the downloaded image:
//                                  if let data = response.data {
//                                    article.getPic = UIImage(data: data)!
//                                  }
//                              }
//                          }
                let url = URL(string: arti.poster)
                let data = try! Data(contentsOf: url!)
                let image : UIImage = UIImage(data: data)!
                article.getArticle = arti.content
                article.getTitle = arti.title
                article.getDate = arti.date
                article.getAuthor = arti.author
            article.getimageurl = arti.poster
            article.getPic = image
            

            print(self.navigationController)
                navigationController?.pushViewController(article, animated: true)
            }
        }
           
    
    func downloadJson(){
//        let configuration = URLSessionConfiguration.default
//        configuration.timeoutIntervalForRequest = 20
//        configuration.timeoutIntervalForResource = 20

           // let sessionManager = Alamofire.SessionManager(configuration: configuration)
            Alamofire.request(articleApi).responseJSON{response in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                let data = json["articles"]
                
//                if let arti = data.array{
//                    self.articles = arti.map({Article(articleJson: JSON($0.object))})
//
//                }
                
                data.array?.forEach({(user) in
                    self.articles.append(Article(articleJson: user))
                   // self.images1.append(Article(articleJson: user).poster)
                    
                })
               
                
                self.tableView.reloadData()
                
                
            case .failure(let error):
                print("\(error.localizedDescription)")
                break
            }
        }
    }
    
    func downloadfireArti(){
        db.collection("AproveArticles").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.articles1.append(Article1(articleJson1: document))
                }
                
                self.tableView.reloadData()
            }
        }
    }
   
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles1.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "articleCollectionViewCell", for: indexPath) as! articleCollectionViewCell
        
        
        let arti = articles1[indexPath.row]
        Alamofire.request(arti.poster).responseData { (response) in
            if response.error == nil {
                print(response.result)

                // Show the downloaded image:
                if let data = response.data {
                    cell.articleImage.image = UIImage(data: data)!
                }
            }
        }
        cell.content.text = arti.contentlitle
        cell.title.text = arti.title
       // cell.dateTime.text = "\(arti.date)"
//        cell.dateTime.text = arti.date
        cell.layer.cornerRadius=10
        cell.articleImage?.layer.cornerRadius=12
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let html = storyboard?.instantiateViewController(withIdentifier: "htmlarticleViewController") as! htmlarticleViewController
        let arti = articles1[indexPath.row]
        html.htmlString = arti.content
        navigationController?.pushViewController(html, animated: true)
        
       
    }
    
   private func makeServiceCall() {
         activityIndicator.startAnimating()
         DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(10)) {
            self.activityIndicator.stopAnimating()
         }
      }
    
}
