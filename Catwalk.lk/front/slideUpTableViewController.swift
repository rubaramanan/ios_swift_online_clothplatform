//
//  slideUpTableViewController.swift
//  Catwalk.lk
//
//  Created by Wins Thevaa on 10/31/19.
//  Copyright © 2019 Wins Thevaa. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import Alamofire
import DTOverlayController
import FirebaseFirestore


class slideUpTableViewController: UITableViewController, signinGoogle, signout {
   
    var db: Firestore!
    var names = [String]()
    var names1 = [String]()
    var identifier = [String]()
    var identifier1 = [String]()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        names = ["Privacy Policy","Terms & Conditions","ContactUs"]
        names1 = ["Favourite Lists","Article Bookmarks","Privacy Policy","Terms & Conditions","ContactUs"]
        
        identifier = ["privacy_policyViewController","TermsViewController","ContactUsViewController"]
        identifier1 = ["favouriteViewController","adBookmarkViewController","privacy_policyViewController","TermsViewController","ContactUsViewController"]
    
        tableView.delegate=self
        tableView.dataSource=self
        db=Firestore.firestore()
        // tableView.rowHeight = 150
    }
    func login() {
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
                  let login = storyboard.instantiateViewController(withIdentifier: "loginViewController") as! loginViewController
        let overlayController = DTOverlayController(viewController: login)
        overlayController.isPanGestureEnabled = false
        overlayController.dismissableProgress = 0.4
        overlayController.isPanGestureEnabled = false
//        present(overlayController, animated: true, completion: nil)
        navigationController?.pushViewController(login, animated: true)
        
       }
    
    func signUP() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signUp = storyboard.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
        
        let overlayController = DTOverlayController(viewController: signUp)
        overlayController.dismissableProgress = 0.4
        overlayController.isPanGestureEnabled = false
//        present(overlayController, animated: true, completion: nil)
        navigationController?.pushViewController(signUp, animated: true)

    }
    func sign() {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
        self.dismiss(animated: true, completion: nil)
    }
    
    func out() {

        do {
                   try Auth.auth().signOut()
            
            self.dismiss(animated: true, completion: nil)
            
               } catch let signOutError as NSError {
                   print ("Error signing out: %@", signOutError)
               }
       }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height:CGFloat = CGFloat()
        if Auth.auth().currentUser == nil{
            if indexPath.row == 0 {
                height = 160
            }
            else {
                height = 50
            }
        }else{
            if indexPath.row == 0 {
                           height = 93
                       }
                       else {
                           height = 50
                       }
        }
        

        return height
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let currentuser = Auth.auth().currentUser
        var cellcount: Int
        if currentuser == nil{
            cellcount = 4
        }else{
            cellcount = 7
        }
        // #warning Incomplete implementation, return the number of rows
        return cellcount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentuser = Auth.auth().currentUser
        let row = indexPath.row
        
        if currentuser == nil{
            
            if row == 0 {
               let cell = tableView.dequeueReusableCell(withIdentifier: "loginSignUpTableViewCell", for: indexPath) as! loginSignUpTableViewCell
                cell.delegate = self
                
                return cell
                
            }
            if row>0 && row<4{
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
                cell?.textLabel?.text = names[row-1]
                return cell!
            }
            
            
        }else{
            if row == 0 {
                      let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
                let email = currentuser?.email
                cell.email.text = email
                
                
                if currentuser?.displayName == nil{
                    db.collection("user").document((Auth.auth().currentUser?.email)!).getDocument{ (document, error) in
                        if let document = document, document.exists {
                            let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                            let name = document.data()!["Username"] as! String
//                            print("Document data: \(dataDescription)")
//                            print(name)
                            cell.username.text = name
                        } else {
                            print("Document does not exist")
                        }
                        
                    }
                }else{
                    cell.username.text = currentuser?.displayName
                    let ref=self.db.collection("user").document(Auth.auth().currentUser!.email!).updateData([
                        "usernameBygoogleLogin": currentuser?.email
                    ])
                }
               // cell.profilePic.layer.cornerRadius = 50
                cell.profilePic.layer.borderWidth=1.0
                cell.profilePic.layer.masksToBounds = false
                cell.profilePic.layer.borderColor = UIColor.white.cgColor
                cell.profilePic.layer.cornerRadius = 30
                cell.profilePic.clipsToBounds = true
                let imageurl = currentuser?.photoURL
                if imageurl == nil{
                    cell.profilePic.image = UIImage(named: "avatar")
                }else{
                    Alamofire.request(imageurl!).responseData { (response) in
                                 if response.error == nil {
                                     print(response.result)
                    
                                     if let data = response.data {
                                         cell.profilePic!.image = UIImage(data: data)
                                     }
                                 }
                             }
                }
            
                       return cell
                       
                   }
            
            if row>0 && row<6 {
               let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
                cell?.textLabel?.text = names1[row-1]
                return cell!
            }
            if row == 6{
                    let  cell1 = tableView.dequeueReusableCell(withIdentifier: "SignOutTableViewCell", for: indexPath) as! SignOutTableViewCell
                
                cell1.delegate = self
                
                
                //dismiss(animated: true, completion: nil)
                    return cell1
            }
        }
        return UITableViewCell()
    }
  //  private var selections = Selection.allCases
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
                        tableView.deselectRow(at: indexPath, animated: true)
        let currentuser = Auth.auth().currentUser
        let row = indexPath.row
        
        if currentuser==nil{
            if row>0 && row<4{
                let vcname = identifier[row-1]
                let viewcontroller = storyboard?.instantiateViewController(identifier: vcname)
                navigationController?.pushViewController(viewcontroller!, animated: true)
            }
        }else{
            if row>0 && row<6{
                let vcname1 = identifier1[row-1]
                let viewcontroller = storyboard?.instantiateViewController(identifier: vcname1)
                navigationController?.pushViewController(viewcontroller!, animated: true)
            }
        }
                      
        //navigationController?.pushViewController(article, animated: true)
    }
    

}
