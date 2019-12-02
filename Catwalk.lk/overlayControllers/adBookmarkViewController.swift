//
//  adBookmarkViewController.swift
//  Catwalk.lk
//
//  Created by Wins Thevaa on 11/7/19.
//  Copyright © 2019 Wins Thevaa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class adBookmarkViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableview: UITableView!
    
    var Articles = [String:AnyObject]()
    var arti = [String]()
    var Articleslike = [Articlelike]()

    var db:Firestore!
    override func viewDidLoad() {
        super.viewDidLoad()

        db = Firestore.firestore()
        tableview.delegate = self
        tableview.dataSource = self
        getArticleArray()
        
        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Articleslike.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell1", for: indexPath) as! ArticleTableViewCell
        
        let arti = Articleslike[indexPath.row]
        let url = URL(string: arti.poster)
        let data = try! Data(contentsOf: url!)
        let image : UIImage = UIImage(data: data)!
        cell.articleImage.image = image
        cell.contentLittle.text = arti.content
        cell.Title.text = arti.title
        cell.dateTime.text = arti.date
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
             tableView.deselectRow(at: indexPath, animated: true)
            
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let article = storyboard.instantiateViewController(withIdentifier: "ArticleFullViewController") as! ArticleFullViewController

                    
                   let arti = Articleslike[(indexPath.row)]
    
                    let url = URL(string: arti.poster)
                    let data = try! Data(contentsOf: url!)
                    let image : UIImage = UIImage(data: data)!
                    article.getArticle = arti.content
                    article.getTitle = arti.title
                    article.getDate = arti.date
                    article.getAuthor = arti.Author
                article.getimageurl = arti.poster
                article.getPic = image
            
                    navigationController?.pushViewController(article, animated: true)
                
            }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func getArticleArray(){
        let docRef = db.collection("user").document((Auth.auth().currentUser?.email)!)
        
        docRef.getDocument{ (document, error) in
            if let document = document, document.exists {
                
                let articles = document.data()!["ArticleBookmark"] as! NSArray
                print(articles)
                
                for article in articles{
                    self.Articleslike.append(Articlelike(articleJson1: article as! NSDictionary))
                }
                
                print(self.Articleslike.count)
                self.tableview.reloadData()
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
