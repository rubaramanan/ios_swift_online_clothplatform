//
//  loginViewController.swift
//  Catwalk.lk
//
//  Created by Wins Thevaa on 11/5/19.
//  Copyright © 2019 Wins Thevaa. All rights reserved.
//

import UIKit
import DTOverlayController
import FirebaseAuth

class loginViewController: UIViewController {
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var catwalk: UIImageView!
    @IBOutlet var loginview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        login.layer.cornerRadius = 12
        catwalk.layer.cornerRadius = 15
        // Do any additional setup after loading the view.
    }
    

    @IBAction func login(_ sender: Any) {
       // presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        
        let temail=email.text
                let tpass=pass.text
                let emi=isValidEmailAddress(emailAddressString: temail!)
                
                if(!(temail?.isEmpty)! && !(tpass?.isEmpty)!){
                    if(emi==true){
                        
                        
                        
                            Auth.auth().signIn(withEmail: temail!, password: tpass!, completion: {(user,error)in
                                if error == nil {
                                    
                                    if let user = Auth.auth().currentUser{
                                        if user.isEmailVerified == false{
                                            self.alertView(message: "please verify email")
                                        }else{
                                            let alert = UIAlertController(title: "Hi User", message:"success login" ,preferredStyle: .alert)
                                            
                                            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                                                self.presentingViewController?.dismiss(animated: true, completion: nil)
                                                
                                            }
                                            
                                            alert.addAction(OKAction)
                                            
                                            self.present(alert, animated: true, completion:nil)
                                        }
                                    }
                                }else{
                                    let alert = UIAlertController(title: "Hi User", message:"\(error?.localizedDescription)" ,preferredStyle: .alert)
                                    
                                    let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                                        self.presentingViewController?.dismiss(animated: true, completion: nil)
                                        
                                    }
                                    
                                    alert.addAction(OKAction)
                                    
                                    self.present(alert, animated: true, completion:nil)
                                    
                                }
                            })
                        
                    }else{
                        alertView(message: "Please enter valid email")
                    }
                }else{
                    alertView(message: "please must fill all field")
                }
    }
    
    @IBAction func reset(_ sender: Any) {
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
                         let reset = storyboard.instantiateViewController(withIdentifier: "resetPassViewController") as! resetPassViewController
        navigationController?.pushViewController(reset, animated: true)
               
    }
    
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    
    //this function for alert message
    func alertView(message:String){
        let alert = UIAlertController(title: "Hi User", message:message ,preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            
            
        }
        
        alert.addAction(OKAction)
        
        self.present(alert, animated: true, completion:nil)
    }
    
}
